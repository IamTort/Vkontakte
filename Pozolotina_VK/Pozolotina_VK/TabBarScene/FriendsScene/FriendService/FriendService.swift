//
//  FriendService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation

enum ServiceError: Error {
    case serviceUnvailable
    case decodingError
}


final class FriendService {
    
    func loadUsers(completion: @escaping((Result<Response, ServiceError>) -> ())) {
        
        guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        //поиск по друзьям, показывает только used id друзей
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "v", value: "5.131"),
            //добавляет информацию по каждому другу
            URLQueryItem(name: "fields", value: "first_name"),
            URLQueryItem(name: "fields", value: "photo_50")
        ]
        
        guard let url = urlComponents.url else {return}
        
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
                let result = try JSONDecoder().decode(Response.self, from: data)
               
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
