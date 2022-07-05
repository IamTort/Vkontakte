//
//  ImageLoaderHelper.swift
//  Pozolotina_VK
//
//  Created by angelina on 04.07.2022.
//

import UIKit

final class ImageLoaderHelper {
    private let cacheService: ImageCacheService = ImageCacheService()
    private let loaderService: ImageLoaderService = ImageLoaderService()
    
//    загрузка в UI?
    func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: url) else {return}
        if let image = cacheService.getImage(for: url) {
            completion(image)
        }
        loaderService.loadImage(url: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                self.cacheService.saveImage(image, with: url)
                completion(image)
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }
}
