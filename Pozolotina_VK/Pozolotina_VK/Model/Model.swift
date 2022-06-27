//
//  Model.swift
//  Pozolotina_VK
//
//  Created by angelina on 19.04.2022.
//

import UIKit
import RealmSwift

class Group {
    let image: UIImage?
    let name: String
    
    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}


class User {
    
    init(name: String?, image: String?, id: Int?) {
        self.image = image ?? ""
        self.name = name ?? ""
        self.id = id ?? 0
    }
    
    var image: String = ""
     var name: String = ""
     var id: Int = 0
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

struct Photo {
    let photos: [String?]
}
