//
//  ProductLocationTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit
import GoogleMaps
import GooglePlaces


class ProductLocationTblCell: UITableViewCell {
    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var btngetdirection: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        btngetdirection.setTitle("Get Direction".localized(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
