//
//  AccessTokenAdapter.swift
//  ineocoin
//
//  Created by Huy Lam on 12/8/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Alamofire

class AccessTokenAdapter: RequestAdapter, RequestRetrier {
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    
    private let lock = NSLock()
    
    private var accessToken: String
    private var refreshToken: String
    private let baseURL: String
    
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    // MARK: - Initialization
    
    public init(baseURL: String, accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.baseURL = baseURL
        self.refreshToken = refreshToken
    }
    
    // MARK: - RequestAdapter
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURL) {
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            return urlRequest
        }
        
        return urlRequest
    }
    
    // MARK: - RequestRetrier
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    
                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        strongSelf.accessToken = accessToken
                        strongSelf.refreshToken = refreshToken
                        
                        // Save to keychain
                        KeychainHelper.shared.setAppToken(token: accessToken)
                        KeychainHelper.shared.setRefreshToken(token: refreshToken)
                        
                        MyApplication.appToken = accessToken                        
                    }
                    
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        // Retrieve Okta plist
        guard let path = Bundle.main.path(forResource: "Okta", ofType: "plist"),
            let dictionary =  NSDictionary(contentsOfFile: path),
            let clientId = dictionary["clientId"],
            let issuer = dictionary["issuer"] else {
                return
        }
        
        let urlString = "\(issuer)/oauth2/v1/token"
        
        // Add Headers
        let headers = [
            "Content-Type":"application/x-www-form-urlencoded; charset=utf-8",
            ]
        
        // Form URL-Encoded Body
        let body = [
            "client_id":clientId,
            "grant_type":"refresh_token",
            "refresh_token":refreshToken,
            ]
        Alamofire.request(urlString,
                          method: .post,
                          parameters: body,
                          encoding: URLEncoding.default,
                          headers:headers)
            .validate()
            .responseJSON { [weak self] response in
                
                guard let strongSelf = self else { return }
                
                if
                    let json = response.result.value as? [String: Any],
                    let accessToken = json["access_token"] as? String,
                    let refreshToken = json["refresh_token"] as? String
                {
                    completion(true, accessToken, refreshToken)
                } else {
                    completion(false, nil, nil)
                }
                
                strongSelf.isRefreshing = false
        }
        
    }
}

