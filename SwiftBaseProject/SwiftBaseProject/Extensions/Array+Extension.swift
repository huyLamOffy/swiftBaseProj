//
//  Array+Extension.swift
//  ineocoin
//
//  Created by Quang Luu on 1/24/18.
//  Copyright © 2018 Engie Ineo. All rights reserved.
//

import Foundation

extension Array {
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
}
