//
//  UIWindows+Extension.swift
//  ineocoin
//
//  Created by Quang Luu on 1/23/18.
//  Copyright © 2018 Engie Ineo. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func capture() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
        
    }
}
