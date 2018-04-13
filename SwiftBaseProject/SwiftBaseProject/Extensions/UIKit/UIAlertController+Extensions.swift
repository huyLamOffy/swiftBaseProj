//
//  UIAlertController+Extensions.swift
//  ineocoin
//
//  Created by Huy Lam on 12/11/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Foundation
import UIKit
// Snippet
typealias AlertActionHandler = ((UIAlertAction) -> Void)

extension UIAlertControllerStyle {
    
    func controller(title: String? = nil, message: String? = nil, actions: [UIAlertAction]) -> UIAlertController {
        let _controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: self
        )
        actions.forEach { _controller.addAction($0) }
        return _controller
    }
}

extension String {
    
    func alertAction(style: UIAlertActionStyle = .default, handler: AlertActionHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: self, style: style, handler: handler)
    }
}


