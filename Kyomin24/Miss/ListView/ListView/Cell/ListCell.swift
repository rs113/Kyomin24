//
//  CountryCodeCellT.swift
//  BoltCustomer
//
//  Created by Mac on 31/01/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpData(selectTypeList: CodeData) {
        lblName.text = selectTypeList.name
        lblCode.text = selectTypeList.code
        imgView.image = selectTypeList.isSelected ? #imageLiteral(resourceName: "selected") : #imageLiteral(resourceName: "unselected")
    } 
}
