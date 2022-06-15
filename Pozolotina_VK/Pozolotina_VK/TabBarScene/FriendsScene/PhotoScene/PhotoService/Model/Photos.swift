//
//  Photos.swift
//  Pozolotina_VK
//
//  Created by angelina on 07.06.2022.
//

import Foundation

struct ResponsePhoto: Decodable {
    let response: Items
}

struct Items: Decodable {
    let items: [Sizes]
}

struct Sizes: Decodable {
    let sizes: [PhotoInfoDto]
}

struct PhotoInfoDto: Decodable {
    let url: String
    let type: String
}
