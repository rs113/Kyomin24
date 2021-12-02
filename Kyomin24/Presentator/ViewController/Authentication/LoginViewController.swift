//
//  LoginViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 08/06/21.
//

import UIKit
import Localize_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnsignup: UIButton!
    @IBOutlet weak var btnskip: UIButton!
    @IBOutlet weak var lbltxtnewuser: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
   // @IBOutlet weak var welcomeMazadiTitleLabel: UILabel!
   // @IBOutlet weak var otpDescriptionLabel: UILabel!
    @IBOutlet weak var continueButton: DesignableButton!
    
    //let loginViewModel = LoginViewModel()
    var fetchLanguage = ""
    var alertStr = ""
    var EmailStr = ""
    var PasswordStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden=true
        tfNumber.delegate=self
        dismissKeyboard()
        Settext()
        
    }
    
    func Settext(){
        
        continueButton.setTitle("Login".localized(), for: .normal)
        lbltxtnewuser.text="Don't have an account?".localized()
        btnsignup.setTitle("Sign Up".localized(), for: .normal)
        btnskip.setTitle("Skip".localized(), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfNumber.text = EmailStr
        passwordTxt.text = PasswordStr
    }
    
    @IBAction func forgotBtnClicked(_ sender: Any) {
        
        let vc = ForgotPassViewController.instance(.main) as! ForgotPassViewController
       // vc.fetchLanguage = fetchLanguage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    //MARK:- Action
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func actionContinue (_ sender: Any) {
        
        
        if(tfNumber.text?.isStringBlank())!{
            self.showCustomPopupView(altMsg:"Please enter email address".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }else if !validEmailId(inputText: tfNumber.text!)  {
            print("Not Valid Emaild")
            self.showCustomPopupView(altMsg:"Please enter valid email address".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        if(passwordTxt.text?.isStringBlank())!{
            self.showCustomPopupView(altMsg:"Please enter password".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        
        else{
            
//            let vc = SelectlanguageViewController.instance(.main) as! SelectlanguageViewController
//            //              vc.userid=Userid
//            //              vc.phoneNumber=phoneno ?? ""
//            self.navigationController?.pushViewController(vc, animated: true)
            
           LoginApiCall()
        }
        
    }
    
    func validEmailId(inputText: String)-> Bool {
        print("validate emilId: \(inputText)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: inputText)
        return result
    }
    
    func dismissKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:self, action:    #selector(LoginViewController.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
  @objc private func dismissKeyboardTouchOutside() {
           view.endEditing(true)
    }

    
    @IBAction func actionSkip(_ sender: Any) {
        // go to tab bar as guest
        let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
        vc.fetchLanguage = fetchLanguage
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    @IBAction func actionSignup(_ sender: Any) {
        // go to tab bar as guest
        let vc = SignupViewController.instance(.main) as! SignupViewController
        vc.fetchLanguage = fetchLanguage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension LoginViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newStr = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)

//        if textField == tfNumber{
//            if newStr.count>10{
//    self.showCustomPopupView(altMsg:"Mobile number should have max 10 digits".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
//               self.dismiss(animated: true, completion: nil)
//              }
//            }
//        }else{
//            do {
//                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
//                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
//                    return false
//                }
//            }
//            catch {
//                print("ERROR")
//            }

       // }
        return true
    }
}




extension LoginViewController{
    func LoginApiCall(){
        let dictRegParam = [
            
            "email":tfNumber.text ?? "",
            "password":passwordTxt.text ?? ""
            
        ]  as [String : Any]
        
        
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: LoginUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                if let resdata = ResponseJson["data"].dictionary{
//                    let Userid = resdata["id"]?.string
//                    let phoneno=resdata["phone_no"]?.string
                    
                    let uData = UserModel2(userDetail: resdata)
                    UserModel.save(schoolModel: uData)
                    
                    
                    print(uData)
                    let TokenStr = resdata["token"]?.string ?? ""
                    let City = resdata["city"]?.string
                    let ProfileId = resdata["id"]?.int ?? 0
                    let Region = resdata["region"]?.string
                    let country = resdata["country"]?.string
                    let username = resdata["name"]?.string
                    let Phone = resdata["phone_no"]?.string
                    let usersubscribe = resdata["is_subscribe"]?.string
                    
                    
                    print(ProfileId)
                    obj.prefs.set(TokenStr, forKey: APP_ACCESS_TOKEN)
                    obj.prefs.set("1", forKey: APP_IS_LOGIN)
                    obj.prefs.set(username, forKey: APP_USER_NAME)
                    obj.prefs.set(country, forKey: App_User_Img)
                    obj.prefs.set(Phone, forKey: App_User_Role)
                    obj.prefs.set(Region, forKey: APP_MOBILE_NUM)
                    obj.prefs.set(ProfileId, forKey: APP_USER_ID)
                    obj.prefs.set(usersubscribe, forKey: App_User_Subscribe)
                    
                    // obj.prefs.set("1", forKey: APP_IS_LOGIN)
                    let vc = BaseTabBarViewController.instance(.main) as! BaseTabBarViewController
                    self.navigationController?.pushViewController(vc, animated: true)
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









////MARK: - CallingFunction
//extension LoginViewController {
//    func selectLanguage(str:String) {
//        self.welcomeMazadiTitleLabel.text = "Hi, Welcome To Mzadi".addLocalizableLanguage(str: str)
//        self.otpDescriptionLabel.text = "A 4 digit OTP will be sent via SMS to login your mobile number!".addLocalizableLanguage(str: str)
//        self.continueButton.setTitle("Continue".addLocalizableLanguage(str: str), for: .normal)
//    }
//}
