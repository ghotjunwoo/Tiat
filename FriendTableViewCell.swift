
//
//  FriendTableViewCell.swift
//  Tiat
//
//  Created by 이종승 on 2016. 9. 3..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet var cx: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusColor: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
