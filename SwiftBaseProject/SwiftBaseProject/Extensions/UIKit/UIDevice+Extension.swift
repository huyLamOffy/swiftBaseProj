//
//  UIDevice.swift
//  ineocoin
//
//  Created by Quang Luu on 1/15/18.
//  Copyright © 2018 Engie Ineo. All rights reserved.
//
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if arch(i386) || arch(x86_64)
            return true
        #else
            return false
        #endif
    }
}
