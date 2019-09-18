//
//  UIAlertController+Simple.swift
//  poipoi
//
//  Created by ipoca84 on 2019/07/16.
//  Copyright © 2019 ipoca84. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func simpleOkAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
}
