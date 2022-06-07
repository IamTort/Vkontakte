//
//  SessionSinglton.swift
//  Pozolotina_VK
//
//  Created by angelina on 29.05.2022.
//

import Foundation


//MARK: - синглтон для хранения данных о текущей сесии
final class SessionSinglton {
    
    static let instance = SessionSinglton()
    
    private init() {}
    var token: String?
    var userId: Int?

}



