//
//  ChatTblCell.swift
//  Mzadi
//
//  Created by Emizentech on 04/10/21.
//

import UIKit

class ChatTblCell: UITableViewCell {
    @IBOutlet weak var OnOfflineView: UIView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLastMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblcount: UILabel!
    @IBOutlet weak var CountView: UIView!
    
    
    var selfUserId=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    selfUserId=obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configData(obj: ChatRoomModel){
            if let individualDetail: UserDetailsModel = ChatListView.userDetailsList[obj.individualUserId] {
                lblName.text = individualDetail.firstName
                imgUserProfile.sd_setImage(with: URL(string:individualDetail.profile_pic), placeholderImage: UIImage(named: ""))
               OnOfflineView.backgroundColor = individualDetail.is_online ? .systemGreen : .systemRed
                
                let value:[String:Any] = obj.tmpunread
                if let valuecount = value[selfUserId]{
                    if valuecount as! Int == 0 {
                        CountView.isHidden=true
                    }else{
                    CountView.isHidden=false
                    lblcount.text="\(valuecount)"
                   print(valuecount)
                    }
                }
                
                
        }
            
            
            
            //2021-04-25T18:05:05.080Z
            print("ChatTableViewCell:: \(obj.last_message_time)")
            
            lblLastMessage.text = obj.last_message
            if let date = obj.last_message_time.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSX") {
                lblTime.text = date.elapsedInterval
            }
   
        }

}

