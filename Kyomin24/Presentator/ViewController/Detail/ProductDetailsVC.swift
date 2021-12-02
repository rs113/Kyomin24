//
//  ProductDetailsVC.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit
import Localize_Swift
import SDWebImage
import GoogleMaps
import CoreLocation
import AVFoundation
import AVKit
import MessageUI
import Toast_Swift
import FacebookCore
import FacebookShare

class ProductDetailsVC: UIViewController,MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var btnchat: UIButton!
    
    @IBOutlet weak var btnsms: UIButton!
    @IBOutlet weak var btnwhatsapp: UIButton!
    @IBOutlet weak var btncall: UIButton!
    @IBOutlet weak var ChatHeight: NSLayoutConstraint!
    @IBOutlet weak var CallChatView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var productId = ""
    var detailsArr:ProductDetailModal?
    var vctype=""
    var followId = ""
    var followDictionary : FollowModal?
    var Arrlike:LikeUnlikeModal?
    var postId = ""
    var SellerData: SellerModal?
    var Sellerid=""
    var Boolvalue=false
    var window: UIWindow?
    var Followvalue=false
    var userfollow=false
    var userlike=false
    var langadd=""
    
    var shareurl=String()
    var roomid=""
    
    var btnstate=false
    
    var firstuserfollow=false
    var seconduserfollow=false
    
    fileprivate var tableItems:[ChatRoomModel] = []
    
    static var userDetailsList: [String: UserDetailsModel] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketManager.shared.registerToScoket(observer: self)
       
        ShowView()
        btnstate=false
        
        
        self.getProductDetail()
    
        NotificationCenter.default.addObserver(self, selector:#selector(noticall), name: NSNotification.Name("nameOfNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(Success), name: NSNotification.Name("Notification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(Error), name: NSNotification.Name("error"), object: nil)
        
        
        
        
        
    }
    
    
    

    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let currentlanguage = obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
        
         if vctype == "Detail"{
        if currentlanguage == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage(currentlanguage)
            
        }else if currentlanguage == "ku" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
         Localize.setCurrentLanguage(currentlanguage)
        }else{
            
           UIView.appearance().semanticContentAttribute = .forceLeftToRight
           Localize.setCurrentLanguage(currentlanguage)
        }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden=true
         
        if vctype == "Detail"{
        if langadd == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("ar")
        }else if langadd == "ku"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("ku")
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Localize.setCurrentLanguage("en")
        }
        }
        
        Showtext()
        
        if vctype == "Detail" {
        Setbtnconstarint()
        }else{
         Setbuttonconstraint()
        }
        
        
    }
    
    
    func Showtext(){
        btnchat.setTitle("Chat".localized(), for: .normal)
        btncall.setTitle("Call".localized(), for: .normal)
        btnsms.setTitle("Sms".localized(), for: .normal)
        btnwhatsapp.setTitle("WhatsApp".localized(), for: .normal)
    }
    
    
    @objc func noticall() {
        self.getProductDetail()
        self.showCustomSnackAlert(altMsg: "Success".localized()) {
            self.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    func Setbtnconstarint(){
        
            if langadd == "en" {
                btnsms.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
                btncall.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right:0)
                btnchat.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            }else{
                btnsms.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
                btncall.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
                btnchat.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)

            }
        
    }
    
    
    func Setbuttonconstraint(){
        
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "en" {
        btnsms.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        btncall.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right:0)
        btnchat.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        }else {
            btnsms.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
            btncall.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
            btnchat.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)


        }

    }
    
    
    
    
    
    func ShowView(){
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            CallChatView.isHidden=true
            ChatHeight.constant = 0
        }else{
            if vctype == "Postsuccess" || vctype == "profile" || productId != detailsArr?.data?.sellerProfile?.id ?? ""{
                CallChatView.isHidden=true
                ChatHeight.constant = 0
            }else{
                CallChatView.isHidden=false
                ChatHeight.constant = 80
            }
        }
        
    }
    
    
    @objc func Success(){
        self.showCustomSnackAlert(altMsg: "Success".localized()) {
            self.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func Error(){
        self.showCustomPopupView(altMsg:"Not authorized to access".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func BackView(sender:UIButton){
        if Boolvalue == true {
            DispatchQueue.main.async {
                self.PopToSpecificController(vcMove: HomeView.self)
            }
        }
        else{
            
//            if langadd == "ar" {
//                Localize.setCurrentLanguage("en")
//            }else{
//                Localize.setCurrentLanguage("ar")
//            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btncall(_ sender: Any) {
        callNumber(phoneNumber: self.SellerData?.data?.mobile ?? "")
    }
    
    @IBAction func btnwhatapp(_ sender: Any) {
        let phoneNumber =  "\(self.SellerData?.data?.mobile ?? "")" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            // WhatsApp is not installed
        }
    }
    @IBAction func btnchat(_ sender: Any) {
        if roomid != ""{
            let vc: ChatViewController = ChatViewController()
            vc.roomId=roomid
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
        
        
        
        
    }
    @IBAction func btnsms(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [self.SellerData?.data?.mobile ?? ""]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func RegisterUseronSocketServer(){
        let messageDictionary = [
            "request": "login",
            "userId": obj.prefs.value(forKey: APP_USER_ID) as? String ?? "",
            "type": "loginOrCreate",
            "fcm_token":obj.prefs.value(forKey: APP_FCM_TOKEN) ?? "",
            "userName":obj.prefs.value(forKey: APP_MOBILE_NUM) ?? "",
            "firstName":obj.prefs.value(forKey: APP_USER_NAME) ?? "",
            "password": "12345678",
            "profile_pic":obj.prefs.value(forKey: App_User_Img) ?? "",
            "lastSeen":Date().currentTimeMillis()
            
            ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        if let message:String = jsonString as String?{
            SocketManager.shared.sendMessageToSocket(message: message)
            
        }
        
        let uDetail =   UserModel.getSchoolDataModel()
        let json: [String: Any] = ["type": "createRoom",
                                   "userList": [uDetail.user_id , detailsArr?.data?.sellerProfile?.id ?? ""],
                                   "createBy": uDetail.user_id,
                                   "request":"room"]
        
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    @IBAction func BtnContactAction(_ sender: Any) {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
            
        }else{
            let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
            vc.sellerId = detailsArr?.data?.sellerProfile?.id ?? ""
            vc.vctype=vctype
            Localize.setCurrentLanguage(obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en")
            self.show(vc, sender: nil)
        }
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func sendSMS(with text: String) {
        if MFMessageComposeViewController.canSendText() {
            let messageComposeViewController = MFMessageComposeViewController()
            messageComposeViewController.body = text
            present(messageComposeViewController, animated: true, completion: nil)
        }
    }
    
    func callNumber(phoneNumber:String){
        if let phonecallUrl=URL(string: "TEl://\(self.SellerData?.data?.mobile ?? "")") {
            let application:UIApplication=UIApplication.shared
            if (application.canOpenURL(phonecallUrl)) {
                application.open(phonecallUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func MoveToMap(sender:UIButton){
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(detailsArr?.data?.location?.lat ?? "") ?? 0),\(detailsArr?.data?.location?.long ?? "") ?? 0)&zoom=14&views=traffic&q=\(detailsArr?.data?.location?.lat ?? "") ?? 0),\(detailsArr?.data?.location?.lat ?? "") ?? 0)")!, options: [:], completionHandler: nil)
            //        UIApplication.shared.openURL(NSURL(string:
            //            "comgooglemaps://?saddr=&daddr=\(Cardetail.parkedCarLat),\(Cardetail.parkedCarLong)")! as URL)
            
        }
            //        else if (UIApplication.shared.canOpenURL(NSURL(string:"http://maps.apple.com")! as URL)) {
            //            UIApplication.shared.openURL(NSURL(string:
            //                  "http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino)!)
            //                ) as URL as URL}
        else {
            // if GoogleMap App is not installed
            UIApplication.shared.openURL(NSURL(string:
                "https://maps.google.com/?q=@\(Float(detailsArr?.data?.location?.lat ?? "")!),\(Float(detailsArr?.data?.location?.long ?? "")!)")! as URL)
            
        }
        
        
    }
    
    @objc func didTapLikebtn(_ sender: UIButton) {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!", alertimg: UIImage(named: "Infoimg".localized()) ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
        }else{
            self.LikeApi()
        }
    }
    
    
    
    
    
    
    @objc func PostComment(Sender:UIButton){
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
        }else{
            let vc = PostViewController.instance(.main) as! PostViewController
            vc.modalPresentationStyle = .custom
            vc.prenav=self.navigationController
            vc.langAdd=langadd
            vc.PostId=postId
            vc.vctype=vctype
            self.present(vc, animated: true)
            
        }
        
    }
    
    @objc func ReportAd(Sender:UIButton){
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
        }else{
            
            let vc = ReportAdViewController.instance(.main) as! ReportAdViewController
            vc.modalPresentationStyle = .custom
            vc.PostId=detailsArr?.data?.sellerProfile?.id ?? ""
            vc.langAdd=langadd
            vc.vctype=vctype
            vc.prenav=self.navigationController
            self.present(vc, animated: true)
        }
        
    }
    
    
    
    
    
    @objc func CopyLinkClipBoard(sender:UIButton){
        btnstate=true
        
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 6)) as! ProductShareOnTblCell
        
        let headerJWT = ["type":"post",
                         "id":productId] as [String:Any]
        
        do {
            let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            shareurl = headerJWTBase64
            print(headerJWTBase64)
            
        }
        
        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl
        
        
        
        if btnstate{
            cell.imgcopy.image = UIImage(named: "right")
            if vctype == "Detail"{
                if langadd == "ar" {
            cell.lblcopy.text="نسخ".localized()
                }else if langadd == "ku"{
                  cell.lblcopy.text="Copy".localized()
                }else{
             cell.lblcopy.text="Copy".localized()
                }
            }else{
             cell.lblcopy.text="Copy".localized()
            }
            
            // present the toast with the new style
            if vctype == "Detail"{
                if langadd == "ar" {
            self.view.makeToast("Copy To Clipboard".localized(), duration: 3.0, position: .bottom)
                }else if langadd == "ku"{
            self.view.makeToast("Copy To Clipboard".localized(), duration: 3.0, position: .bottom)
                }else{
              self.view.makeToast("Copy To Clipboard".localized(), duration: 3.0, position: .bottom)
                }
            }else{
              self.view.makeToast("Copy To Clipboard".localized(), duration: 3.0, position: .bottom)
            }
           
            
            // write to clipboard
            UIPasteboard.general.string = sharingUrl
            
            // read from clipboard
            let content = UIPasteboard.general.string
        }
        
    }
    
    
    @objc func ShareonWhatsapp(sender:UIButton){
        let headerJWT = ["type":"post",
                         "id":productId] as [String:Any]
        
        do {
            let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            shareurl = headerJWTBase64
            print(headerJWTBase64)
            
        }
        
        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl
        let secondActivityItem : NSURL = NSURL(string:sharingUrl)!
        
        
        let urlWhats = "whatsapp://send?text=\(sharingUrl)"
        
        
        
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL)
                } else {
                    self.showCustomPopupViewAction(altMsg:"Please Install WhatsApp".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                        popup.dismiss(animated: true, completion: {
                        })
                    })
                }
            }
        }
        
        
    }
    
    
    @objc func ShareonTelegram(sender:UIButton){
        
        let headerJWT = ["type":"post",
                         "id":productId] as [String:Any]
        
        do {
            let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            shareurl = headerJWTBase64
            print(headerJWTBase64)
            
        }
        
        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl
        
     //   let urlWhats = "whatsapp://send?text=\(sharingUrl)"

        let botURL = NSURL(string: "tg://msg?text=\(sharingUrl)")!
    
        if UIApplication.shared.canOpenURL(botURL as URL){
            
            UIApplication.shared.open(botURL as URL)
        } else {
            self.showCustomPopupViewAction(altMsg:"Telegram is not installed.", alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                })
            })
        }
        
    }
    
    
    
    @objc func ShareOnTwitter(sender:UIButton){
        
        
        let headerJWT = ["type":"post",
                         "id":productId] as [String:Any]
        
        do {
            let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            shareurl = headerJWTBase64
            print(headerJWTBase64)
            
        }
        
        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl
        
        
       
        let appURL = NSURL(string: "twitter://user?screen_name=\(sharingUrl)")!
        let webURL = NSURL(string: "https://twitter.com/\(sharingUrl)")!

        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
             application.open(appURL as URL)
        } else {
             application.open(webURL as URL)
        }
    }
    
    
    
    @objc func ShareonInstagram(sender:UIButton){

        let headerJWT = ["type":"post",
                         "id":productId] as [String:Any]

        do {
            let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            shareurl = headerJWTBase64
            print(headerJWTBase64)

        }

        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl

//        let instagramUrl = URL(string: "instagram://app")
//        UIApplication.shared.canOpenURL(instagramUrl!)
//        UIApplication.shared.open(instagramUrl!, options: [:], completionHandler: nil)
//
        let appURL = URL(string: "instagram://msg?text=\(sharingUrl)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/\(sharingUrl)")!
            application.open(webURL)
        }
    }
    
    
    
    @objc func ShareonFacebbok(sender:UIButton){

            let headerJWT = ["type":"post",
                             "id":productId] as [String:Any]

            do {
                let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
                let headerJWTBase64 = headerJWTData.base64EncodedString()
                shareurl = headerJWTBase64
                print(headerJWTBase64)

            }

            let baseurl = "https://mzadi.ezxdemo.com/shu"
            let sharingUrl = baseurl + "/" + shareurl

        
        
        
          let shareContent = ShareLinkContent()
          shareContent.contentURL = URL.init(string:sharingUrl)! //your link
          ShareDialog(fromViewController: self, content: shareContent, delegate: nil).show()
        
        
    
        }
        
        
        
        

    
    
    @objc func ReportView(Sender:UIButton){
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
        }else{
            let vc = ReportViewController.instance(.main) as! ReportViewController
            vc.modalPresentationStyle = .custom
            vc.PostId=postId
            vc.langAdd=langadd
            vc.vctype=vctype
            vc.prenav=self.navigationController
            self.present(vc, animated: true)
        }
        
        
    }
    
    
    
    
    
    
    
}

