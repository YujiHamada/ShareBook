//
//  UIColor+hex.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    open class var positiveColor: UIColor {
        return UIColor(hex: "3782D6")
    }
    
    open class var yInMnBlue: UIColor {
        return UIColor(hex: "2D4998")
    }
    
    open class var alabaster: UIColor {
        return UIColor(hex: "F5EDE3")
    }
    
    open class var bone: UIColor {
        return UIColor(hex: "DEDECE")
    }
    
    open class var silverFoil: UIColor {
        return UIColor(hex: "B5BCA7")
    }
}
