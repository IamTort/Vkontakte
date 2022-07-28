//
//  ImageCacheService.swift
//  Pozolotina_VK
//
//  Created by angelina on 04.07.2022.
//

import UIKit

//для кеширования картинок
final class ImageCacheService {
//    зашли на экран, закешировали 40 картинок, положили их в imageCache
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 40
        return cache
    }()
    
    func getImage(for url: URL) -> UIImage? {
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            return image
        } else {
            return nil
        }
    }
    
    func saveImage(_ image: UIImage?, with url: URL) {
        guard let image = image else { return }
        imageCache.setObject(image as AnyObject, forKey: url as AnyObject)
    }
    
    func deleteImage(for url: URL) {
        imageCache.removeObject(forKey: url as AnyObject)
    }
    
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
