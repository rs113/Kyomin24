//
//  ProductSellerTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit

class ProductSellerTblCell: UITableViewCell {
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFollower: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var Btnreport: UIButton!
    
    @IBOutlet weak var lblsellerprofilehint: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblsellerprofilehint.text="Seller Profile".localized()
        Btnreport.setTitle("Report".localized(), for: .normal)
        btnContact.setTitle("Contact".localized(), for: .normal)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

