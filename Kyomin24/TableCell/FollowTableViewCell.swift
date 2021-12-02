//
//  FollowTableViewCell.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.

import UIKit

class FollowingTableViewCell1: UITableViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didTapRemove(_ sender: Any) {
        //self.delegate.didTapRemoveButton(cell: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



protocol FollowTableViewCellDelegate {
    func didTapRemoveButton(cell: FollowTableViewCell)
}

class FollowTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnremove: UIButton!
    
    var delegate :FollowTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnremove.setTitle("Remove".localized(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func Btnremove(_ sender: Any) {
        self.delegate.didTapRemoveButton(cell: self)
    }
}

