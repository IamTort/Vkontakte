//
//  AvailableGroups.swift
//  Pozolotina_VK
//
//  Created by angelina on 24.06.2022.
//

import UIKit
import RealmSwift

/// Отклик
struct ResponseAvailableGroup: Decodable {
    let response: ItemsAvailableGroup
}

/// Модель групп
struct ItemsAvailableGroup: Decodable {
    /// Массив групп
    let items: [AvailableGroups]
}

/// Модель группы
class AvailableGroups: Object, Decodable {
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
    
    //уникальный ключ по которому можно проверять объекты и добавлять или удалять их
    override class func primaryKey() -> String? {
        "id"
    }
}

