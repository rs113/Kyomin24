//
//  ShareViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.
//

import UIKit
import Localize_Swift
import FacebookCore
import FacebookShare


class ShareViewController: BaseMoreMenuViewController {
    
    @IBOutlet weak var lblfacebbokhint: UILabel!
    @IBOutlet weak var lbltwitterhint: UILabel!
    @IBOutlet weak var lblinstagramhint: UILabel!
    @IBOutlet weak var lblwhatsapphint: UILabel!
    @IBOutlet weak var lbltelegramhint: UILabel!
    @IBOutlet weak var lblsharehint: UILabel!
    @IBOutlet weak var lblsharemzadihint: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var viewInsta: DesignableView!
    
    var vctype=""
    var shareurl="https://www.apple.com/in/app-store/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tabBarController?.tabBar.isHidden=true
       if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        setGradientColor(startColor: #colorLiteral(red: 0.7725490196, green: 0, blue: 0.5568627451, alpha: 1), endColor: #colorLiteral(red: 0.9294117647, green: 0, blue: 0.09803921569, alpha: 1))
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setGradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.viewInsta.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.viewInsta.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    func Settext(){
        lblsharehint.text="Share Mazadi".localized()
        lblfacebbokhint.text="FACEBOOK".localized()
        lbltwitterhint.text="TWITTER".localized()
        lblinstagramhint.text="INSTAGRAM".localized()
        lblwhatsapphint.text="WHATSAPP".localized()
        lbltelegramhint.text="TELEGRAM".localized()
        lblsharehint.text="SHARE MZADI".localized()
    }
    
    
    @IBAction func btnFacebook(_ sender: Any) {
        
                 let shareContent = ShareLinkContent()
                 shareContent.contentURL = URL.init(string:shareurl)! //your link
                 ShareDialog(fromViewController: self, content: shareContent, delegate: nil).show()
        
    }
    
    @IBAction func btnTwitter(_ sender: Any) {
        let appURL = NSURL(string: "twitter://user?screen_name=\(shareurl)")!
               let webURL = NSURL(string: "https://twitter.com/\(shareurl)")!

               let application = UIApplication.shared

               if application.canOpenURL(appURL as URL) {
                    application.open(appURL as URL)
               } else {
                    application.open(webURL as URL)
               }
    }
    
    
    @IBAction func btnInstagram(_ sender: Any) {
        let appURL = URL(string: "instagram://msg?text=\(shareurl)")!
               let application = UIApplication.shared

               if application.canOpenURL(appURL) {
                   application.open(appURL)
               } else {
                   // if Instagram app is not installed, open URL inside Safari
                   let webURL = URL(string: "https://instagram.com/\(shareurl)")!
                   application.open(webURL)
               }
    }
    
    
    @IBAction func btnWhatsapp(_ sender: Any) {
        let urlWhats = "whatsapp://send?text=\(shareurl)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
        if let whatsappURL = NSURL(string: urlString) {
            if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                UIApplication.shared.open(whatsappURL as URL)
            } else {
                self.showCustomPopupViewAction(altMsg:"Please Install WhatsApp", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM", OkAction: {popup in
                    popup.dismiss(animated: true, completion: {
                    })
                })
            }
        
    }
            
        }
        
    }
    
    
    @IBAction func btntelegram(_ sender: Any) {
        
            let botURL = NSURL(string: "tg://msg?text=\(shareurl)")!
        
            if UIApplication.shared.canOpenURL(botURL as URL){
                
                UIApplication.shared.open(botURL as URL)
            } else {
                self.showCustomPopupViewAction(altMsg:"Telegram is not installed.", alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                    popup.dismiss(animated: true, completion: {
                    })
                })
            }
    }
    
    
    @IBAction func btnSharemzadi(_ sender: Any) {

               let secondActivityItem : NSURL = NSURL(string:shareurl)!
               
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
    
    // MARK: - Action
    @IBAction func actionMenu(_ sender: Any) {
//        let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
//        UIApplication.currentViewController()?.navigationController?.setViewControllers([vc], animated: true)
         if vctype == "sidemenu"{
                NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
                self.navigationController?.popViewController(animated: true)
                }else{
               NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
               self.navigationController?.popViewController(animated: true)
                }
    }
}
