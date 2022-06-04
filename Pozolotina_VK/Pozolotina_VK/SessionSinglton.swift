//
//  SessionSinglton.swift
//  Pozolotina_VK
//
//  Created by angelina on 29.05.2022.
//

import Foundation

final class SessionSinglton {
    
    static let instance = SessionSinglton()
    
    private init() {}
    
    var token: String?
    var userId: Int?

}



