//
//  SearchGroupService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation

final class SearchGroupService {
    
    func loadSearchGroups(searchText: String?, completion: @escaping((Result<Resp, ServiceError>) -> ())){
        
        //    guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        //поиск всех групп
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            //        URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "v", value: "5.131"),
            //пишем какие группы искать
            URLQueryItem(name: "q", value: searchText)
        ]
        
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Resp.self, from: data)
                completion(.success(result))
                print(result)
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
}
