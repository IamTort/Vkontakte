//
//  NewAvatars.swift
//  Pozolotina_VK
//
//  Created by emil kurbanov on 26.04.2022.
//

import Foundation
import UIKit

// @IBDesignable - помнб у нас был спор по данному методу, однако, он полезен при составлении сложных интерфейсов
// например, где надо менять цвета и визуально воспринимать , ну и тд...
// Если его раскоммитить , то будет выдавать ошибку, но не обращай внимание, проект всеравно сбилдится...
// @IBDesignable 
class AvatarsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAvatarView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAvatarView()
    }
 
    let avatarImage: UIImageView = UIImageView(image: UIImage(systemName: "person"))

    
    func setupAvatarView(){
        // настройка основной вьюхи, где тень
        frame = CGRect(x: 10, y: frame.midY-25, width: 50, height: 50)
        backgroundColor = UIColor.white
        layer.cornerRadius = CGFloat(self.frame.width / 2)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize.zero
        
        // настройка авы
        avatarImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.layer.cornerRadius = CGFloat(self.frame.width / 2)
        avatarImage.layer.masksToBounds = true
        
        self.addSubview(avatarImage)
    }
    
    
}
