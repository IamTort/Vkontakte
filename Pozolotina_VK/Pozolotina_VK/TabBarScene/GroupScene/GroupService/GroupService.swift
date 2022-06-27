//
//  GroupService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
import RealmSwift

/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Мои группы"
final class GroupService {

    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
   // func loadGroups(completion: @escaping((Result<[Groups], ServiceError>) -> ())){
    func loadGroups() async throws {
        
        guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
        let params = ["user_id": "\(id)",
                      "v": "5.131",
                      "extended": "1"]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/groups.get", params: params)
        
        let request = URLRequest(url: url)
        print(request)
        
        do {
            let (data, _) = try await session.data(for: request)
            //print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResponseGroup.self, from: data)
            await saveGroup(groups: result.response.items)
        }
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error)
//            }
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode(ResponseGroup.self, from: data).response.items
//                //result.forEach {$0.id = id}
//                print("RESULT =", result)
//                self.saveGroupData(groups: result)
//                completion(.success(result))
//            } catch {
//                completion(.failure(ServiceError.decodingError))
//            }
//        }.resume()
    }
}

extension GroupService {
    //сохранение данных в realm
    func saveGroup(groups: [Groups]) async {
        // получаем доступ к хранилищу
        if let realm = try? await Realm() {
            print("REALM file =", realm.configuration.fileURL ?? "")
            do {
//                начинаем запись в хранилище
                try realm.write {
//                    добавляем все объекты класса Groups в хранилище Realm
                    realm.add(groups, update: .modified)
                }
            //если произошла ошибка, выводим в консоль
            } catch let error {
                print("Error Realm: \(error.localizedDescription)")
            }
        }
    }
}
