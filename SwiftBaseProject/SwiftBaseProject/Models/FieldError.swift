//
//  FieldError.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 3/22/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import Foundation

struct FieldError: Decodable {
    var field: String
    var message: String
    var objectName: String
}
