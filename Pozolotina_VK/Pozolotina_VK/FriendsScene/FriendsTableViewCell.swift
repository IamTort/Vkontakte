//
//  FriendsCell.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet var friendsName: UILabel!
    @IBOutlet var friendsImageView: AvatarsView!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        friendsImageView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func handleTap(_: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        }
        containerView.transform = .identity
    }

}
