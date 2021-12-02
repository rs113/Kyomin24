//
//  ForgotPassViewController.swift
//  Kyomin
//
//  Created by emizen on 11/23/21.
//

import UIKit

class ForgotPassViewController: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    @IBAction func SendBtnAction(_ sender: Any) {
        
        if(emailTxt.text?.isStringBlank())!{
            self.showCustomPopupView(altMsg:"Please enter email address".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }else if !validEmailId(inputText: emailTxt.text!)  {
            print("Not Valid Emaild")
            self.showCustomPopupView(altMsg:"Please enter valid email address".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }else {
            
            //api
            
            ForgotPassApi()
            
        }
        
    }
    func ForgotPassApi(){
          let dictRegParam = [
               
               "user_email": emailTxt.text ?? ""

           ]  as [String : Any]

        print(dictRegParam)
              
        ApiManager.apiShared.sendRequestServerPostWithHeader1(url: otpsend, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
               
               let stCode = ResponseJson["status_code"].int
               let strMessage = ResponseJson["message"].string
               if stCode == 200{
                
                
                let vc = OtpViewController.instance(.main) as! OtpViewController
                vc.EmailStrSend = emailTxt.text!
                self.navigationController?.pushViewController(vc, animated: true)
//                   let resdata = ResponseJson["data"].dictionary
//                   let Userid = resdata?["id"]?.string
//                   let phoneno=resdata?["phone_no"]?.string
//
//              // obj.prefs.set("1", forKey: APP_IS_LOGIN)
//             let vc = OtpViewController.instance(.main) as! OtpViewController
//               vc.userid=Userid
//               vc.phoneNumber=phoneno ?? ""
//               self.navigationController?.pushViewController(vc, animated: true)
                   
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
    
    
    func validEmailId(inputText: String)-> Bool {
        print("validate emilId: \(inputText)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: inputText)
        return result
    }
}
