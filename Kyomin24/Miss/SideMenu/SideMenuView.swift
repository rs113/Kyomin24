//
//  SlideMenuView.swift

import UIKit
import SDWebImage
import Localize_Swift

enum MenuType {
    case addAdvertise
    case myAdd
    case favorite
    case follow
   // case purchase
    case myplan
    case block
    case chat
    case language
    case mode
    case notification
    case about
    case contact
    case share
    case privacy
    case terms
    case none
}

class SideMenuView: UIView {
    
    //MARK: Properties
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var btnlogout: UIButton!
    
    var callBack: ((MenuType) -> ())!
    var menuList: [MenuSection]!
    var onoffstr=""
    var onoffnoti=""
    
    
    
    struct MenuSection {
        var list: [MenuDetail]!
    }
    
    struct MenuDetail {
        var text: String!
        var img: String!
        var type: MenuType!
    }
    
    static var selectIndex : MenuType?
    
    override func layoutSubviews() {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.lblName.text = "Guest Mode".localized()
            self.imgUser.isHidden = false
            btnlogout.setTitle("Login".localized(), for: .normal)
        } else {
            
          setUserProfileData()
        }
        
    }
    
    static func initialize(callBack: @escaping ((MenuType) -> ())) {
        
        let sideView = SideMenuView().loadNib() as! SideMenuView
        sideView.frame = UIScreen.main.bounds
        sideView.configureTableItems()
        sideView.callBack = callBack
        // UIApplication.currentViewController()?.view.backgroundColor = .green
        UIApplication.currentViewController()?.view.addSubview(sideView)
        sideView.showSideMenu(true)
    }
    
    
    
    func configureTableItems() {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            
            
            menuList =  [MenuSection(list:[
                MenuDetail(text: "Language".localized(), img: "language", type: .language),
                                            MenuDetail(text: "Change Mode".localized(), img: "mode", type: .mode),
                                            MenuDetail(text: "About Mzadi".localized(), img: "about", type: .about),
                                            MenuDetail(text: "Contact Us".localized(), img: "about", type: .contact),
                                            MenuDetail(text: "Share Mzadi".localized(), img: "share", type: .share),
                                            MenuDetail(text: "Privacy Policy".localized(), img: "privacy", type: .privacy),
                                            MenuDetail(text: "Terms And Conditions".localized(), img: "term", type: .terms)])]
        }else{
            
            menuList = [MenuSection(list: [MenuDetail(text: "Add advertise".localized(),img: "advertise", type: .addAdvertise),
                                           MenuDetail(text: "My ads".localized(), img: "myAdd", type: .myAdd),
                                           MenuDetail(text: "Favorites".localized(), img: "favorite", type: .favorite),
                                           MenuDetail(text: "Following/Followers".localized(), img: "followfollowing", type: .follow),
                                          // MenuDetail(text: "Purchase Plan".localized(), img: "purchase", type: .purchase),
                                           MenuDetail(text: "My Plan".localized(), img: "myplan", type: .myplan),
                                           MenuDetail(text: "Blocked Users".localized(), img: "block", type: .block),
                                           MenuDetail(text: "Chat".localized(), img: "chat", type: .chat),
                                           MenuDetail(text: "Language".localized(), img: "language", type: .language),
                                           MenuDetail(text: "Change Mode".localized(), img: "mode", type: .mode),
                                           MenuDetail(text: "Notification".localized(), img: "noti", type: .notification),
                                           MenuDetail(text: "About Mzadi".localized(), img: "about", type: .about),
                                           MenuDetail(text: "Contact Us".localized(), img: "contactus", type: .contact),
                                           MenuDetail(text: "Share Mzadi".localized(), img: "share", type: .share),
                                           MenuDetail(text: "Privacy Policy".localized(), img: "privacy", type: .privacy),
                                           MenuDetail(text: "Terms And Conditions".localized(), img: "term", type: .terms)])]
            
            
        }
        tblView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        
    }
    
    // MARK: Side Menu Animation
    func showSideMenu(_ isShow: Bool) {
        
        
        self.leftView.frame.origin.x = isShow ? -self.leftView.frame.size.width : 0
//
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 8.0, options: .curveEaseIn, animations: ({
//
//
            self.leftView.frame.origin.x = isShow ? 0 : -self.leftView.frame.size.width
            self.alpha = isShow ? 1 : 0
        }), completion: { completed in
            if !isShow {
                self.removeFromSuperview()
            }
            
            let tab = UserDefaults.standard.value(forKey: "tab")
            print(tab)
            
            if let tabBarController = self.window?.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = tab as! Int
            }
            
        })
    }
    
    
    func setUserProfileData() {
    btnlogout.setTitle("Logout".localized(), for: .normal)
    self.lblName.text =  obj.prefs.value(forKey: APP_USER_NAME) as? String
    self.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
    self.imgUser.sd_setImage(with: URL(string:obj.prefs.value(forKey: App_User_Img) as? String ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
        
    }
    
    //MARK: Button Actions
    @IBAction func btnBack_Action(_ sender: Any) {
        self.showSideMenu(false)
    }
    
    //MARK: Tap Gestures
    @IBAction func tapGestureRightView(_ sender: Any) {
        
        self.showSideMenu(false)
        
        
        
        
    }
    
    @IBAction func profile(_ sender: Any) {
        self.showSideMenu(false)
        
        //        let userId =  UserDefaults.standard.value(forKey: "userid") as? String ?? ""
        //        if userId == "" {
        //            // let vc = ViewController.instance() as! ViewController
        //            // UIApplication.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
        //        } else {
        //            //  UIApplication.currentViewController()?.navigationController?.pushViewController(ProfileViewController.instance(), animated: true)
        //        }
        
        //        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
        //
        //        }else{
        //           UIApplication.currentViewController()?.navigationController?.pushViewController(ProfileViewController.instance(), animated: true)
        //        }
        
    }
    
    
   
    
    func LogoutApi(){
        let deviceId=UIDevice.current.identifierForVendor!.uuidString
        let dictParam = [ "device_id":deviceId,
                           "type":"2"] as [String : Any]
        ApiManager.apiShared.SendRequestServerPostWithHeaderModel(url: LogOutUrl,ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                print("success")
            }else{
                
            }
        }) { (stError) in
            
        }
    }
    
    
    @IBAction func actionLogout(_ sender: Any) {
        
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            
            
            //        let vc = SelectlanguageViewController.instance(.main) as! SelectlanguageViewController
            //        UIApplication.currentViewController()?.navigationController?.setViewControllers([vc], animated: true)
            let vc = mainStory.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let NavVC = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = NavVC
            self.window?.makeKeyAndVisible()
            
        }else{
            // self.showSideMenu(false)
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                //vc.alertMsg = emptyNumber
                //vc.alertBtnTitle = "close"
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you really want to logout?".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        let userDefault  = UserDefaults.standard
                        UserDefaults.standard.set(false, forKey:"Session")
                        UserDefaults.standard.removeObject(forKey:"Session")
                        userDefault.removeObject(forKey: "AuthToken")
                        obj.prefs.removeObject(forKey: APP_IS_LOGIN)
                        obj.prefs.removeObject(forKey: APP_ACCESS_TOKEN)
                       // obj.prefs.removeObject(forKey: APP_CURRENT_LANG)
                        obj.prefs.removeObject(forKey: Notiswitchvalue)
                        obj.prefs.removeObject(forKey: AppSubCatId)
                        obj.prefs.removeObject(forKey: Appcatid)
                        obj.prefs.removeObject(forKey: App_User_Role)
                        //Localize.setCurrentLanguage("en")
                        //self.LogoutApi()
                        let vc = mainStory.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        let NavVC = UINavigationController(rootViewController: vc)
                        self.window?.rootViewController = NavVC
                        self.window?.makeKeyAndVisible()
                        
                    }else {
                        
                    }
                }
                
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    
    
   
    func Notificationapi(status:String){
        let device=UIDevice.current.identifierForVendor!.uuidString
        let dictRegParam = [
            
            
            "status":status,
            "device_id":UIDevice.current.identifierForVendor!.uuidString,
            "device_type":"2"
            ]
        
        
        print(dictRegParam)
        ApiManager.apiShared.SendRequestServerPostWithHeaderModel(url: UpdateNotificationUrl,ReqMethod: .post, dictParameter: dictRegParam, responseObject: CommonModal.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
            }else{
                
            }
        }) { (stError) in
            
        }
        
        
    }
    
    
    
    @objc func Settheme(sender:UISwitch){
        if obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            if sender.tag == 2{
                if sender.isOn{
                    self.overrideUserInterfaceStyle = .dark
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark
                    }
                    
                    Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
                    sender.setOn(true, animated: false)
                    onoffstr="On"
                    obj.prefs.set(onoffstr, forKey: SwitchValue)
                    NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
                }else{
                    self.overrideUserInterfaceStyle = .light
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light
                    }
                    
                    Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
                    sender.setOn(false, animated: false)
                    onoffstr="Off"
                    obj.prefs.set(onoffstr, forKey: SwitchValue)
                    NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
                }
                
            
            }else{
                
            }
        }else{
        
        if sender.tag == 8
        {
            
            if sender.isOn{
                self.overrideUserInterfaceStyle = .dark
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
                
                Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
                sender.setOn(true, animated: false)
                onoffstr="On"
                obj.prefs.set(onoffstr, forKey: SwitchValue)
                NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
            }else{
                self.overrideUserInterfaceStyle = .light
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
                
                Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
                sender.setOn(false, animated: false)
                onoffstr="Off"
                obj.prefs.set(onoffstr, forKey: SwitchValue)
                NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
            }
            
            
//            if self.overrideUserInterfaceStyle == .unspecified {
//                if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
//                    self.overrideUserInterfaceStyle = .light
//                    UIApplication.shared.windows.forEach { window in
//                        window.overrideUserInterfaceStyle = .light
//                    }
//
//                    Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
//                    sender.setOn(false, animated: false)
//                    onoffstr="Off"
//                    obj.prefs.set(onoffstr, forKey: SwitchValue)
//                    NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
//
//                } else {
//                    self.overrideUserInterfaceStyle = .dark
//                    UIApplication.shared.windows.forEach { window in
//                        window.overrideUserInterfaceStyle = .dark
//                    }
//
//                    Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
//                    sender.setOn(true, animated: false)
//                    onoffstr="On"
//                    obj.prefs.set(onoffstr, forKey: SwitchValue)
//                    NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
//                }
//
//            } else  if self.overrideUserInterfaceStyle == .light {
//
//                self.overrideUserInterfaceStyle = .dark
//                UIApplication.shared.windows.forEach { window in
//                    window.overrideUserInterfaceStyle = .dark
//                }
//
//                Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
////                sender.setOn(true, animated: false)
////                onoffstr="On"
////                obj.prefs.set(onoffstr, forKey: SwitchValue)
//                NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
//
//            } else  if self.overrideUserInterfaceStyle == .dark {
//
//                self.overrideUserInterfaceStyle = .light
//                UIApplication.shared.windows.forEach { window in
//                    window.overrideUserInterfaceStyle = .light
//                }
//
//                Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
////                sender.setOn(false, animated: false)
////                onoffstr="Off"
////                obj.prefs.set(onoffstr, forKey: SwitchValue)
//                NotificationCenter.default.post(name: NSNotification.Name("color"), object: nil, userInfo: nil)
//
//            }
        }
        if sender.tag == 9
        {
            if sender.isOn{
                Notificationapi(status: "1")
                sender.setOn(true, animated: false)
                onoffnoti="On"
                obj.prefs.set(onoffnoti, forKey: Notiswitchvalue)
            }else{
                Notificationapi(status: "0")
                sender.setOn(false, animated: false)
                onoffnoti="Off"
                obj.prefs.set(onoffnoti, forKey: Notiswitchvalue)
            }
        }
        }
        
        
    }
    
    
}

