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
    case createGroup
    case groupList
    case registerBook
    case myBookList
    
    func parameterKey() -> String {
        switch self {
        case .signupin:
            return ""
        case .createGroup:
            return ""
        case .groupList:
            return "groups"
        case .registerBook:
            return ""
        case .myBookList:
            return "books"
        }
    }
    
    func url() -> String {
        switch self {
        case .signupin:
            return domain() + "/user/signupin"
        case .createGroup:
            return domain() + "/group/create"
        case .groupList:
            return domain() + "/user/groups"
        case .registerBook:
            return domain() + "/book/register"
        case .myBookList:
            return domain() + "/book/list"
        }
    }
    
    func domain() -> String {
        return "http://192.168.1.5"
    }
}
