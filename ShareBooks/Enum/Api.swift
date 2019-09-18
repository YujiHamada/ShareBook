//
//  Api.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/11.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

enum Api {
    
    case signupin
    
    func parameterKey() -> String {
        switch self {
        case .signupin:
            return ""
        }
    }
    
    func url() -> String {
        switch self {
        case .signupin:
            return domain() + "/user/signupin"
        }
    }
    
    func domain() -> String {
        return "http://192.168.1.5"
    }
}
