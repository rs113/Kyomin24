//
//  SearchSuggestionCell.swift
//  Mzadi
//
//  Created by Emizentech on 20/08/21.
//

import UIKit

class SearchSuggestionCell: UITableViewCell {

    @IBOutlet weak var lblsubcategory: UILabel!
    @IBOutlet weak var lblcolor: UILabel!
    @IBOutlet weak var lblmaincategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
