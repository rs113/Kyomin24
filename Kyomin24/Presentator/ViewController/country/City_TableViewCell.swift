//
//  City_TableViewCell.swift
//  Kyomin24
//
//  Created by emizen on 11/24/21.
//

import UIKit

class City_TableViewCell: UITableViewCell {

    @IBOutlet weak var CityLbl: UILabel!
    @IBOutlet weak var CityRadio: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
