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
    case groupBookList
    case joinRequest
    case joinRequestList
    case allowJoinRequest
    case denyJoinRequest
    case closeAccount
    case userProfile
    case updateProfile
    
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
        case .groupBookList:
            return "books"
        case .joinRequest:
            return ""
        case .joinRequestList:
            return "users"
        case .allowJoinRequest:
            return ""
        case .denyJoinRequest:
            return ""
        case .closeAccount:
            return ""
        case .userProfile:
            return "user"
        case .updateProfile:
            return ""
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
        case .groupBookList:
            return domain() + "/group/books"
        case .joinRequest:
            return domain() + "/group/request"
        case .joinRequestList:
            return domain() + "/group/request/list"
        case .allowJoinRequest:
            return domain() + "/group/request/allow"
        case .denyJoinRequest:
            return domain() + "/group/request/deny"
        case .closeAccount:
            return domain() + "/user/close"
        case .userProfile:
            return domain() + "/user/profile"
        case .updateProfile:
            return domain() + "/user/update"
        }
    }
    
    func domain() -> String {
        return "http://3.115.103.72"
//        return "http://192.168.1.5"
    }
}
