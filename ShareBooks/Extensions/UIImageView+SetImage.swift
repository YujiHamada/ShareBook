//
//  UIImageView+SetImage.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/11/08.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageWithPlaceholder(url: URL?) {
        if let url = url {
            af_setImage(withURL: url)
        } else {
            self.image = UIImage(named: "imageNotAvailable")
        }
        
    }
}
