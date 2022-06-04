//
//  FriendsCell.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendsName: UILabel!
    @IBOutlet weak var friendsImageView: AvatarsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
