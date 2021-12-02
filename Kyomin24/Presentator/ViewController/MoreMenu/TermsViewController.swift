//
//  TermsViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 05/07/21.
//

import UIKit
import Localize_Swift


class TermsViewController: BaseMoreMenuViewController {

    
    @IBOutlet weak var btnback: UIButton!
    
    @IBOutlet weak var txtview: UITextView!
    @IBOutlet weak var lblHeader: UILabel!
    
    var arrTerms = ["", "", "", "", "", "" , ""]
    var viewFrom: openFrom = .terms
    var vctype=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
      if Localize.currentLanguage() == "en" {
           self.btnback.transform=CGAffineTransform(rotationAngle:0)
          
       }else{
           self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
       }
       
        
        if viewFrom == .terms {
            lblHeader.text = "Terms of use".localized()
            TermAndPrivacyApi(slugkey: "terms-and-conition")
        }else {
            lblHeader.text = "Privacy Policy".localized()
            TermAndPrivacyApi(slugkey: "privacy-policy")
        }
        
        
        self.tabBarController?.tabBar.isHidden=true
       
        
        
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
//        self.openSideMenu()
        
         
    }
    
    
    func TermAndPrivacyApi(slugkey:String){
       let dictRegParam = [
        "slug":slugkey
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
    
    
    

}

//extension TermsViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrTerms.count// arrChat.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TermsTableViewCell.self), for: indexPath) as! TermsTableViewCell
//        //cell.setData(chatDict: arrChat[indexPath.row])
//        return cell
//    }
//}

//extension TermsViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//}


enum openFrom: String {
    case terms = "terms"
    case privacy = "privacy"
}
