//
//  tbl_Chat_buddy_Cell.swift
//  Walkys
//
//  Created by emizen on 23/09/20.
//  Copyright © 2020 emizen. All rights reserved.
//

import UIKit

class tbl_Chat_buddy_Cell: UITableViewCell {
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lblBuddyName: UILabel!
    @IBOutlet weak var height_Const_lblName: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
