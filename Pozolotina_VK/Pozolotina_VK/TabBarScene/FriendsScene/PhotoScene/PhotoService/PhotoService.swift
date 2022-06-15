//
//  PhotoService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation

final class PhotoService {

    private let session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    
    func loadPhotos(for id: String, completion: @escaping ([Sizes]) -> Void){
        
        guard let token = SessionSinglton.instance.token else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        //получаем все мои фото по данному методу
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            //если изменить owner_id то покажет фото выбранного друга
            URLQueryItem(name: "owner_id", value: id),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "extended", value: "1")
        ]

        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        print(request)
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ResponsePhoto.self, from: data)
                completion(result.response.items)
                print(result)
            } catch {
                print(error)
            }
        }.resume()
    }
}
