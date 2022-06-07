//
//  NewsTableViewCell.swift
//  Pozolotina_VK
//
//  Created by angelina on 27.04.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsTextLabel: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsTextLabel.sizeToFit()
        newsImage.sizeToFit()
        containerView.layer.cornerRadius = 10
        commentView.layer.cornerRadius = 10
        shareView.layer.cornerRadius = 10
        avaImage.layer.cornerRadius = avaImage.frame.size.width / 2
        avaImage.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        containerView.addGestureRecognizer(tap)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBOutlet weak var likeControle: LikeControlForNews!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    var touches = 5 {
        didSet{
            countLabel.text = "\(touches)"
            
        }
    }
    
    @objc func handleTap(_: UITapGestureRecognizer) {
        likeControle.isLike.toggle()
        
        if likeControle.isLike {
            
            UIView.transition(with: likeControle,
                              duration: 1,
                              options: .transitionFlipFromRight) {
//                self.likeControle.likePictire.image != nil
            }
            
            
            likeControle.likePictire.image = UIImage(systemName: "suit.heart.fill")
            likeControle.likePictire.tintColor = .red
            countLabel.textColor = .red
            touches += 1
        } else {
            likeControle.likePictire.image = UIImage(systemName: "heart")
            likeControle.likePictire.tintColor = .gray
            countLabel.textColor = .gray
            touches -= 1
        }
    }
    
    @IBOutlet weak var newsNameLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var shareView: UIView!
    
    @IBOutlet weak var avaImage: UIImageView!
    
    @IBOutlet weak var watchCountLabel: UILabel!
    
}
