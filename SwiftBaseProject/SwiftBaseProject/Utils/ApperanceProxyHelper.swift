//
//  ApperanceProxyHelper.swift
//  plaapping
//
//  Created by glory luu on 4/22/17.
//  Copyright © 2017 Officience. All rights reserved.
//

import UIKit

struct ApperanceProxyHelper {
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.tintColor = UIColor.white //change font, image, back button color
        navigationBarAppearace.barTintColor = ColorPalette.navigationBar
        navigationBarAppearace.shadowImage = UIImage()
        navigationBarAppearace.setBackgroundImage(ColorPalette.navigationBar.toImage(), for: UIBarMetrics.default)
        
        
    }
}
