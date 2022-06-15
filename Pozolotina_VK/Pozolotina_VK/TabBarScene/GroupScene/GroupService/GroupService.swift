//
//  GroupService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation

final class GroupService {
    
    func loadGroups(completion: @escaping((Result<Resp, ServiceError>) -> ())){
        
        guard let id = SessionSinglton.instance.userId else { return }
        guard let token = SessionSinglton.instance.token else { return }
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "extended", value: "1")
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
                let result = try JSONDecoder().decode(Resp.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
