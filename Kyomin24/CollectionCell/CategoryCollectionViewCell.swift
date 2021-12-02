//
//  CategoryCollectionViewCell.swift
//  Mzadi
//
//  Created by Emizentech on 12/08/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryview: UIView!
//    @IBOutlet var ServiceButton: [UIButton]!
//    @IBOutlet var lblcollection: [UILabel]!
//    @IBOutlet var ImgSubCollection: [DesignableImageView]!
    @IBOutlet var OthersCategoryButton: [UIButton]!
    @IBOutlet var OtherslabelCollection: [UILabel]!
    @IBOutlet var OthersImgCollection: [UIImageView]!
    
    @IBOutlet weak var BackviewOthers: UIView!
//    @IBOutlet weak var Backview: UIView!
    @IBOutlet weak var lblcategoryname: UILabel!
    @IBOutlet weak var CategoryImg: UIImageView!
}
