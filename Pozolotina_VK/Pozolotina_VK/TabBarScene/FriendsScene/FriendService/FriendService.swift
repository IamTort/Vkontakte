//
//  FriendService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
import RealmSwift

enum ServiceError: Error {
    case serviceUnvailable
    case decodingError
}

/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Друзья"
final class FriendService {
    
    func loadUsers(completion: @escaping((Result<[UserDto], ServiceError>) -> ())) {
        
        guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
        
        let params = ["user_id": "\(id)",
                      "v": "5.131",
                      "fields": "first_name, photo_50"]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/friends.get", params: params)
        
        let request = URLRequest(url: url)
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
           
            guard let data = data else {
                return
            }
              
            do {
                let result = try JSONDecoder().decode(ResponseFriend.self, from: data).response.items
                //print("result \(result)")
                // не работает с сейвреалм
                //self.saveUserData(users: result)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    
    func saveUserData(users: [UserDto]) {
        
        do {
            let realm = try Realm()
            
            print(realm.configuration.fileURL ?? "")
            
            realm.beginWrite()
            
            realm.add(users/*, update: .modified*/)
            
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
