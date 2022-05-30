//
//  LikeControl.swift
//  Pozolotina_VK
//
//  Created by angelina on 19.04.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet var likePictire: UIImageView!
    
    var isLike: Bool = false
    
    override func awakeFromNib() {
        likePictire.backgroundColor = .clear
        likePictire.tintColor = .red
        
    }

}
