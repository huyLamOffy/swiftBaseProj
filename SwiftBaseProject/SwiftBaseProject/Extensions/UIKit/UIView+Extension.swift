//
//  UIView+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/6/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import UIKit

extension UIView {
    // Load view from nib
    public class func loadFromNib(named name: String? = nil, bundle : Bundle? = nil) -> UIView? {
        return UINib(nibName: name ?? "\(self)", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
