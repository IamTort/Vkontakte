//
//  RealmCacheService.swift
//  Pozolotina_VK
//
//  Created by angelina on 28.06.2022.
//

import Foundation
import RealmSwift

final class RealmCacheService {
//    метод для записи в базу данных реалм одного объекта
    func create<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
//    метод для записи в базу данных реалм нескольких объектов
    func create<T: Object>(_ object: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
//    метод для чтения из базы данных реалм
    func read<T: Object>(_ object: T.Type) -> Results<T> {
            let realm = try! Realm()
            return realm.objects(object)
    }
}
