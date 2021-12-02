//
//  PurchaseTableViewCell.swift
//  Mzadi
//
//  Created by Emizentech on 21/10/21.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblgovip: UILabel!
    @IBOutlet weak var lblmostview: UILabel!
    @IBOutlet weak var lblunlimitedtext: UILabel!
    @IBOutlet weak var lblfeature: UILabel!
    @IBOutlet weak var btnpurchase: UIButton!
    @IBOutlet weak var lblplantype: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblplanmonth: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        lblgovip.text="GO VIP".localized()
        lblunlimitedtext.text="Unlimited free Ad post.".localized()
        lblmostview.text="Most Views to your Ad.".localized()
        btnpurchase.setTitle("Purchase".localized(), for: .normal)
        
    }

}