extension SideMenuView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.lblText.text = menuList[indexPath.section].list[indexPath.row].text
        cell.imgList.image = UIImage(named: "\(menuList[indexPath.section].list[indexPath.row].img!)")
        cell.selectionStyle = .gray
        
        cell.btnswitch.isHidden=true
        cell.btnswitch.tag=indexPath.row
        
        cell.btnswitch.addTarget(self, action: #selector(Settheme(sender:)), for: .valueChanged)
        
        
        if obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            if indexPath.row == 1 {
                       cell.btnswitch.isHidden=false
                       
                       if obj.prefs.value(forKey: SwitchValue) as? String == "On"{
                           cell.btnswitch.isOn = true
                       }else{
                           cell.btnswitch.isOn = false
                           
                       }
            }else{
              cell.btnswitch.isHidden=true
        }
        }else{
        if indexPath.row == 8 {
            cell.btnswitch.isHidden=false
            
            if obj.prefs.value(forKey: SwitchValue) as? String == "On"{
                cell.btnswitch.isOn = true
            }else{
                cell.btnswitch.isOn = false
                
            }
        }
        
        if indexPath.row == 9{
            cell.btnswitch.isHidden=false
            if obj.prefs.value(forKey: Notiswitchvalue) as? String ?? "On" == "On"{
                cell.btnswitch.isOn = true
                Notificationapi(status: "1")
            }else{
                cell.btnswitch.isOn = false
            }
        }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
       
        
        
        //        if indexPath.row == 10 || indexPath.row == 11 {
        //        cell.btnswitch.tag=indexPath.row
        //        cell.btnswitch.addTarget(self, action: #selector(Settheme(sender:)), for: .touchUpInside)
        //            if indexPath.row == 10
        //            {
        //                if cell.btnswitch.isOn == true {
        //
        //                   self.overrideUserInterfaceStyle = .dark
        //                   UIApplication.shared.windows.forEach { window in
        //                       window.overrideUserInterfaceStyle = .dark
        //                   }
        //
        //                   Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
        //                 cell.btnswitch.isOn = true
        ////                   sender.setOn(true, animated: false)
        ////                   onoffstr="Off"
        ////                   obj.prefs.set(onoffstr, forKey: SwitchValue)
        //
        //               } else if cell.btnswitch.isOn == false {
        //
        //                   self.overrideUserInterfaceStyle = .light
        //                   UIApplication.shared.windows.forEach { window in
        //                       window.overrideUserInterfaceStyle = .light
        //                   }
        //
        //                Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
        //                 cell.btnswitch.isOn = false
        ////                sender.setOn(false, animated: false)
        ////                onoffstr="On"
        ////                obj.prefs.set(onoffstr, forKey: SwitchValue)
        //
        //               }
        //            }
        //            if indexPath.row == 11
        //            {
        //                if cell.btnswitch.isOn  == true{
        //                            Notificationapi(status: "1")
        //
        //                                  }else{
        //                            Notificationapi(status: "0")
        //
        //                                   }
        //            }
        //        }
        //
        //        else{
        //          cell.btnswitch.isUserInteractionEnabled=true
        //        }
        
        
        
        
        //        if indexPath.row == 10 || indexPath.row == 11 {
        //          cell.btnswitch.isHidden=false
        //            if indexPath.row == 10 {
        //                if obj.prefs.value(forKey: SwitchValue) as? String == "On"{
        //                                cell.btnswitch.isOn = true
        //                            }else{
        //                                 cell.btnswitch.isOn = false
        //                            }
        //            }else{
        //                if obj.prefs.value(forKey: Notiswitchvalue) as? String == "On"{
        //                                cell.btnswitch.isOn = true
        //                            }else{
        //                                 cell.btnswitch.isOn = false
        //                            }
        //            }
        //
        //        }else{
        //           cell.btnswitch.isHidden=true
        //        }
        //
        //
        //       cell.btnswitch.tag=indexPath.row
        //
        //       cell.btnswitch.addTarget(self, action: #selector(Settheme(sender:)), for: .touchUpInside)
        //
        
        //            cell.btnswitch.isHidden=false
        //             cell.btnnotification.isHidden=true
        //            if obj.prefs.value(forKey: SwitchValue) as? String == "On"{
        //                cell.btnswitch.isOn = true
        //            }else{
        //                 cell.btnswitch.isOn = false
        //            }
        //        }
        //        else {
        //            cell.btnswitch.isHidden=true
        //
        //        }
        //
        //        if menuList[indexPath.section].list[indexPath.row].text == "Notification" {
        //            cell.btnnotification.isHidden=false
        //            cell.btnswitch.isHidden=true
        //        if obj.prefs.value(forKey: Notiswitchvalue) as? String == "On"{
        //                cell.btnnotification.isOn = true
        //            }else{
        //                 cell.btnnotification.isOn = false
        //            }
        //        } else {
        //
        //            cell.btnnotification.isHidden=true
        //
        //        }
        //
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (callBack != nil) {
            self.showSideMenu(false)
            SideMenuView.selectIndex = menuList[indexPath.section].list[indexPath.row].type
            callBack(menuList[indexPath.section].list[indexPath.row].type)
        }
    }
    
}

