//
//  ActivePlanCell.swift
//  Mzadi
//
//  Created by Emizentech on 27/10/21.
//

import UIKit

class ActivePlanCell: UITableViewCell {

    @IBOutlet weak var lblunlimitedtext: UILabel!
    @IBOutlet weak var lblthreevipitext: UILabel!
    @IBOutlet weak var lblmostviewtext: UILabel!
    @IBOutlet weak var lblpurchasedate: UILabel!
    @IBOutlet weak var lblexpire: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblmostviewtext.text="Most views to your Ad.".localized()
        lblunlimitedtext.text="Unlimited Ad Post. ".localized()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
