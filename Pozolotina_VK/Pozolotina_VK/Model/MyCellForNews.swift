//
//  MyCell.swift
//  Pozolotina_VK
//
//  Created by angelina on 28.04.2022.
//

import UIKit

class MyCellForNews: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    @IBOutlet weak var avaImage: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var shareView: UIView!
   
    @IBOutlet weak var likeView: LikeControlForComment!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var likeViewTap: UIView!
    
    @IBOutlet weak var loveLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avaImage.layer.cornerRadius = avaImage.frame.size.width / 2
        avaImage.layer.masksToBounds = true
        likeViewTap.layer.cornerRadius = 10
        shareView.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        likeViewTap.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func handleTap(_: UITapGestureRecognizer) {
        likeView.isLike.toggle()
        
        if likeView.isLike {
            likeViewTap.backgroundColor = #colorLiteral(red: 0.9078575083, green: 0.6176608387, blue: 0.6394784387, alpha: 1)
            likeView.likePictire.image =  UIImage(systemName: "heart.circle.fill")
            likeView.likePictire.tintColor = .red
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.3,
                           initialSpringVelocity: 1,
                           options: .curveEaseInOut) {
                self.likeView.likePictire.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            }
            likeView.likePictire.transform = .identity
            
            loveLabel.textColor = .red
            touches += 1
        } else {
            likeViewTap.backgroundColor = #colorLiteral(red: 0.8803344369, green: 0.8800782561, blue: 0.9019152522, alpha: 1)
            likeView.likePictire.image = UIImage(systemName: "heart")
            likeView.likePictire.tintColor = .gray
            loveLabel.textColor = .gray
            touches -= 1
        }
    }
    
    var touches = newCell[0].touches {
        didSet{
            countLabel.text = "\(touches)"
            
        }
    }
}

class LikeControlForComment: UIControl {
    
    @IBOutlet weak var likePictire: UIImageView!
    
    var isLike: Bool = false
    
    override func awakeFromNib() {
//        likePictire.backgroundColor = .clear
        likePictire.tintColor = .gray
        
    }
}
