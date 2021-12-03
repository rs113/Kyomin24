//
//  ChagnePass_ViewController.swift
//  Kyomin24
//
//  Created by emizen on 12/2/21.
//

import UIKit

class ChagnePass_ViewController: UIViewController {

    @IBOutlet weak var ConfirmPassTxt: UITextField!
    @IBOutlet weak var NewPassTxt: UITextField!
    @IBOutlet weak var oldPassTxt: UITextField!
    
    var EmailStrPass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ContinueBtnClicked(_ sender: Any) {
        
        if oldPassTxt.text == "" {
            
            self.showCustomPopupView(altMsg:"Please enter old password.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else if NewPassTxt.text == "" {
            
            self.showCustomPopupView(altMsg:"Please enter new password.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else if ConfirmPassTxt.text == "" {
            
            self.showCustomPopupView(altMsg:"Please enter confirm password.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        else if NewPassTxt.text != ConfirmPassTxt.text  {
            
            self.showCustomPopupView(altMsg:"Password confirmation doesn't match Password".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }else {
            
            ChangePass()
        }
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    func ChangePass() {
        
        
        let dictRegParam = [
            
            
            "email": EmailStrPass,
            "old_password": oldPassTxt.text ?? "",
            "password":  NewPassTxt.text ?? "",
            "password_confirmation": ConfirmPassTxt.text ?? ""

            
        ]  as [String : Any]
        
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: changepassword, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            
            if stCode == 200{
                
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Success".localized(), alertimg: UIImage(named: "") ?? UIImage(), OkAction: {
                 
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)

                })
                
                
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
