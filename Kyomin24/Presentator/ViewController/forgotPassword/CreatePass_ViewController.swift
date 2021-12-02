//
//  CreatePass_ViewController.swift
//  Kyomin24
//
//  Created by emizen on 11/29/21.
//

import UIKit

class CreatePass_ViewController: UIViewController {
    
    @IBOutlet weak var CofirmPassTxt: UITextField!
    @IBOutlet weak var newPassTxt: UITextField!
    var EmailStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func ConfirmBtn(_ sender: Any) {
        
        if newPassTxt.text == "" {
            
            self.showCustomPopupView(altMsg:"Please enter new password.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else if CofirmPassTxt.text == "" {
            
            self.showCustomPopupView(altMsg:"Please enter confirm password.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else if newPassTxt.text != CofirmPassTxt.text  {
            
            self.showCustomPopupView(altMsg:"Password confirmation doesn't match Password".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else {
            
            NewPassApi()
        }
        
    }
    
    
    func NewPassApi() {
        
        print(EmailStr)
        
        let dictRegParam = [
            
            
            "email": EmailStr,
            "new_password":newPassTxt.text ?? ""
            
            
        ]  as [String : Any]
        
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: ResetPass, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
            
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
    
}
