//
//  Collection+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/8/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Foundation
extension Collection {
    public func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
