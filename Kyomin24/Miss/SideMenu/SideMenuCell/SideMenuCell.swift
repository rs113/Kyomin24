//
//  SideMenuCell.swift
//  BoltCustomer
//
//  Created by Darshan Mothreja on 2/1/18.
//  Copyright © 2018 Darshan Mothreja. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var btnnotification: UISwitch!
    @IBOutlet weak var btnswitch: UISwitch!
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
