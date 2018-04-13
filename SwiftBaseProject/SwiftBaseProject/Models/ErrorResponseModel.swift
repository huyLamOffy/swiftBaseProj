//
//  ErrorResponseModel.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 3/22/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation
struct ErrorResponseModel: Decodable {
    var code: Int
    var message: String
    var fieldErrors: [FieldError]
}
extension ErrorResponseModel {
    func error() -> APIError {
        switch code {        
        default:
            return APIError.custom(message: "\(message)\n\(fieldErrors.map{"\($0)"}.joined(separator:"\n"))")
        }
    }
}
