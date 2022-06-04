//
//  File.swift
//  Pozolotina_VK
//
//  Created by angelina on 27.04.2022.
//


import UIKit

class LikeControlForNews: UIControl {

    @IBOutlet var likePictire: UIImageView!
    
    var isLike: Bool = false
    
    override func awakeFromNib() {
//        likePictire.backgroundColor = .clear
        likePictire.tintColor = .gray
        
        
    }

    
    
}
