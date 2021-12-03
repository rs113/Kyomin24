//
//  ProfileReviews_TableViewCell.swift
//  Kyomin24
//
//  Created by emizen on 12/2/21.
//

import UIKit

class ProfileReviews_TableViewCell: UITableViewCell {

    @IBOutlet weak var ReviewMessage: UILabel!
    @IBOutlet weak var ReviewTime: UILabel!
    @IBOutlet weak var ReviewName: UILabel!
    @IBOutlet weak var ReviewsImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
