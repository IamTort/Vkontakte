//
//  FriendService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
import RealmSwift

/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Друзья"
final class FriendService {
//создаем сессию, выполняется только при вызове
    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    // метод для загрузки данных Друзей, throws - для выкидывания ошибок
    func loadUsers() async throws {
//        проверка на то, что токен и ид не нил
        guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
//        передаем параметры для конфигурации ссылки
        let params = ["user_id": "\(id)",
                      "v": "5.131",
                      "fields": "first_name, photo_50"]
//        создаем URL с помощью конфигуратора
        let url: URL = .configureURL(token: token, typeMethod: "/method/friends.get", params: params)
//        делаем запрос
        let request = URLRequest(url: url)
        print(request)
        
        do {
//получаем данные после запроса
            let (data, _) = try await session.data(for: request)
            //print(String(data: data, encoding: .utf8))

            let decoder = JSONDecoder()
//        раскодируем данные
            let result = try decoder.decode(ResponseFriend.self, from: data)
            await saveUserData(users: result.response.items)
        }
    }
}
    
    
extension FriendService {
    //сохранение данных в realm
    func saveUserData(users: [UserDto]) async {
        //конфиг нужен чтоб обнулить данные в реалм
        //let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        // получаем доступ к хранилищу
        if let realm = try? await Realm(/*configuration: config*/) {
            print("REALM file =", realm.configuration.fileURL ?? "")
            do {
                
                try realm.write {
                    // кладем все объекты класса UserDto в хранилище Realm
                    realm.add(users, update: .modified)
                    //realm.deleteAll()
                }
                //если произошла ошибка, выводим в консоль
            } catch let error {
                print("Error Realm: \(error.localizedDescription)")
            }
        }
    }
}

