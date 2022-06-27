//
//  Group.swift
//  Pozolotina_VK
//
//  Created by angelina on 07.06.2022.
//

import UIKit
import RealmSwift

/// Отклик
struct ResponseGroup: Decodable {
    let response: ItemsGroup
}

/// Модель групп
struct ItemsGroup: Decodable {
    /// Массив групп
    let items: [Groups]
}

/// Модель группы
class Groups: Object, Decodable {
    /// Идентификатор
    @objc dynamic var id: Int = 0
    /// Имя группы
    @objc dynamic var name: String = ""
    /// Аватарка группы
    @objc dynamic var image: String = ""
     
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "photo_50"
    }
    
}
 
