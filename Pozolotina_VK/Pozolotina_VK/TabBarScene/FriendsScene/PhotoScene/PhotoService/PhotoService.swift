//
//  PhotoService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
import RealmSwift


/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Фото"
final class PhotoService {

    private let session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    // метод для загрузки данных Фото Друзей
    func loadPhotos(for id: String) async throws {
        //проверка на наличие токена
        guard let token = SessionSinglton.instance.token else { return }
//        передаем параметры для конфигурации ссылки
        let params = [ "v": "5.131",
                       "extended": "1",
                       "owner_id": "\(id)"
        ]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/photos.getAll", params: params)
        
        let request = URLRequest(url: url)
        print(request)
        
        do {
            let (data, _) = try await session.data(for: request)
            //print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResponsePhoto.self, from: data).response.items
            await savePhotoData(photos: result)
        }
    }
}

extension PhotoService {
    //сохранение данных в realm
    func savePhotoData(photos: [Sizes]) async {
        //let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        // получаем доступ к хранилищу
        if let realm = try? await Realm(/*configuration: config*/) {
            print("REALM file =", realm.configuration.fileURL ?? "")
            do {
//                начинаем изменять объекты в хранилище реалм
                try realm.write {
                    // кладем все объекты класса Sizes в хранилище Realm
                    realm.add(photos, update: .modified)
                }
                //если произошла ошибка, выводим в консоль
            } catch let error {
                print("Error Realm: \(error.localizedDescription)")
            }
        }
    }
}
