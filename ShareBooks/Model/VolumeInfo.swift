//
//  VolumeInfo.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/23.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

struct VolumeInfo: Codable {
    var title: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var pageCount: Int?
    var categories: [String]?
    var imageLinks: ImageLinks?
    var previewLink: String?
    var infoLink: String?
    var canonicalVolumeLink: String?
    
    
    
}

struct ImageLinks: Codable {
    var smallThumbnail: String?
    var thumbnail: String?
}
