//
//  SearchGroupService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Все группы"
final class SearchGroupService {
    
    func loadSearchGroups(searchText: String?, completion: @escaping((Result<ResponseGroup, ServiceError>) -> ())){
        
        guard let token = SessionSinglton.instance.token else { return }
        //текст введенный в searchBar контроллера
        guard let text = searchText else {return}
        
        let params = ["q": text,
                      "v": "5.131",
                      "fields": "first_name, photo_50"]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/groups.search", params: params)
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ResponseGroup.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
}
