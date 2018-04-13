//
//  APIRequest.swift
//  ineocoin
//
//  Created by glory luu on 1/18/18.
//  Copyright © 2018 Engie Ineo. All rights reserved.
//

import Alamofire

typealias JSONDictionary = [String: Any]
typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

enum Result<T, U> where U: Error{
    case success(T)
    case failure(U)
}


class APIRequest {
    
    private let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + "network-queue",
                                      qos: .userInitiated,
                                      attributes:.concurrent)
    
    private let sessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    init(with adapter: AccessTokenAdapter) {
        print(self, #function)
        sessionManager.adapter = adapter
        sessionManager.retrier = adapter
    }
    
    deinit {
        print(self, #function)
        sessionManager.session.getAllTasks { (tasks) in
            tasks.forEach{ $0.cancel() }
        }
    }
    
    //MARK: - api methods
    func requestEmptyObject(route: URLRequestConvertible, completion: @escaping (APIError?) -> Void) {
        let request = sessionManager.request(route)
        _ = performEmptyObjectRequest(with: request) { error in
            if error != nil {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func requestObject<T: Decodable>(route: URLRequestConvertible, completion: @escaping (Result<T, APIError>) -> Void) {
        let request = sessionManager.request(route)
        _ = performObjectRequest(with: request, decode: { json -> T? in
            guard let model = json as? T else { return  nil }
            return model
        }, completion: completion)
    }
    
    
}
//MARK: - private methods
extension APIRequest {
    private func performEmptyObjectRequest(with request: DataRequest, completion: @escaping (APIError?) -> Void) {
        request.validate().responseJSON(queue: queue) {[weak self] result in
            //debugPrint(result)
            DispatchQueue.main.async {
                if let error = self?.responseError(result) {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }
    
    private func performObjectRequest<T: Decodable>(with request: DataRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let _ = decodingTask(with: request, decodingType: T.self) { (json , error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
    }
    
    private func decodingTask<T: Decodable>(with request: DataRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> DataRequest {
        let request = request.validate().responseJSON(queue: queue) { response in
            //debugPrint(response)
            if let error = self.responseError(response) {
                completion(nil, error)
                return
            }
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            case .failure(let error):
                debugPrint(error)
                completion(nil, APIError.custom(message: error.localizedDescription))
            }
        }
        return request
    }
    
    private func responseError(_ response: DataResponse<Any>) -> APIError? {
        if let httpStatusCode = response.response?.statusCode,
            httpStatusCode != 200 {
            var error: APIError!
            switch(httpStatusCode) {
            case 400:
                if let data = response.data,
                    let errorModelResponse = try? JSONDecoder().decode(ErrorResponseModel.self, from: data) {
                    error = errorModelResponse.error()
                } else {
                    error = .generic
                }
                break
            case 401:
                error = .unauthorized
            case 403:
                error = .forbidden
            case 404:
                error = .notfound
            case 500:
                error = .internalServerError
            default:
                error = .generic
            }
            return error
        }
        return nil
    }
}

