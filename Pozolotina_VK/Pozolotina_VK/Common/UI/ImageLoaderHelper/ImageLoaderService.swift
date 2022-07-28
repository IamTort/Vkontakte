//
//  ImageLoaderService.swift
//  Pozolotina_VK
//
//  Created by angelina on 04.07.2022.
//

import Foundation

final class ImageLoaderService {
    //создаем сессию, выполняется только при вызове
    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
//  второй вариант как грузить картинки
    func loadImage(url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        let completionOnMain: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
//        ассинхронное выполнение, очередь глобальная, qos - приоретизация выполнение, утилити- одна из низших приоритетов выполнения
        DispatchQueue.global(qos: .utility).async {
            self.session.dataTask(with: url) { data, _, error in
                guard let data = data,
                      error == nil
                else {
                    if let error = error {
                        completionOnMain(.failure(error))
                    }
                    return
                }
                completionOnMain(.success(data))
            }.resume()
        }
    }
}
