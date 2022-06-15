//
//  User.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
import UIKit


struct UserDto: Decodable {
    let id: Int
    var trackCode: String
    var photoUri: String?
    var firstName: String
    var lastName: String
    var isClosed: Bool?

    
    enum CodingKeys: String, CodingKey {
        case id
        case trackCode = "track_code"
        case photoUri = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
    }
    

    
}

struct FriendsResponseDto: Decodable {
    var count: Int
    var items: [UserDto]
    
}


struct Response: Decodable {
    let response: FriendsResponseDto
}