extension ProductDetailsVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
            
        case 2:
            return "Product Detail".localized()
        case 3:
            return "Description".localized()
        case 4:
            return "Filter".localized()
        case 5:
            return "Location".localized()
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(red: 53/255, green: 71/255, blue: 82/255, alpha: 1)
        }else{
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
        }
        
        //(view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section
        {
        case 2:
            return 35
        case 3:
            return 35
        case 4:
            if detailsArr?.data?.filter?.count != 0 {
                return 30
            } else {
                return 0
            }
            
        case 5:
            if ((detailsArr?.data?.location) != nil) {
                if detailsArr?.data?.location?.location != ""{
                    return 30
                } else {
                    return 0
                }
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if ((detailsArr?.data) != nil){
                return 1
            } else {
                return 0
            }
        case 1:
            if ((detailsArr?.data?.sellerProfile) != nil){
                return 1
            } else {
                return 0
            }
        case 2:
            return detailsArr?.data?.productDetails?.count ?? 0
        case 3:
            if detailsArr?.data?.dataDescription?.count != 0 {
                return 1
            } else {
                return 0
            }
        case 4:
            return detailsArr?.data?.filter?.count ?? 0
        case 5:
            if ((detailsArr?.data?.location) != nil) {
                if detailsArr?.data?.location?.location != ""{
                    return 1
                } else {
                    return 0
                }
            } else {
                return 0
            }
        case 6:
            return 1
        default:
            return detailsArr?.data?.comments?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductImageTblCell", for: indexPath) as! ProductImageTblCell
            cell.backBtn.tag=indexPath.row
            cell.backBtn.addTarget(self, action: #selector(BackView(sender:)), for: .touchUpInside)
            cell.lblTime.text = detailsArr?.data?.postDate ?? ""
            cell.lblTitle.text = detailsArr?.data?.title ?? ""
            cell.lblPrice.text = "\(detailsArr?.data?.price ?? "") IQD"
            
            
            if Followvalue == false {
                cell.lblView.text = detailsArr?.data?.totalView ?? ""
            }
            
            
            cell.collectionview.tag=indexPath.row
            cell.config(data: detailsArr?.data?.photo ?? [Photo]())
            cell.VC=self
            
            
            postId = detailsArr?.data?.id ?? ""
            if seconduserfollow == false
            {
                cell.lblLikeCount.text = detailsArr?.data?.totalFav ?? ""
                
                if detailsArr?.data?.isFavourite ?? "" == "0"  {
                    cell.btnLike.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                    
                }else{
                    cell.btnLike.setImage(#imageLiteral(resourceName: "redfavorite"), for: .normal)
                    
                }
                
            }else
            {
                
                
                if userlike == true {
                    cell.btnLike.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                    
                }else{
                    cell.btnLike.setImage(#imageLiteral(resourceName: "redfavorite"), for: .normal)
                    
                }
                
            }
            
            
            
            
            
            //            if detailsArr?.data?.isFavourite ?? "" == "0" {
            //                cell.btnLike.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            //            } else {
            //                cell.btnLike.setImage(#imageLiteral(resourceName: "redfavorite"), for: .normal)
            //            }
            cell.btnLike.addTarget(self, action: #selector(didTapLikebtn), for: .touchUpInside)
            if vctype == "Detail"{
                if langadd == "en"{
                 cell.backBtn.transform=CGAffineTransform(rotationAngle:0)
                }else{
                cell.backBtn.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
                }
            }else{
            if Localize.currentLanguage() == "en"{
                cell.backBtn.transform=CGAffineTransform(rotationAngle:0)
            }else{
                cell.backBtn.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
              }
            }
            
            self.Followvalue=true
            seconduserfollow=true
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSellerTblCell", for: indexPath) as! ProductSellerTblCell
            
            cell.lblUsername.text = detailsArr?.data?.sellerProfile?.name
            
            cell.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgUser.sd_setImage(with: URL(string: detailsArr?.data?.sellerProfile?.profile ?? ""), placeholderImage: UIImage(named: ""))
            
            followId = detailsArr?.data?.sellerProfile?.id ?? ""
            cell.btnContact.addTarget(self, action: #selector(didTapContactButton), for: .touchUpInside)
            cell.btnFollow.addTarget(self, action: #selector(didTapfollowbtn), for: .touchUpInside)
            
            if firstuserfollow == false
            {
                let followtxt = "Followers".localized()
                cell.lblFollower.text = "\(detailsArr?.data?.sellerProfile?.totalFollowers ?? "") \(followtxt) "
                
                if detailsArr?.data?.sellerProfile?.totalFollowers == "1" {
                    cell.btnFollow.setTitle("Unfollow".localized(), for: .normal)
                    
                }else{
                    cell.btnFollow.setTitle("Follow".localized(), for: .normal)
                    
                }
                
            }else
            {
                
                
                if userfollow == true {
                    cell.btnFollow.setTitle("Follow".localized(), for: .normal)
                    cell.lblFollower.text = "0 Followers".localized()
                }else{
                    cell.btnFollow.setTitle("Unfollow".localized(), for: .normal)
                    cell.lblFollower.text = "1 Followers".localized()
                }
                
            }
            
            if vctype == "Postsuccess" || vctype == "profile" || productId != detailsArr?.data?.sellerProfile?.id ?? ""{
                cell.btnFollow.isHidden=true
                cell.Btnreport.isHidden=true
            }else{
                cell.btnFollow.isHidden=false
                cell.Btnreport.isHidden=false
                
            }
            
            
            
            cell.Btnreport.addTarget(self, action: #selector(ReportAd(Sender:)), for: .touchUpInside)
            firstuserfollow=true
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTblCell", for: indexPath) as! ProductDetailTblCell
            cell.lblTitle.text = detailsArr?.data?.productDetails?[indexPath.row].title ?? ""
            cell.lblValue.text = detailsArr?.data?.productDetails?[indexPath.row].value ?? ""
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTblCell", for: indexPath) as! ProductDescriptionTblCell
            
            
            cell.lbl.textColor = UIColor(red: 53/255, green: 71/255, blue: 82/255, alpha: 1)
            
            
            cell.lbl.backgroundColor = UIColor(red: 235/255, green: 237/255, blue: 241/255, alpha: 1)
            
            cell.lbl.text = " \(detailsArr?.data?.dataDescription ?? "")"
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductFilterTblCell", for: indexPath) as! ProductFilterTblCell
            cell.filter = (detailsArr?.data?.filter) ?? []
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductLocationTblCell", for: indexPath) as! ProductLocationTblCell
            cell.lblAddress.text=detailsArr?.data?.location?.location
            cell.MapView.tag=indexPath.row
            var maplati=Double()
            maplati = Double(detailsArr?.data?.location?.lat ?? "") ?? 0
            var maplong=Double()
            maplong=Double(detailsArr?.data?.location?.long ?? "") ?? 0
            // markerpark(mapLat:maplati, mapLong: maplong)
            
            cell.MapView.backgroundColor = .red
            let camera = GMSCameraPosition.camera(withLatitude:maplati, longitude:maplong, zoom: 12.0)
            cell.MapView?.animate(to: camera)
            cell.MapView.isMyLocationEnabled=false
            let cellmarker=GMSMarker()
            cellmarker.position=CLLocationCoordinate2D(latitude:maplati, longitude:maplong)
            cellmarker.icon=UIImage(named:"pinred")
            cellmarker.map=cell.MapView
            cell.btngetdirection.addTarget(self, action: #selector(MoveToMap(sender:)), for: .touchUpInside)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductShareOnTblCell", for: indexPath) as! ProductShareOnTblCell
            let cmnt = "Comment".localized()
            cell.lblCommentCount.text="\(detailsArr?.data?.comments?.count ?? 0) \(cmnt)"
            cell.BtnPostComment.addTarget(self, action: #selector(PostComment(Sender:)), for: .touchUpInside)
            cell.btnwhatsapp.addTarget(self, action: #selector(ShareonWhatsapp(sender:)), for: .touchUpInside)
            
            
            cell.btncopylink.tag=indexPath.row
            cell.btncopylink.addTarget(self, action: #selector(CopyLinkClipBoard(sender:)), for: .touchUpInside)
            
            cell.btntelegram.addTarget(self, action: #selector(ShareonTelegram(sender:)), for: .touchUpInside)
            
            cell.btntwitter.addTarget(self, action: #selector(ShareOnTwitter(sender:)), for: .touchUpInside)
            
//
           cell.btninstagram.addTarget(self, action: #selector(ShareonInstagram(sender:)), for: .touchUpInside)
            
            cell.btnfacebook.addTarget(self, action: #selector(ShareonFacebbok(sender:)), for: .touchUpInside)
            
            if vctype == "Postsuccess" || vctype == "profile" {
                cell.btnReport.isHidden = true
            }else{
                cell.btnReport.isHidden=false
            }
            cell.btnReport.addTarget(self, action: #selector(ReportView(Sender:)), for: .touchUpInside)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCommentTblCell", for: indexPath) as! ProductCommentTblCell
            cell.lblTitle.text = detailsArr?.data?.comments?[indexPath.row].userName
            cell.lblTime.text = detailsArr?.data?.comments?[indexPath.row].createdAt
            cell.lblDescription.text = detailsArr?.data?.comments?[indexPath.row].comment
            cell.imgUser.sd_setImage(with: URL(string: detailsArr?.data?.comments?[indexPath.row].userProfile ?? ""), placeholderImage: UIImage(named: ""))
            
            cell.btndelete.tag=indexPath.row
            
            
            
            
            if detailsArr?.data?.comments?[indexPath.row].userID == UserModel.getSchoolDataModel().user_id  {
                cell.btndelete.isHidden=false
                cell.btndelete.addTarget(self, action:#selector(DeleteComment(sender:)), for: .touchUpInside)
            }else{
                cell.btndelete.isHidden=true
            }
            
            
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 7 {
            let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
            vc.sellerId = detailsArr?.data?.comments?[indexPath.row].userID ?? ""
            self.show(vc, sender: nil)
        }
    }
    
    
}


extension ProductDetailsVC {
    @objc func didTapContactButton(_ sender: Any) {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
        }else{
            let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
            vc.sellerId = detailsArr?.data?.sellerProfile?.id ?? ""
            vc.vctype="profile"
            Localize.setCurrentLanguage(obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en")
            self.show(vc, sender: nil)
        }
    }
    
    @objc func didTapfollowbtn(_ sender: UIButton) {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.MovetoLogin()
                    self.tabBarController?.tabBar.isHidden = true
                })
            })
        }else{
            self.getFollowApi()
            
            
            
        }
    }
    
    @objc func DeleteComment(sender:UIButton){
        let dictParam = ["post_id": postId,
                         "comment_id":detailsArr?.data?.comments?[sender.tag].id]
        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: DeleteCommentUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam as [String : Any], responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            
            if stCode == 200{
                self.getProductDetail()
            }else{
                
            }
        }) { (stError) in
            
        }
    }
}

extension ProductDetailsVC{
    func LikeApi(){
        let dictParam = ["post_id": postId]
        
        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: FavStatusUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: LikeUnlikeModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(ResponseJson)
            if stCode == 200{
                self.Arrlike = resModel
                if self.Arrlike?.data.postID == nil {
                    self.userlike=true
                }else{
                    self.userlike=false
                }
                self.tableView.reloadData()
                
            }else{
                self.userlike=true
                self.tableView.reloadData()
                //                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                //                    self.dismiss(animated: true, completion: nil)
                //                })
            }
        }) { (stError) in
            self.userlike=true
            self.tableView.reloadData()
            //            self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
            //                self.dismiss(animated: true, completion: nil)
            //            })
            
        }
    }
    
    
}



extension ProductDetailsVC {
    func getFollowApi(){
        let dictParam = ["followed_id": followId]
        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: FollowUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: FollowModal.self, success: { [self] (ResponseJson, resModel, st) in
            print(ResponseJson)
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.followDictionary = resModel
                
                if self.followDictionary?.data.followedID == nil {
                    self.userfollow=true
                }else{
                    self.userfollow=false
                }
                
                self.tableView.reloadData()
                //self.getProductDetail()
            }else{
                self.userfollow=true
                self.tableView.reloadData()
                //                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                //                    self.dismiss(animated: true, completion: nil)
                //                })
            }
        }) { (stError) in
            self.userfollow=true
            self.tableView.reloadData()
            //            self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
            //                self.dismiss(animated: true, completion: nil)
            //            })
        }
    }
}


extension ProductDetailsVC {
    func getProductDetail(){
        var selectlang=""
        if vctype == "Detail"{
          selectlang = langadd
        }else{
            selectlang=obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
        }
        let dictParam = ["product_id": productId,
                         "lang":selectlang]
        print(dictParam)
        
        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: ProductDetailUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: ProductDetailModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.detailsArr = resModel
                self.RegisterUseronSocketServer()
                if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
                    print("gfhjsgddsjdhs")
                }else{
                    self.getMyProfileData(Sellerid: self.detailsArr?.data?.sellerProfile?.id ?? "")
                }
                self.tableView.isHidden=false
                self.tableView.reloadData()
                
            }else{
                self.tableView.isHidden=false
                self.tableView.reloadData()
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
    
    
    func getMyProfileData(Sellerid:String){
        let dictParam = ["seller_id":Sellerid]
        
        
        print(dictParam)
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: SellerUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SellerModal.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(ResponseJson)
            if stCode == 200{
                self.SellerData = resModel
                
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
}




extension ProductDetailsVC: SocketObserver {
    func registerFor() -> [ResponseType] {
        return [.createRoom]
    }
    
    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        
        print(data)
        
        
        if (observerWithIdentifire == .createRoom){
            if let data = data["data"] as? [String: Any] {
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                
                tmpUserList.forEach { (element) in
                    ChatListView.userDetailsList[element.userId] = element
                }
                if let newRoom = data["newRoom"] as? [String: Any] {
                    let updatedRoom = ChatRoomModel(disc: newRoom)
                    roomid = newRoom["_id"] as? String ?? ""
                    tableItems.append(updatedRoom)
                }
                
                
                
                
                
                
                
                
            }
        }
    }
    
    func socketConnection(status: SocketConectionStatus) {
        print("websocket connected!!")
    }
    
    
    
}

