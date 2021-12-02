//
//  ChatView.swift
//  Mzadi
//
//  Created by Emizentech on 04/10/21.
//

import UIKit
import Localize_Swift

class ChatView: UIViewController {

    @IBOutlet weak var btnback: UIButton!
        @IBOutlet weak var tblMessage: UITableView!
        
        var arrChat = [ChatModelData]()

        override func viewDidLoad() {
            super.viewDidLoad()
        
            if Localize.currentLanguage() == "ar" {
                        self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
            }else{
                     self.btnback.transform=CGAffineTransform(rotationAngle:0)
                }
            setChatData()
        }

        func setChatData() {
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (5) 1"), title: "Toyota Land Cruiser", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (5) 1-1"), title: "Saddam Hussein", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: "1"))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (11) 1"), title: "Ibrahim Awad ", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: "1"))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "0be365bc0390814b7285013c6520ab5b 1"), title: "Adel Abdul Mahdi", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "20122703544266f1 1"), title: "Mohammed Zurfi", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (5) 1"), title: "Toyota Land Cruiser", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (5) 1-1"), title: "Saddam Hussein", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: "1"))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (11) 1"), title: "Ibrahim Awad ", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: "1"))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "0be365bc0390814b7285013c6520ab5b 1"), title: "Adel Abdul Mahdi", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "20122703544266f1 1"), title: "Mohammed Zurfi", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (5) 1"), title: "Toyota Land Cruiser", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (5) 1-1"), title: "Saddam Hussein", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: "1"))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "images (11) 1"), title: "Ibrahim Awad ", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: "1"))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "0be365bc0390814b7285013c6520ab5b 1"), title: "Adel Abdul Mahdi", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))
            arrChat.append(ChatModelData(img: #imageLiteral(resourceName: "20122703544266f1 1"), title: "Mohammed Zurfi", subTitle: "Toyota car price is?", time: "5:30 PM", badgeValue: nil))

        }
        
        @IBAction func btnback(_ sender: Any) {
            self.tabBarController?.selectedIndex=0
            self.dismiss(animated: true, completion: nil)
              
            }
            
            }
           
            

    extension ChatView: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrChat.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatViewTableViewCell.self), for: indexPath) as! ChatViewTableViewCell
            cell.setData(chatDict: arrChat[indexPath.row])
            return cell
        }
    }

    extension ChatView: UITableViewDelegate {
        
        //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          //  return UITableView.automaticDimension
       // }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc =  Chat_Detail_VC.instance(.moreMenu) as!  Chat_Detail_VC
            self.navigationController?.pushViewController(vc, animated: true)
           
        }
    }


    struct ChatModelData {
        var img: UIImage
        var title: String
        var subTitle: String
        var time: String
        var badgeValue: String?
    }
