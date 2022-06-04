//
//  PhotoCell.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet var likeControle: LikeControl!
    @IBOutlet var containerView: UIView!
    
    override  func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 2
        containerView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_: UITapGestureRecognizer) {
        likeControle.isLike.toggle()
        
        if likeControle.isLike {
            likeControle.likePictire.image = UIImage(systemName: "suit.heart.fill")
            countLabel.textColor = .red
            touches += 1
        } else {
            likeControle.likePictire.image = nil
            countLabel.textColor = .black
            touches -= 1
        }
    }
    
    @IBOutlet weak var countLabel: UILabel!
    
    var touches = 0 {
        didSet{
            countLabel.text = "\(touches)"
            
        }
    }
}
