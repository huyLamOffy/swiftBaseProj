//
//  UIImage+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/18/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, placeholderImage: UIImage) {
        contentMode = mode
        guard let url = URL(string: link) else {
            image = placeholderImage
            return
        }
        self.kf.setImage(with: url, placeholder: placeholderImage)
    }
}
