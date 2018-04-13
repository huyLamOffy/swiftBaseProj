//
//  Constants.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 3/22/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation
enum Constants {
    private struct BaseURL {
        #if DEBUG
        enum Environment: String {
            case Dev = "http://172.16.0.229:8081"
            case Test = "https://ineo.officience.com"
            case Staging = "https://staging-ineo.officience.com"
            case Release = "http://api.ineo-coins.com"
        }
        
        // Choose your env
        static let environment = Environment.Test.rawValue //we can change this at any time
        
        // #elseif
        
        #else
        
        static let environment = Bundle.main.infoDictionary!  ["MY_API_BASE_URL_ENDPOINT"] as! String
        
        #endif
    }
    static let ServerURL = "\(BaseURL.environment)/api/v1"
    
    enum DateFormat {
        static let long = "dd MMM yyyy"
        static let short = "dd MMM"
    }
}
