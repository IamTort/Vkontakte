//
//  extensions.swift
//  Pozolotina_VK
//
//  Created by angelina on 07.06.2022.
//

import UIKit


extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

///Расширение для добавления фоток по ссылке
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil) {
        self.image = nil
        
        let iconUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: iconUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}


///Paсширение для создания ссылки 
extension URL {
    static func configureURL(token: String,
                               typeMethod: String,
                               params: [String: String]) -> URL {
        var queryItems: [URLQueryItem] = []
        params.forEach { name, value in
            //заполняем массив переданными в функцию параметрами(params)
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        //добавляем в массив токен доступа
        queryItems.append(.init(name: "access_token", value: token))
        
        var components = URLComponents()
        components.scheme = Constants.Service.scheme.rawValue
        components.host = Constants.Service.host.rawValue
        components.path = typeMethod
        components.queryItems = queryItems
        
        guard let url = components.url else { fatalError("")}
        return url
    }
}
