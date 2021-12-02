//
//  HomeView.swift
//  Mzadi
//
//  Created by Emizentech on 11/08/21.
//

import UIKit
import SDWebImage
import SideMenu
import Localize_Swift


var ismessage=false

class HomeView:HomeBaseMenuViewController{
    
    @IBOutlet weak var backimg: UIImageView!
    @IBOutlet weak var notiview: UIView!
    @IBOutlet weak var btnnotification: UIButton!
    @IBOutlet weak var Tblhome: UITableView!
    @IBOutlet var collectionViewHeader: UICollectionView!
    
    var ArrHomeData:HomeBarCategoryModel?
    var arrNotifcation:NotificationModel?
    
    var parentcategoryname = ""
    var firebasetoken=""
    let refreshControl = UIRefreshControl()
    var deviceid=""
    var notistatus=false
    fileprivate var tableItems:[ChatRoomModel] = []
    static var userDetailsList: [String: UserDetailsModel] = [:]
    var getcount=0
    var tablescroll=false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.title = "Home".localized()
        // collectionViewHeader.semanticContentAttribute = .forceRightToLeft
        
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar" || obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku"{
            collectionViewHeader.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }else{
            collectionViewHeader.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }
        
        //        DispatchQueue.main.async {
        //            self.collectionViewHeader.semanticContentAttribute = .forceRightToLeft
        //        }
        
        
        //  self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = true
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.Tblhome.addSubview(refreshControl)
        
        
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            btnnotification.setImage(UIImage(named: "logout"), for: .normal)
            notiview.isHidden=true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                btnnotification.tintColor = .white
            }else{
                btnnotification.tintColor = .black
            }
        }else{
            btnnotification.setImage(UIImage(named: "Bell"), for: .normal)
            SaveFirebaseTokenApi()
            
            
        }
        
        
       // Tblhome.tableFooterView=UIView()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NotiRedirection(notifiy:)), name:NSNotification.Name("myadd"), object: nil)
        //
        NotificationCenter.default.addObserver(self, selector: #selector(Changebordercolor), name:NSNotification.Name("color"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Notificationstatus), name:NSNotification.Name("myhome"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ShareNotiRedirection), name:NSNotification.Name("myshare"), object: nil)
        
        //        if canHaveNewNoti{
        //
        //            NotificationCenter.default.post(name: NSNotification.Name("ManageNotificationFromKill"), object: nil, userInfo:SavedPayLoad)
        //            canHaveNewNoti = false
        //        }
        
        
        GetHome()
        
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        SocketManager.shared.registerToScoket(observer: self )
        let json: [String: Any] = ["request": "room",
                                   "type": "allRooms",
                                   "userList":[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]
            //  "userList": []
        ]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    
    
    @objc func Notificationstatus(notification: Notification){
        notistatus = (notification.userInfo!["NotiValue"]! as! Bool)
        if notistatus == true {
            notiview.isHidden=false
        }else{
            notiview.isHidden=true
        }
        
    }
    
    
    @objc func Changebordercolor(){
        //        let cell = Tblhome.cellForRow(at: IndexPath(row:0, section:0)) as! BannerTableViewCell
        //        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
        //            cell.Backview.borderColor = App_main_dark
        //            cell.Backview.borderWidth = 0
        //                   }else{
        //            cell.Backview.borderWidth = 0.5
        //            cell.Backview.borderColor = Applightcolor
        //        }
        GetHome()
        
    }
    
    
    @objc func ShareNotiRedirection(notifiy:NSNotification){
        
        let dict = notifiy.userInfo as? NSDictionary
        let forid = (dict?["id"] as? String ?? "")
        let fortype = (dict?["type"] as? String ?? "")
        
        if fortype == "user"{
            let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
            vc.sellerId=forid
            vc.vctype="profile"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
            vc.productId=forid
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    
    @objc func NotiRedirection(notifiy:NSNotification){
        
        let dict = notifiy.userInfo as? NSDictionary
        let forid = (dict?["forid"] as? String ?? "")
        let forvalue = (dict?["forvalue"] as? String ?? "")
        
        if forvalue == "0"{
            let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if forvalue == "2"{
            let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
            vc.productId=forid
            self.navigationController?.pushViewController(vc, animated: true)
        }else if forvalue == "17" {
            if ismessage == false{
                let vc: ChatViewController = ChatViewController()
                vc.roomId=forid
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
            }
        }
        else{
            let vc = EditProfileViewController.instance(.myAccountTab) as! EditProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    @IBAction func btnsearch(_ sender: Any) {
        //      if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
        //            self.showCustomPopupViewAction(altMsg:"Please login first", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage(), OkAction: {popup in
        //                popup.dismiss(animated: true, completion: {
        //                    self.log_Out_from_App()
        //                    self.tabBarController?.tabBar.isHidden = true
        //                })
        //            })
        //        }else{
        let vc = SearchSuggestionViewController.instance(.homeTab) as! SearchSuggestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @objc func refresh(_ sender: AnyObject) {
        GetHome()
    }
    
    
    
    @IBAction func btnmenuaction(_ sender: Any) {
        
        if Localize.currentLanguage() == "ar" {
            //                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            DispatchQueue.main.async {
                let vc = MenuViewController.instance(.homeTab) as! MenuViewController
                let menu = SideMenuNavigationController(rootViewController: vc)
                menu.leftSide = false
                menu.menuWidth = self.view.frame.width*0.75
                menu.statusBarEndAlpha = 0
                menu.presentationStyle = .menuSlideIn
                menu.presentationStyle.menuStartAlpha = 0
                
                self.present(menu, animated: true, completion: nil)
                
            }
            
        } else {
            //UIView.appearance().semanticContentAttribute = .forceLeftToRight
            DispatchQueue.main.async {
                let vc = MenuViewController.instance(.homeTab) as! MenuViewController
                let menu = SideMenuNavigationController(rootViewController: vc)
                menu.leftSide = true
                menu.menuWidth = self.view.frame.width*0.75
                menu.statusBarEndAlpha = 0
                menu.presentationStyle = .menuSlideIn
                menu.presentationStyle.menuStartAlpha = 0
                
                self.present(menu, animated: true, completion: nil)
                
            }
        }
    }
    
    
    @IBAction func btnnotification(_ sender: Any) {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.log_Out_from_App()
            self.tabBarController?.tabBar.isHidden = true
        }else{
            let vc = NotificationViewController.instance(.homeTab) as! NotificationViewController
            vc.NotiValue=notistatus
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
    func GetHome(){
        self.refreshControl.endRefreshing()
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: HomeUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: HomeBarCategoryModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrHomeData = resModel
                self.collectionViewHeader.reloadData()
                self.Tblhome.reloadData()
                self.backimg.isHidden=false
                
                
                // self.RegisterUseronSocketServer()
            }else{
                self.collectionViewHeader.reloadData()
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
    
    
    
    func SaveFirebaseTokenApi(){
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String == "1"{
            
        }else{
            
            return
        }
        self.firebasetoken=UserDefaults.standard.string(forKey:"fcmToken") ?? ""
        print("firebasetoken:\(self.firebasetoken)")
        deviceid=UIDevice.current.identifierForVendor!.uuidString
        let dictRegParam = [
            "device_id":deviceid,
            "device_token":firebasetoken,
            "device_type":"2"
            ] as [String : Any]
        
        print(dictRegParam)
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: SaveFirebaseUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            
            
        }) { (Strerr,stCode) in
            
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
                
            })
        }
        
        
    }
    
    
    
    
    
    func GetNotificationList(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetNotificationUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: NotificationModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                
                self.arrNotifcation = resModel
                
                
                if self.arrNotifcation?.data.count ?? 0 > 0  {
                    
                    for i in 0 ... (self.arrNotifcation?.data.count ?? 0)-1 {
                        if self.arrNotifcation?.data[i].status == "0" {
                            self.notiview.isHidden=false
                            
                        }
                    }
                }
                
                
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }) { (stError) in
            self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
//    @objc func goToDetailsVC(sender:UIButton){
//        print(sender.tag)
//        let ProData = ArrHomeData!.data!.bodyData![sender.tag].subCat!
//        if ProData[sender.tag].typeCount == "0"{
//            let vc = DetailVC.instance(.homeTab) as! DetailVC
//            vc.Subcatid=ProData[sender.tag].id
//            vc.Subcatname=ProData[sender.tag].name
//            vc.Brandname="All"
//            vc.catid=ProData[sender.tag].id
//            if (ProData.count ) > 0 {
//                for i in 0 ... (ProData.count )-1 {
//                    if ProData[i].parentID == ArrHomeData?.data?.bodyData?[i].id {
//            let catTitle = ArrHomeData?.data?.bodyData?[i].name
//                        vc.MainCatName=catTitle
//
//            }
//                }
//
//
//            }
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = SubCategoryDetailViewController.instance(.homeTab) as! SubCategoryDetailViewController
//            vc.Subcatid=ProData[sender.tag].id
//            vc.Subcatname=ProData[sender.tag].name
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    
    @objc func goToDetailsVC(sender:UIButton){
        print(sender.tag)
        let sect = Int(sender.accessibilityHint!)!
        let prodata = ArrHomeData!.data!.bodyData![sect].subCat!
        if prodata[sender.tag].typeCount == "0"{
            let vc = DetailVC.instance(.homeTab) as! DetailVC
            vc.Subcatid=prodata[sender.tag].id
            vc.Subcatname=prodata[sender.tag].name
            vc.Brandname="All"
            vc.catid=prodata[sender.tag].id
            let catTitle = ArrHomeData?.data?.bodyData?[sect].name
            vc.MainCatName=catTitle
//            if (prodata.count ) > 0 {
//                for i in 0 ... (prodata.count )-1 {
//                    if prodata[i].parentID == ArrHomeData?.data?.bodyData?[i].id {
//                        let catTitle = ArrHomeData?.data?.bodyData?[i].name
//                        vc.MainCatName=catTitle
//
//                    }
//                }
//
//
//            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SubCategoryDetailViewController.instance(.homeTab) as! SubCategoryDetailViewController
            vc.Subcatid=prodata[sender.tag].id
            vc.Subcatname=prodata[sender.tag].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }



}

extension HomeView:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let vz = ArrHomeData?.data?.lastAdd?.count ?? 0 > 0 ? 1 : 0
        let xx = ArrHomeData?.data?.bodyData?.count  ?? 0
        return vz + xx
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ArrHomeData?.data?.bodyData?.count ?? 0{
            return 1
        }
        return  ArrHomeData?.data?.bodyData?[section].adBanner?.count ?? 0 > 0 ? 2 : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == ArrHomeData?.data?.bodyData?.count ?? 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BannerTableViewCell
            cell.adData = ArrHomeData!.data!.lastAdd!
            cell.Setdata()
            return cell
        }
        
        if indexPath.row == 0 && ArrHomeData?.data?.bodyData?[indexPath.section].adBanner?.count ?? 0 > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BannerTableViewCell
            
            if indexPath.section == 0 && indexPath.row == 0 {
                
                if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                    cell.Curveimg.isHidden=true
                    
                }else{
                    cell.Curveimg.isHidden=false
                    cell.Curveimg.image = UIImage(named: "halfcurve")
                }
                cell.Backview.isHidden=false
                cell.Backview.cornerRadius = 50
                cell.Backview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                
            }else{
                cell.Curveimg.isHidden=true
                
                cell.Backview.isHidden=false
                cell.Backview.cornerRadius = 0
            }
            
            
            
            cell.adData = ArrHomeData!.data!.bodyData![indexPath.section].adBanner!
            cell.nav=self.navigationController
            cell.Setdata()
            return cell
        }
        else {
            let categoryid = ArrHomeData!.data!.bodyData![indexPath.section].id ?? ""
            if categoryid == "23"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell1", for: indexPath) as!CategoryTableViewCell1
                cell.lblcategoryname.text=ArrHomeData?.data?.bodyData?[indexPath.section].name
                //  cell.maincategoryname = ArrHomeData?.data?.bodyData?[indexPath.section].name ?? ""
                cell.lblproductcount.text="\("Total Ads".localized()) \(ArrHomeData?.data?.bodyData?[indexPath.section].totalProduct ?? "")"
                let pro = ArrHomeData!.data!.bodyData![indexPath.section].subCat!
                
                if categoryid == "23"{
                    for i in 0...cell.ImgSubCollection.count-1 {
                        cell.ImgSubCollection[i].sd_imageIndicator = SDWebImageActivityIndicator.gray
                        cell.ImgSubCollection[i].sd_setImage(with: URL(string:pro[i].image ?? "" ), placeholderImage: UIImage(named: "Noimgplace"))
                        cell.lblcollection[i].text="\(pro[i].name ?? "")"
                        cell.lblcollection[i].addBlur(0.001)
                        cell.ServiceButton[i].accessibilityHint = "\(indexPath.section)"
                        cell.ServiceButton[i].tag=i
                        cell.ServiceButton[i].addTarget(self, action: #selector(goToDetailsVC(sender:)), for:.touchUpInside)
                        
                        
                    }
                }
                return cell
            }else{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell", for: indexPath)as!CategoryTableViewCell
                
                if indexPath.section == 0 && indexPath.row == 0 {
                if ArrHomeData!.data!.bodyData![indexPath.row].adBanner?.count == 0{
                    cell.layer.cornerRadius = 20
                }else{
    
                }
                }
            
                cell.lblcategoryname.text=ArrHomeData?.data?.bodyData?[indexPath.section].name
                //  cell.maincategoryname = ArrHomeData?.data?.bodyData?[indexPath.section].name ?? ""
                cell.lblproductcount.text="\("Total Ads".localized()) \(ArrHomeData?.data?.bodyData?[indexPath.section].totalProduct ?? "")"
                cell.ProData=ArrHomeData!.data!.bodyData![indexPath.section].subCat!
                //cell.ProMain=ArrHomeData!.data!.bodyData!
                cell.ArrProData=ArrHomeData
                cell.nav=self.navigationController
                let categoryid = ArrHomeData!.data!.bodyData![indexPath.section].id ?? ""
                cell.CategoryId=categoryid
                cell.SetSize()
                return cell
                
            }
            
            
        }
        
        
    }
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     let CategoryId = ArrHomeData!.data!.bodyData![indexPath.section].id ?? ""
     let ProData = ArrHomeData!.data!.bodyData![indexPath.section].subCat!
     if CategoryId == "1" {
     let space  = 10 * (ProData.count/3)
     return ProData.count % 3 == 0 ?  CGFloat((ProData.count/3) * 150 + space): CGFloat((ProData.count/3+1) * 150 + space)
     
     }else if CategoryId == "7" {
     let space  = 5 * (ProData.count/2)
     return ProData.count % 2 == 0 ?  CGFloat((ProData.count/2) * 150 + space): CGFloat((ProData.count/2+1) * 150 + space)
     }else if CategoryId == "16" {
     let space  = 10 * (ProData.count/3)
     return ProData.count % 3 == 0 ?  CGFloat((ProData.count/3) * 150 + space): CGFloat((ProData.count/3+1) * 150 + space)
     }else if CategoryId == "12" {
     return ProData.count > 2 ? 285 : 145
     }else if CategoryId == "35" {
     
     return ProData.count > 2 ? 265 : 145
     }else if CategoryId == "23"{
     //            let space  = 10 * (ProData.count/3)
     return 504
     //            self.collectionHeightConstriant.constant = ProData.count % 3 == 0 ?  CGFloat((ProData.count/3) * 100 + space): CGFloat((ProData.count/3+1) * 120 + space)
     }
     else if CategoryId == "54" {
     let space  = 10 * (ProData.count/2)
     return ProData.count % 2 == 0 ?  CGFloat((ProData.count/2) * 105 + space): CGFloat((ProData.count/2+1) * 105 + space)
     }else if CategoryId == "51"{
     let space  = 10 * (ProData.count/2)
     return ProData.count % 2 == 0 ?  CGFloat((ProData.count/2) * 180 + space): CGFloat((ProData.count/2+1) * 180 + space)
     }else if CategoryId == "57"{
     let space  = 10 * (ProData.count)
     return ProData.count > 0 ? 350 : 170
     }else if CategoryId == "60" {
     return 200
     }
     
     return UITableView.automaticDimension
     }*/
}
// MARK:-  UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewHeader {
            return ArrHomeData?.data?.bodyData?.count ?? 0
        }else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath as IndexPath) as! HomeHeaderCollectionViewCell
            cell.lblnamecat.text=ArrHomeData?.data?.bodyData?[indexPath.row].name
            cell.carimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.carimg.sd_setImage(with: URL(string: ArrHomeData?.data?.bodyData?[indexPath.row].icon ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVehicleCollectionViewCell", for: indexPath as IndexPath) as! HomeVehicleCollectionViewCell
            return cell
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:100, height:100)
        
        
        //        if collectionView == collectionViewVehicle {
        ////            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        ////            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        ////            let width:CGFloat = (collectionView.frame.size.width - space) / 3.0
        ////            let height:CGFloat = (collectionView.frame.size.height - space) / 2.0
        ////            return CGSize(width: width, height: height)
        //            let size = CGSize(width: collectionViewVehicle.bounds.size.width / 3 , height: 180)
        //            return size
        //
        //        } else {
        ////            let padding: CGFloat =  5
        ////            let collectionViewSize = collectionView.frame.size.width - padding
        //                return CGSize(width:110, height:110)
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryDetailViewController.instance(.homeTab) as! CategoryDetailViewController
        vc.catid=self.ArrHomeData?.data?.bodyData?[indexPath.row].id
        vc.catname=self.ArrHomeData?.data?.bodyData?[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeView: SocketObserver {
    func registerFor() -> [ResponseType] {
        return [.allRooms, .roomsModified,. userModified, .createRoom]
    }
    
    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        
        print(data)
        
        
        
        if (observerWithIdentifire == .allRooms){
            if let data = data["data"] as? [String: Any]{
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                
                tmpUserList.forEach { (element) in
                    ChatListView.userDetailsList[element.userId] = element
                }
                
                
                
                tableItems = ChatRoomModel.giveList(list: data["roomList"] as? [[String: Any]] ?? [] )
                
                
                getcount = 0
                
                for i in 0..<tableItems.count {
                    let value:[String:Any] = tableItems[i].tmpunread
                    if let valuecount = value[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]{
                        getcount += valuecount as? Int ?? 0
                    }
                    
                }
                
                if getcount != 0 {
                    tabBarController?.tabBar.addBadge(index: 3)
                }else{
                    tabBarController?.tabBar.removeBadge(index: 3)
                }
                
                
            }
            
        } else if (observerWithIdentifire == .roomsModified){
            if let data = data["data"] as? [String: Any] {
                
                let updatedRoom = ChatRoomModel(disc: data)
                
                tableItems = tableItems.map { (element) -> ChatRoomModel in
                    var elementX = element
                    if (element.id == updatedRoom.id){
                        elementX = updatedRoom
                    }
                    
                    return elementX
                    
                }
                
                
                getcount = 0
                
                
                
                
                for i in 0..<(tableItems.count){
                    let value:[String:Any] = tableItems[i].tmpunread
                    if let valuecount = value[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]{
                        getcount += valuecount as? Int ?? 0
                    }
                    
                }
                
                if getcount != 0 {
                    tabBarController?.tabBar.addBadge(index: 3)
                }else{
                    tabBarController?.tabBar.removeBadge(index: 3)
                }
                
                
                
                
                
                
                
                
                
            }
        } else if (observerWithIdentifire == .createRoom){
            if let data = data["data"] as? [String: Any] {
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                
                tmpUserList.forEach { (element) in
                    ChatListView.userDetailsList[element.userId] = element
                }
                if let newRoom = data["newRoom"] as? [String: Any] {
                    let updatedRoom = ChatRoomModel(disc: newRoom)
                    tableItems.append(updatedRoom)
                }
                
                
                
            }
        } else if observerWithIdentifire == .userModified {
            print("ChatViewController", observerWithIdentifire, message)
            if (statusCode == 200){
                if let data: [String : Any] = data["data"] as? [String: Any] {
                    let updatedUserInfo = UserDetailsModel.giveObj(cdic: data)
                    ChatListView.userDetailsList[updatedUserInfo.userId] = updatedUserInfo
                    
                }
            }
        }
    }
    
    func socketConnection(status: SocketConectionStatus) {
        print("websocket connected!!")
    }
    
    
    
}

