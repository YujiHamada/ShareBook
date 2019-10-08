//
//  Book.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/23.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

struct Book: Codable {
    var id: Int!
    var name: String!
    var link: String!
    var isbn: String!
    var description: String!
    var users: [User]?
    
    func imageUrl() -> String{
        var comps = URLComponents(string: link)!
        comps.scheme = "https"
        var https = comps.string!
        https += "&zoom=2"
        return https
    }
}
