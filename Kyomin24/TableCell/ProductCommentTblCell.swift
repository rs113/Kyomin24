//
//  ProductCommentTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit

class ProductCommentTblCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btndelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
