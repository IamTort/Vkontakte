//
//  File.swift
//  Pozolotina_VK
//
//  Created by angelina on 02.06.2022.
//

import Foundation



//let configuration = URLSessionConfiguration.default
//
//let session = URLSession(configuration: configuration)
//
// 
//let url = URL(string: <#T##String#>)
// 
//
//
//let task = session.dataTask(with: url!) { data, response, error in
//    let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
//
//
//print(json)
//}
//
//task.resume()


//func loadAuth() {
//
//    var urlComponents = URLComponents()
//    urlComponents.scheme = "https"
//    urlComponents.host = "api.vk.com"
//    urlComponents.path = "/method/friends.get"
//    urlComponents.queryItems = [URLQueryItem(name: "user_id", value: "\(SessionSinglton.instance.userId)",
//                                URLQueryItem(name: "access_token", value: SessionSinglton.instance.token),
//                                URLQueryItem(name: "extended", value: "1"),
//                                URLQueryItem(name: "count", value: "3"),
//                                URLQueryItem(name: "fields", value: "city,country"),
//                                             URLQueryItem(name: "v", value: "5.131"),
//                                ]
//
//    guard let url = urlComponents.url else { return }
//    let request = URLRequest(url: url)
//    print(request )
//    webView.load(request)
//
//}
