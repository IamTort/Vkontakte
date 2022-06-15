//
//  GroupService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Мои группы"
final class GroupService {
    
    func loadGroups(completion: @escaping((Result<ResponseGroup, ServiceError>) -> ())){
        
        guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
        let params = ["user_id": "\(id)",
                      "v": "5.131",
                      "extended": "1"]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/groups.get", params: params)
        
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
                let result = try JSONDecoder().decode(ResponseGroup.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
