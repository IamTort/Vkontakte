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
    
   // метод загрузки Моих групп с сервера в реалм
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
//         сохраняем всю пришедшую с сервера информацию в реалм
            await saveGroup(groups: result.response.items)
        }
    }
    
    //метод добавления глобальной группы в мои группы
    func addGroup(id: Int, completion: @escaping (Result<JoinOrLeaveGroup, Constants.Service.ServiceError>) -> Void) {
        guard let token = SessionSinglton.instance.token else { return }
        
        let params = ["group_id": "\(id)",
                      "v": "5.131"]
        let url: URL = .configureURL(token: token,
                                     typeMethod: "/method/groups.join",
                                     params: params)
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(JoinOrLeaveGroup.self, from: data)
                completion(.success(result))
            } catch {
              print(error)
            }
        }.resume()
        
    }
    
    typealias GroupResult = Result<[Groups], Constants.Service.ServiceError>
    
//    метод поиска группы по названию
    func loadSearchGroups(searchText: String?, completion: @escaping (GroupResult) -> ()) {
        
        guard let token = SessionSinglton.instance.token else { return }
        //текст введенный в searchBar контроллера
        guard let text = searchText else {return}
        let params = ["q": text,
                      "v": "5.131",
                      "count": "40",
                      "fields": "first_name, photo_50"]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/groups.search", params: params)
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ResponseGroup.self, from: data)
                completion(.success(result.response.items))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
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
