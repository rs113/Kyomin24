//
//  ItemTableCell.swift
//  Mzadi
//
//  Created by Emizen tech on 17/08/21.
//

import UIKit

class ItemTableCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var lbladdavailablehint: UILabel!
    @IBOutlet weak var lblfeatured: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblEye: UILabel!
    @IBOutlet weak var lblIQD: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var languageview: UIView!
    @IBOutlet weak var Btnarabic: UIButton!
    @IBOutlet weak var Btnenglish: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbladdavailablehint.text="This Ad is Available in".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
