//
//  Model.swift
//  Pozolotina_VK
//
//  Created by angelina on 19.04.2022.
//

import Foundation
import UIKit

class Group {
    let image: UIImage?
    let name: String
    
    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}


struct User {
    let image: UIImage?
    let name: String
    let photos: [UIImage?]?
    //let friends: [PFriends]
}

struct News {
    let ava: UIImage
    let name: String
    let time: String
    let text: String
    let picture: UIImage
    let touches: Int
    let watches: Int
    
}
