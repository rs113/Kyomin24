//
//  SideMenuTableViewCell.swift
//  Mzadi
//
//  Created by Emizentech on 23/08/21.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var menuimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
