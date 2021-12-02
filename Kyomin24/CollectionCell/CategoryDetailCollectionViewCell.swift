//
//  CategoryDetailCollectionViewCell.swift
//  Mzadi
//
//  Created by A Care Indore on 28/06/21.
//

import UIKit

class CategoryDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //imgView.roundCorners(corners: [.topLeft, .topRight], radius: 6.0)]
       // imgView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]

    }
    
}



class CategoryDetailHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //imgView.roundCorners(corners: [.topLeft, .topRight], radius: 6.0)]
    }
    
}
