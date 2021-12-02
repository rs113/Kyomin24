//
//  FollowViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.
//

import UIKit
import Localize_Swift

class FollowViewController: BaseMoreMenuViewController {
    
    @IBOutlet weak var lblfollowinghint: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var viewFollowing: UIView!
    
    var vctype=""
    var isfollowers = false
    var followId = ""
    var followDictionary: CommonModal?
    var arrFollowing:FollowersModal?
    var arrFollowers:FollowersModal?
    var NoDataView:NoDataScreen?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tabBarController?.tabBar.isHidden=true
        // Do any additional setup after loading the view.
        btnFollow.isSelected = true
        btnFollowing.isSelected = false
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        NoDataView = tblList.ShowCustomNoDataView(noDataMsg: "you are not following any one.".localized())
        
        if btnFollow.isSelected == true {
            followSelected()
        }else {
            followingSelected()
        }
        self.getFollowingApi()
        self.getFollowersApi()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    
    func followSelected() {
        //tblList.isHidden = true
        viewFollowing.isHidden = true
        btnFollowing.setTitleColor(#colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), for: .normal)
        viewFollow.isHidden = false
        btnFollow.setTitleColor(#colorLiteral(red: 0.8509803922, green: 0.01568627451, blue: 0.1607843137, alpha: 1), for: .normal)
        tblList.reloadDataInMain()
    }
    
    func followingSelected() {
        //tblList.isHidden = false
        viewFollowing.isHidden = false
        btnFollowing.setTitleColor(#colorLiteral(red: 0.8509803922, green: 0.01568627451, blue: 0.1607843137, alpha: 1), for: .normal)
        viewFollow.isHidden = true
        btnFollow.setTitleColor(#colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), for: .normal)
        tblList.reloadDataInMain()
    }
    
    func Settext(){
        lblfollowinghint.text="Following/Followers".localized()
        btnFollow.setTitle("Following".localized(), for: .normal)
        btnFollowing.setTitle("Followers".localized(), for: .normal)
        
    }
    
    
    
    // MARK: - Action
    @IBAction func actionMenu(_ sender: Any) {
          if vctype == "sidemenu"{
                 NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
                 self.navigationController?.popViewController(animated: true)
                 }else{
                NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
                self.navigationController?.popViewController(animated: true)
            }
    }
    
    @IBAction func actionFollow(_ sender: Any) {
        followSelected()
        isfollowers = false
    }
    
    @IBAction func actionFollowing(_ sender: Any) {
        followingSelected()
        isfollowers = true

    }
    @objc func didTapfollowbtn(_ sender: UIButton) {
        self.getFollowApi(followid: arrFollowing?.data?[sender.tag].followedID ?? "")
    }

}

extension FollowViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if arrFollowing?.data?.count ?? 0  == 0  {
                       NoDataView?.isHidden = false
                  }else{
                        NoDataView?.isHidden = true

                  }

            return arrFollowing?.data?.count ?? 0
        } else {
            if arrFollowers?.data?.count ?? 0  == 0  {
                 NoDataView?.isHidden = false
            }else{
                  NoDataView?.isHidden = true

            }
            return arrFollowers?.data?.count ?? 0
        }
        
       // you are not following any one.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FollowTableViewCell.self), for: indexPath) as! FollowTableViewCell
            cell.imgPerson.sd_setImage(with: URL(string:arrFollowing?.data?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: ""))
            cell.lblTitle.text = arrFollowing?.data?[indexPath.row].name ?? ""
            let subTitle = arrFollowing?.data?[indexPath.row].address ?? ""
            cell.lblSubTitle.text = String(subTitle.prefix(1))
           // cell.delegate = self
            cell.btnremove.tag=indexPath.row
            cell.btnremove.addTarget(self, action: #selector(didTapfollowbtn(_:)), for: .touchUpInside)
            return cell
        } else {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FollowingTableViewCell1.self), for: indexPath) as! FollowingTableViewCell1
            cell.imgPerson.sd_setImage(with: URL(string:arrFollowers?.data?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: ""))
            cell.lblTitle.text = arrFollowers?.data?[indexPath.row].name ?? ""
            let subTitle = arrFollowers?.data?[indexPath.row].address ?? ""
            cell.lblSubTitle.text = String(subTitle.prefix(1))
           
            return cell

        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isfollowers == false {
            if indexPath.section == 0 {
                
                return 85
            } else {
                return 0
            }
        } else {
            if indexPath.section == 0 {
                return 0
            } else {
                return 85
            }
        }
        
       
    }
}
extension FollowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
        let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
        vc.sellerId = arrFollowing?.data?[indexPath.row].followedID ?? ""
       // vc.vctype="profile"
        self.show(vc, sender: nil)
        }else{
            let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
             vc.sellerId = arrFollowers?.data?[indexPath.row].followedID ?? ""
            // vc.vctype="profile"
             self.show(vc, sender: nil)
        }
        
    }
}
//extension FollowViewController: FollowTableViewCellDelegate {
//    func didTapRemoveButton(cell: FollowTableViewCell) {
//        let indexPath = tblList.cellForRow(at: <#T##IndexPath#>)
//        followId = arrFollowing?.data?[indexPath!.row].followedID ?? ""
//          getFollowApi()
//
////        let indexPath = table.indexPath(for: cell)
//
//    }
//
//
//}


extension FollowViewController{
    func getFollowApi(followid:String){
        let dictParam = ["followed_id": followid]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: FollowUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.followDictionary = resModel
                    self.getFollowingApi()
                }else{
//                   self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
//                    self.dismiss(animated: true, completion: nil)
//                    })
                }
            }) { (stError) in
//                self.showCustomPopupViewAction(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
//                    self.dismiss(animated: true, completion: nil)
//                }
            }
        }
}



extension FollowViewController {
    func getFollowersApi(){
        let dictParam = ["":""]
        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: FollowersUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: FollowersModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.arrFollowers = resModel
                    self.tblList.reloadData()
                }else{
                    self.tblList.reloadData()
                    
                   self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                    })
                }
            }) { (stError) in
                self.showCustomPopupView(altMsg: stError, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func getFollowingApi(){
        let dictParam = ["":""]
        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: FollowingUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: FollowersModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.arrFollowing = resModel
                    self.tblList.reloadData()
                }else{
                    self.tblList.reloadData()
                    
                   self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                    })
                }
            }) { (stError) in
                self.showCustomPopupView(altMsg: stError, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
