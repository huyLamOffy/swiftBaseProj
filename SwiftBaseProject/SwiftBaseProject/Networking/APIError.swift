//
//  ServiceError.swift
//  network_sample_ios
//
//  Created by Quang Luu on 11/15/17.
//  Copyright © 2017 OFFICIENCE SARL. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case unauthorized
    case forbidden
    case notfound
    case generic
    case internalServerError
    case custom(message: String)
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return NSLocalizedString("requestFailed", comment: "")
        case .invalidData: return NSLocalizedString("invalidData", comment: "")
        case .responseUnsuccessful: return NSLocalizedString("responseUnsuccessful", comment: "")
        case .jsonParsingFailure: return NSLocalizedString("jsonParsingFailure", comment: "")
        case .jsonConversionFailure: return NSLocalizedString("jsonConversionFailure", comment: "")
        case .unauthorized: return NSLocalizedString("unauthorized", comment: "")
        case .forbidden: return NSLocalizedString("forbidden", comment: "")
        case .notfound: return NSLocalizedString("notfound", comment: "")
        case .generic: return NSLocalizedString("generic", comment: "")
        case .internalServerError: return NSLocalizedString("internal_server_error", comment: "")        
        case .custom(let message): return message
        }
    }
}
