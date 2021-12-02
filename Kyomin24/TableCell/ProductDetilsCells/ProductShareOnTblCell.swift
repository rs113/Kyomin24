//
//  ProductShareOnTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit

class ProductShareOnTblCell: UITableViewCell {
    
    @IBOutlet weak var lblcoomentshint: UILabel!
    @IBOutlet weak var lblshareonhint: UILabel!
    @IBOutlet weak var lblcopy: UILabel!
    @IBOutlet weak var imgcopy: UIImageView!
    @IBOutlet weak var BtnPostComment: UIButton!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var btntelegram: UIButton!
    @IBOutlet weak var btnfacebook: UIButton!
    @IBOutlet weak var btntwitter: UIButton!
    @IBOutlet weak var btninstagram: UIButton!
    @IBOutlet weak var btnwhatsapp: UIButton!
    @IBOutlet weak var btncopylink: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    lblshareonhint.text="Share On".localized()
        btnReport.setTitle("Report Ad".localized(), for: .normal)
        BtnPostComment.setTitle("Post Comment".localized(), for: .normal)
        lblcoomentshint.text="Comments".localized()
        lblcopy.text="Copy Link".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
