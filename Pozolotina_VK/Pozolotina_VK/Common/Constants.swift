//
//  Constants.swift
//  Pozolotina_VK
//
//  Created by angelina on 14.06.2022.
//

import Foundation

struct Constants {
    enum Service: String {
        enum ServiceError: Error {
            case parseError
            case requestError(Error)
        }
        
        case scheme = "https"
        case host = "api.vk.com"
    }
}

enum ServiceError: Error {
    case serviceUnvailable
    case decodingError
    case urlNotConfigure
}
