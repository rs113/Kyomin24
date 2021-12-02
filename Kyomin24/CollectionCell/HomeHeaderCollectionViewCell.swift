//
//  HomeHeaderCollectionViewCell.swift
//  Mzadi
//
//  Created by A Care Indore on 07/07/21.
//

import UIKit

class HomeHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblnamecat: UILabel!
    @IBOutlet weak var carimg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar" || obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
        contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }else{
            contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
          
        }
    }
}
