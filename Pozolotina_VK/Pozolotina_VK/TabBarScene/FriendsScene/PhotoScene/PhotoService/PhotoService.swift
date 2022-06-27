//
//  PhotoService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation


/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Фото"
final class PhotoService {

    private let session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    
    func loadPhotos(for id: String, completion: @escaping ([Sizes]) -> Void){
        //проверка на наличие токена
        guard let token = SessionSinglton.instance.token else { return }
        
        let params = [ "v": "5.131",
                       "extended": "1",
                       "owner_id": "\(id)"
        ]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/photos.getAll", params: params)
        
        let request = URLRequest(url: url)
        print(request)
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ResponsePhoto.self, from: data)
                completion(result.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
}

