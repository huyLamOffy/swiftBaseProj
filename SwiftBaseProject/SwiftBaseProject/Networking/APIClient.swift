//
//  APIClient.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 4/13/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    private var adapter: AccessTokenAdapter!
    static func sharedInstanceWith(model: APIModel) {
        let instance = APIClient.shared
        instance.adapter = AccessTokenAdapter(baseURL: model.baseUrl,
                                              accessToken: model.token,
                                              refreshToken: model.refreshToken)
    }
}

extension APIClient {
    func makeAPIRequest() -> APIRequest {
        return APIRequest(with: adapter)
    }
}

/*
 apiModel.baseUrl:
 "https://ineo.officience.com/api/v1"
 apiModel.token:
 "eyJraWQiOiI4R2Y5NERLc3lqdmJlUlAySlNpZEZrOW5CM3k2bzB2NGFGb1UyeGZWbUxZIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULmZwaXlNaHBmdWhfT3BJbnY4ZU1TUURhQS1QWmFLWjRPekxJZ2hOblZDM28uYXE0dHdXUzkvcUtOY3lNT3NYUi83RjBndWttUlBhN1MwckxLeEpndkJzbz0iLCJpc3MiOiJodHRwczovL2Rldi00NDc1Njgub2t0YXByZXZpZXcuY29tIiwiYXVkIjoiaHR0cHM6Ly9kZXYtNDQ3NTY4Lm9rdGFwcmV2aWV3LmNvbSIsInN1YiI6ImxpZW1AbWFpbGluYXRvci5jb20iLCJpYXQiOjE1MjM1OTQ2NTksImV4cCI6MTUyMzU5ODI1OSwiY2lkIjoiMG9hZGJkYW1vdEdwMUppc2YwaDciLCJ1aWQiOiIwMHVkbGEwYmR5a2k4YTJxcDBoNyIsInNjcCI6WyJlbWFpbCIsIm9mZmxpbmVfYWNjZXNzIiwicGhvbmUiLCJvcGVuaWQiLCJwcm9maWxlIiwiYWRkcmVzcyJdfQ.MOkK1YAjFCVbUKP1KqRvWJuFTHvkkq4a9VOEPSJosxk1MYoZcrloS5DQhVl-sfiFPkj_twhRn2RK7ZBlLg0vEsfEVnDkVRJtSAb7cgLe4b2WMwsKguokaSeFPole2Axe3EUwDiPUT8qe0bSk9p92sfpYZs1MeX7iDUYz0z9fzTdLQKBPDEHNkJjV8OWj8hCTf-9vvc8SSUSP0TAFCTokYFu3ebVIq2WVJc-QuozQC0rqxzPqNGelRGm2vI25qAGmELXc03rEfXcNSDdY_WJ_P5aYzkiTiplsrDAhsqekQnAej-wYTjvS1LI1UwzxAKUF2WDNkEVAEnX5M6RqITKFng"
 
 Printing description of apiModel.refreshToken:
 "63j1lTpP8a86ZURywFdbWWUmNuYMOUrGPyIdh2lNEus"
 (lldb)
 */
