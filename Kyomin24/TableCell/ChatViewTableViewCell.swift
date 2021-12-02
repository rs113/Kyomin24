//
//  ChatViewTableViewCell.swift
//  Mzadi
//
//  Created by A Care Indore on 23/06/21.
//

import UIKit

class ChatViewTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblBadge: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(chatDict: ChatModelData) {
        lblTime.text = chatDict.time
        lblTitle.text = chatDict.title
        lblSubTitle.text = chatDict.subTitle
        if chatDict.badgeValue == nil {
            lblBadge.isHidden = true
        }else {
            lblBadge.isHidden = false
            lblBadge.text = chatDict.badgeValue
        }
        imgCar.image =  chatDict.img
    }

}
