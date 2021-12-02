//
//  MyProfileVC.swift
//  Mzadi
//
//  Created by Emizen tech on 30/08/21.
//

import UIKit
import MessageUI
import Localize_Swift

class MyProfileDetailTblCell: UITableViewCell {
    
    
    @IBOutlet weak var lblprofilehint: UILabel!
    @IBOutlet weak var lblemailhint: UILabel!
    @IBOutlet weak var lblpublishad: UILabel!
    @IBOutlet weak var lbllocationhint: UILabel!
    @IBOutlet weak var lblmobilehint: UILabel!
    @IBOutlet weak var lblfollwinghint: UILabel!
    @IBOutlet weak var lblfollwershint: UILabel!
    @IBOutlet weak var lblposthint: UILabel!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var BtnArrow: UIButton!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblPost: UILabel!
    @IBOutlet weak var lblFollower: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblpost: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         Showtext()
    }
    
    func Showtext(){
        lblposthint.text="Post".localized()
        lblfollwershint.text="Followers".localized()
        lblfollwinghint.text="Following".localized()
        lblprofilehint.text="Profile".localized()
        lblmobilehint.text="Mobile".localized()
        lbllocationhint.text="Location".localized()
        lblemailhint.text="Email Id".localized()
        lblpublishad.text="Published ads".localized()
        
    }

}





class MyProfileVC: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var Btnreport: UIButton!
    @IBOutlet weak var LblProfile: UILabel!
    var Data: SellerModal?
    var sellerId = ""
    var vctype=""
    var shareurl=String()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if vctype=="profile"{
            Btnreport.isHidden=true
        }else{
            Btnreport.isHidden=false
        }
        getMyProfileData()
        
    NotificationCenter.default.addObserver(self, selector:#selector(Success), name: NSNotification.Name("Notification"), object: nil)
        
        if Localize.currentLanguage() == "en" {
            self.btnBack.transform=CGAffineTransform(rotationAngle:0)
                   
               }else{
               self.btnBack.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
       }
        
        Btnreport.setTitle("Report".localized(), for: .normal)
        
    }
    
    

    @objc func Success(){
        self.showCustomSnackAlert(altMsg: "Success".localized()) {
                self.dismiss(animated: true, completion: nil)
            }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    
    
    
    @objc func MovetoAddlist(Sender:UIButton){
        let vc = UserAddListViewController.instance(.myAccountTab) as! UserAddListViewController
        vc.SellerId = sellerId
        self.show(vc, sender: nil)
    }
    
    @objc func Call(sender:UIButton){
     callNumber(phoneNumber: Data?.data?.mobile ?? "")
    }
    
    @objc func Email(sender:UIButton){
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
         
        // Configure the fields of the interface.
        composeVC.setToRecipients([Data?.data?.email ?? ""])
//        composeVC.setSubject("Hello!")
//        composeVC.setMessageBody("Hello from California!", isHTML: false)
         
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
        
        
//        if MFMailComposeViewController.canSendMail() {
//        let mail = MFMailComposeViewController()
//        mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
//        mail.setToRecipients([Data?.data?.email ?? ""])
//        //mail.setCcRecipients([Data?.data?.email ?? ""])
//      //  mail.setMessageBody("<h1>Hello there, This is a test.<h1>", isHTML: true)
//        present(mail, animated: true)
//        } else {
//        print("Cannot send email")
//        }
//
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
   
    
    
    func callNumber(phoneNumber:String){
           if let phonecallUrl=URL(string: "TEl://\(Data?.data?.mobile ?? "")") {
               let application:UIApplication=UIApplication.shared
               if (application.canOpenURL(phonecallUrl)) {
                   application.open(phonecallUrl, options: [:], completionHandler: nil)
               }
           }
     }
    
    
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

 @IBAction func btnreport(_ sender: Any) {
    
     let vc = ReportAdViewController.instance(.main) as! ReportAdViewController
        vc.modalPresentationStyle = .custom
        vc.PostId=sellerId
        vc.prenav=self.navigationController
        self.present(vc, animated: true)
    
    }
    
    @IBAction func btnshare(_ sender: Any) {
        
        let headerJWT = ["type":"user",
                         "id":sellerId,
                        "name":Data?.data?.name ?? ""] as [String:Any]
            
            do {
                let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
                let headerJWTBase64 = headerJWTData.base64EncodedString()
                shareurl = headerJWTBase64
                print(headerJWTBase64)
                
        }
            
    
        //         // Setting description
       // let firstActivityItem = "Description you want.."
        
        // Setting url
        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl
        let secondActivityItem : NSURL = NSURL(string:sharingUrl)!
        
        // If you want to use an image
       // let image : UIImage = UIImage(named:obj.prefs.value(forKey: App_User_Img) as! String) ?? UIImage()
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}


extension MyProfileVC : UITableViewDataSource, UITableViewDelegate{
     func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if Data?.data != nil {
                return 1
            } else {
                return 0
            }
        }
        

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileDetailTblCell", for: indexPath) as! MyProfileDetailTblCell
            
            cell.userImg.sd_setImage(with: URL(string:Data?.data?.prifileImage ?? ""), placeholderImage: UIImage(named: ""))
            cell.lblRole.text = Data?.data?.role ?? ""
            cell.lblUsername.text = Data?.data?.name ?? ""
            cell.lblPost.text = Data?.data?.totalPost ?? ""
            cell.lblFollower.text = Data?.data?.followers ?? ""
            cell.lblFollowing.text = Data?.data?.following ?? ""
            cell.lblMobile.text = Data?.data?.mobile ?? ""
            
            
            cell.btnMobile.addTarget(self, action: #selector(Call(sender:)), for: .touchUpInside)
            
            
             if Data?.data?.email ?? "" == "" {
                cell.lblEmail.text="----"
            }else{
            cell.lblEmail.text = Data?.data?.email ?? ""
            cell.btnEmail.addTarget(self, action: #selector(Email(sender:)), for: .touchUpInside)
            }
        
            if Data?.data?.location ?? "" == "" {
                cell.lblLocation.text = "----"
            }else{
            cell.lblLocation.text = Data?.data?.location ?? ""
            }
            
            if Data?.data?.about ?? "" == "" {
                cell.lblDescription.text="----"
            }else{
            cell.lblDescription.text = Data?.data?.about ?? ""
            }
            
            let posttxt="Post's".localized()
            cell.lblpost.text="\(Data?.data?.totalPost ?? "") \(posttxt)"
            if Data?.data?.totalPost ?? "" == "0" {
                cell.BtnArrow.isHidden=true
            }else{
                cell.BtnArrow.isHidden=false
            }
            
            cell.BtnArrow.addTarget(self, action: #selector(MovetoAddlist(Sender:)), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileItemTblCell", for: indexPath) as! MyProfileItemTblCell
            cell.colletionview.tag=indexPath.row
            cell.VC=self
            cell.config(data: Data?.data?.product ?? [SellerProduct]())
            return cell
        }

    }
}

extension MyProfileVC {
    func getMyProfileData(){
        let dictParam = ["seller_id":"\(sellerId)"]


        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: SellerUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SellerModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                print(ResponseJson)
                if stCode == 200{
                    self.Data = resModel
                    let protxt = "profile".localized()
                    self.LblProfile.text = "\(self.Data?.data?.name ?? "") \(protxt)"
                    self.tableview.reloadData()
                }else{
                    self.tableview.reloadData()
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
