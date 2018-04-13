//
//  UIStoryboard+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/6/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
}

