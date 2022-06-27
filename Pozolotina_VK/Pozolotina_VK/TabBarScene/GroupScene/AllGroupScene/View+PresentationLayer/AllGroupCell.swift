//
//  NoMyGroupCell.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

class AllGroupCell: UITableViewCell {

    
    @IBOutlet weak var availableGroupImageView: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
