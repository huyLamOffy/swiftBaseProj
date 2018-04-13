//
//  UIColor+Extension.swift
//  ineocoin
//
//  Created by Quang Luu on 1/18/18.
//  Copyright © 2018 Engie Ineo. All rights reserved.
//
import UIKit

extension UIColor{
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
