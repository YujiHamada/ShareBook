//
//  Group.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

struct Group: Codable {
    var id: Int!
    var name: String!
    var inviteCode: String!
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case inviteCode = "invite_code"
    }
}
