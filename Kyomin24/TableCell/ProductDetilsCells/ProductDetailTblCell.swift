//
//  ProductDetailTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit

class ProductDetailTblCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbl: UILabel!

    @IBOutlet weak var lblValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
