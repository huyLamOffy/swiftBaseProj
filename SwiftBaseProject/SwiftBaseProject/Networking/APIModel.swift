//
//  APIModel.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 3/22/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//
class APIModel {
    var baseUrl: String
    var token: String
    var refreshToken: String
    
    init(baseUrl: String = "", token: String = "", refreshToken: String = "") {
        self.baseUrl = baseUrl
        self.token = token
        self.refreshToken = refreshToken
    }
}

