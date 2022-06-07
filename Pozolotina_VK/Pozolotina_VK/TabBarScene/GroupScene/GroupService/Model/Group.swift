//
//  Group.swift
//  Pozolotina_VK
//
//  Created by angelina on 07.06.2022.
//

import Foundation

struct Resp: Decodable {
    let response: ResponseGroup
}

struct ResponseGroup: Decodable {
    let items: [Groups]
}

struct Groups: Decodable {
    let id: Int
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "photo_50"
    }
    
}
 
