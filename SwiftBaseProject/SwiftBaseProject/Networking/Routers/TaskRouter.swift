//
//  TaskRouter.swift
//  ineocoin
//
//  Created by Huy Lam on 12/26/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Foundation
import Alamofire

enum TaskType: String {
    case offers = "OFFERS"
    case requests = "REQUESTS"
    case undetected = ""
}
enum TaskRouter: URLRequestConvertible {
    
    static let baseURLString = "https://ineo.officience.com/api/v1"
    
    case fetchTask(taskType: TaskType, id: String)
    case fetchTasksList(taskType: TaskType, params: Parameters)
    case postTask(taskType: TaskType, params: Parameters)
    case editTask(taskType: TaskType, id: String, params: Parameters)
    case deleteTask(taskType: TaskType, id: String)
    
    var method: HTTPMethod {
        switch self {
        case .fetchTask,
             .fetchTasksList:
            return .get
        case .postTask:
            return .post
        case .editTask:
            return .put
        case .deleteTask(taskType: _, id: _):
            return .delete
        }
        
    }
    
    var path: String {
        switch self {
        case .fetchTask(let taskType, let id),
             .deleteTask(taskType: let taskType, id: let id),
             .editTask(taskType: let taskType, id: let id, params: _):
            return "/\(taskType.rawValue.lowercased())/\(id)"
        case .fetchTasksList(let taskType, _),
             .postTask(let taskType, _):
            return "/\(taskType.rawValue.lowercased())/"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try TaskRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .postTask(_, let params),
             .editTask(taskType: _, id: _, params: let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        case .fetchTasksList(_, let parameters):
            urlRequest = try Alamofire.URLEncoding().encode(urlRequest as URLRequestConvertible, with: parameters)
            
        default:
            break
        }
        
        return urlRequest
    }
}
