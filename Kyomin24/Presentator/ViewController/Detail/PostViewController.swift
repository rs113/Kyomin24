//
//  PostViewController.swift
//  Mzadi
//
//  Created by Emizentech on 03/09/21.
//

import UIKit
import Localize_Swift

class PostViewController: UIViewController {
    
    @IBOutlet weak var txtview: UITextView!
    @IBOutlet weak var btnsubmit: DesignableButton!
    @IBOutlet weak var lblwriecommenttext: UILabel!
    
    var prenav:UINavigationController?
    var PostId=""
    var langAdd=""
    var vctype=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if vctype == "Detail"{
        if langAdd == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("ar")
        }else if langAdd == "ku"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("ku")
        }
        else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Localize.setCurrentLanguage("en")
        }
        }
        
        txtview.placeholder = "Type here".localized()
        Settext()
    }
    
    func Settext(){
        lblwriecommenttext.text="Write Comment".localized()
        btnsubmit.setTitle("Submit".localized(), for: .normal)
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
//        if vctype == "Detail"{
//           if langAdd == "ar" {
//
//               UIView.appearance().semanticContentAttribute = .forceLeftToRight
//               Localize.setCurrentLanguage("en")
//
//           }else{
//              UIView.appearance().semanticContentAttribute = .forceRightToLeft
//              Localize.setCurrentLanguage("ar")
//           }
//       }
    }
       
    
    
    @IBAction func btncross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnsubmit(_ sender: Any) {
        if self.txtview.text.isStringBlank() || self.txtview.text == "Type here".localized(){
            self.showCustomPopupView(altMsg: "Please type here".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        self.dismiss(animated: true) {
            self.PostComment()
        }
    }
    
    
    func PostComment(){
        let dictRegParam = [
            "post_id":PostId,
            "comment":txtview.text ?? ""
            
            ] as [String : Any]
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: AddCommentUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("nameOfNotification"), object: nil, userInfo: nil)
                }
                
            }
            else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            
            
        }) { (Strerr,stCode) in
           DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("error"), object: nil, userInfo: nil)
        }
        }
        
    }
    
    
}
