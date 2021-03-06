//
//  User.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import UIKit
import RealmSwift

/// Модель друга
class UserDto: Object, Decodable {
    ///Идентификатор
    @objc dynamic var id: Int = 0
    ///Фото аватарки
    @objc dynamic var photoUri: String = ""
    ///Имя
    @objc dynamic var firstName: String = ""
    ///Фамилия
    @objc dynamic var lastName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUri = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

///Модель кол-ва друзей и их массив
struct ItemsFriend: Decodable {
    let count: Int
    let items: [UserDto]
    
}

///Отклик от сервера с массивом друзей
struct ResponseFriend: Decodable {
    let response: ItemsFriend
}
