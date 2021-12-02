//
//  AboutViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.
//

import UIKit
import Localize_Swift

class AboutViewController: BaseMoreMenuViewController {
    
    @IBOutlet weak var LBLABOUTHINT: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var txtview: UITextView!
     var vctype=""
    override func viewDidLoad() {
        super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden=true

  if Localize.currentLanguage() == "en" {
       self.btnback.transform=CGAffineTransform(rotationAngle:0)
      
   }else{
       self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
   }
        
        LBLABOUTHINT.text="About Mzadi".localized()
   
      AboutMzadiApi()

        
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
    
    func AboutMzadiApi(){
       let dictRegParam = [
        "slug":"about-us"
        ]  as [String : Any]
    
    
        print(dictRegParam)
           
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: GetCmsUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
            let resdata = ResponseJson["data"].dictionary
            let content = resdata?["html"]?.string
            
           self.txtview.attributedText = content?.htmlToAttributedString
                if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                 self.txtview.textColor = .white
                }else{
                 self.txtview.textColor = .black
                }
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
               })
            }
            
        }) { (Strerr,stCode) in
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
            self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
    
    
    
}
