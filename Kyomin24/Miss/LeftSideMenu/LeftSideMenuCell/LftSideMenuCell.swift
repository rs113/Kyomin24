//
//  SideMenuCell.swift
//  BoltCustomer
//
//  Created by Darshan Mothreja on 2/1/18.
//  Copyright © 2018 Darshan Mothreja. All rights reserved.
//

import UIKit

class LftSideMenuCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var imgList: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
