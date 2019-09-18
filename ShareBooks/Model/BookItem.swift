//
//  BookItem.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/24.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

struct BookItem: Codable {
    var kind: String?
    var id: String?
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    
    func imageUrl() -> String{
        var comps = URLComponents(string: (volumeInfo?.imageLinks?.thumbnail)!)!
        comps.scheme = "https"
        var https = comps.string!
        https += "&zoom=3"
        return https
    }
}
