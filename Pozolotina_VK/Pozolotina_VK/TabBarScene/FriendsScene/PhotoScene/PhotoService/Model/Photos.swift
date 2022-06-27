 //
//  Photos.swift
//  Pozolotina_VK
//
//  Created by angelina on 07.06.2022.
//

import UIKit
import RealmSwift

/// отклик
struct ResponsePhoto: Decodable {
    let response: Items
}
/// Модель массива с фотографиями
struct Items: Decodable {
    /// массив фотографий
    let items: [Sizes]
}

///Модель массива с размерами фото
struct Sizes: Decodable {
    /// Массив с фотографиями
    let sizes: [PhotoInfoDto]
}

/// Модель фото друга
class PhotoInfoDto: Object, Decodable {
    ///Ссылка для загрузки фото
    @objc dynamic var url: String = ""
    ///Тип фото
    @objc dynamic var type: String = ""
}
