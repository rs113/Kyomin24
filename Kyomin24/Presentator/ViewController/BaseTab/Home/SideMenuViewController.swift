//
//  SideMenuViewController.swift
//  Mzadi
//
//  Created by Emizentech on 23/08/21.
//

import UIKit
import SDWebImage

class SideMenuViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var Tblsidemenu: UITableView!
    
     var ArrUserProfile:GetProfileModel?
    
    var Arrmenuname=["Add advertise","My ads","Favorites","Follow/Following","My Plan","Blocked Users","Chat","Support chat & help center","Language","Change Mode","About Mzadi","Share Mzadi","Privacy Policy","Terms And Conditions"]
    
    var Arrmenuimg = ["advertise","myAdd","favorite","about","about","about","block","support","language","mode","about","share","privacy","term"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
      GetMyProfile()
    }
    func GetMyProfile(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.SendRequestServerPostWithHeaderModel(url: UserMyProfileUrl,ReqMethod: .post, dictParameter: dictParam, responseObject: GetProfileModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrUserProfile = resModel
                self.username.text = self.ArrUserProfile?.data?.name
                self.userimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.userimg.sd_setImage(with: URL(string:self.ArrUserProfile?.data?.profileImage ?? ""), placeholderImage: UIImage(named: ""))
            }else{
                
            }
        }) { (stError) in
            
        }
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrmenuname.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        cell.lblname.text = Arrmenuname[indexPath.row]
        cell.menuimg.image = UIImage(named: Arrmenuimg[indexPath.row])


//        if menuList[indexPath.section].list[indexPath.row].text == "Change Mode" {
//            cell.btnswitch.isHidden=false
//
//        } else {
//            cell.btnswitch.isHidden=true
//        }
//
//
//        cell.btnswitch.tag=indexPath.row
//        cell.btnswitch.addTarget(self, action: #selector(Settheme(sender:)), for: .touchUpInside)
//
        //
        //                if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
        //                 cell.bgView.backgroundColor = UIColor(red: 56/255, green: 54/255, blue: 74/255, alpha: 1)
        //
        //                } else {
        //                 cell.bgView.backgroundColor = UIColor.white
        //                      }
        //


        // cell.lblText.textColor = UIColor.darkGray

        cell.selectionStyle = .gray
       // cell.imgList.image = UIImage(named: "\(menuList[indexPath.section].list[indexPath.row].img!)")

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (callBack != nil) {
//            self.showSideMenu(false)
//            SideMenuView.selectIndex = menuList[indexPath.section].list[indexPath.row].type
//            callBack(menuList[indexPath.section].list[indexPath.row].type)
//        }
        
        switch indexPath.row {
        case 0:
             let vc = SelectAdTypeViewController.instance(.newAdTab) as! SelectAdTypeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
           let favoriteVC = FavoriteViewController.instance(.moreMenu) as! FavoriteViewController
             self.navigationController?.pushViewController(favoriteVC, animated: true)
            
//        case 2:
//
//        case 3:
//
        case 8 :
            let favoriteVC = SelectlanguageView.instance(.newAdTab) as! SelectlanguageView
                self.navigationController?.pushViewController(favoriteVC, animated: true)
            
        default:
            return
        }
    }
    
//    func openSideMenu() {
//
//        SideMenuView.initialize { [weak self] (selection) in
//
//            guard let weakSelf = self else { return }
//            switch selection {
//            case .addAdvertise:
//                let vc = SelectAdTypeViewController.instance(.newAdTab) as! SelectAdTypeViewController
//                 let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(vc, animated: true)
//
//            case .myAdd:
//                let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
//                let navc = self?.selectedViewController as? UINavigationController
//                    navc?.pushViewController(vc, animated: true)
//
//
//            case .favorite:
//                let favoriteVC = FavoriteViewController.instance(.moreMenu) as! FavoriteViewController
//                 let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(favoriteVC, animated: true)
//
//
//            case .follow:
//
//                let followVC = FollowViewController.instance(.moreMenu) as! FollowViewController
//                 let navc = self?.selectedViewController as? UINavigationController
//                    navc?.pushViewController(followVC, animated: true)
//
//            case .block:
//                let followVc = BlockUserViewController.instance(.moreMenu) as! BlockUserViewController
//
//                 let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(followVc, animated: true)
//
//            case .chat:
//                break
//
//            case .support:
//                break
//
//            case .language:
//                let aboutVC = SelectlanguageView.instance(.newAdTab) as! SelectlanguageView
//                let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(aboutVC, animated: true)
//
//            case .mode:
//                break
//
//            case .about:
//                let aboutVC = AboutViewController.instance(.moreMenu) as! AboutViewController
//                 let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(aboutVC, animated: true)
//
//            case .share:
//
//                let shareVC = ShareViewController.instance(.moreMenu) as! ShareViewController
//                let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(shareVC, animated: true)
//
//            case .privacy:
//                let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
//                vc.viewFrom = .privacy
//                let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(vc, animated: true)
//            case .terms:
//                let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
//                vc.viewFrom = .terms
//                let navc = self?.selectedViewController as? UINavigationController
//                navc?.pushViewController(vc, animated: true)
//                //weakSelf.navigationController?.setViewControllers([vc], animated: true)
//
//            default:
//                break
//            }
//        }
//    }
//
    

}


