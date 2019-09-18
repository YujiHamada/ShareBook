//
//  ResponseStatus.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/11.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

struct ResponseStatus: Codable{
    var code: String!
    var errorMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case errorMessage = "error_message"
    }
    
    func isSuccess() -> Bool{
        return code == "0000"
    }
}
