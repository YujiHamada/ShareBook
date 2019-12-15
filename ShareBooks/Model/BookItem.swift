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
    
    func imageUrl() -> URL? {
        if let url = volumeInfo?.imageLinks?.thumbnail {
            var comps = URLComponents(string: url)!
            comps.scheme = "https"
            return URL(string: comps.string!)
        }
        return nil
    }
}
