//
//  ChatCell.swift
//  Parse Chat
//
//  Created by Felipe De La Torre on 10/12/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var chatMessageLabel: UILabel!
    //@IBOutlet weak var bubbleView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
