//
//  JoinRequest.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/12.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

struct JoinRequest: Codable {
    var user_id: String!
    var group_id: Int!
}
