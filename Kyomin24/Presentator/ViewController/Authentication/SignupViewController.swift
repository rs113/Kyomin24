//
//  SignupViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 23/07/21.
//

import UIKit
import Localize_Swift

class SignupViewController: UIViewController {
    
   // @IBOutlet weak var btnskip: UIButton!
//    @IBOutlet weak var btnlogin: UIButton!
//    @IBOutlet weak var lblalreadyhave: UILabel!
//    @IBOutlet weak var btncontinue: DesignableButton!
//    @IBOutlet weak var lblselectaccount: UILabel!
//    @IBOutlet weak var lblmobile: UILabel!
//    @IBOutlet weak var lblsignuptext: UILabel!
//    @IBOutlet weak var lblnameweb: UILabel!
   // @IBOutlet weak var btnback: UIButton!
//    @IBOutlet weak var txtmobile: UITextField!
//    @IBOutlet weak var txtname: UITextField!
   // @IBOutlet weak var viewCompanyTheme: UIView!
//    @IBOutlet weak var viewPersonalTheme: UIView!
//    @IBOutlet weak var lblCompanyTheme: UILabel!
//    @IBOutlet weak var lblPersonalTheme: UILabel!
//    @IBOutlet weak var imgCompanyTheme: UIImageView!
//    @IBOutlet weak var imgPersonalTheme: UIImageView!
       
    
    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var MobileTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var ConfirmPassTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    
    var nameSend = ""
    var emailSend = ""
    var mobileSend = ""
    var passwordSend = ""
    var confirmPassSend = ""
    

    var fetchLanguage = ""
    var typeselect=""
    var City = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapGestureOnView()
        
        
        cityTxt.delegate=self
        
        if Localize.currentLanguage() == "ar" {
           // self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }else{
          //  self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }
        
        setlanguage()
        Settext()
        
    }
    
    func Settext(){

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NameTxt.text = nameSend
        emailTxt.text = emailSend
        MobileTxt.text = mobileSend
        PasswordTxt.text = passwordSend
        ConfirmPassTxt.text = confirmPassSend
        
        cityTxt.text = City
    }
    
    func setlanguage(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
          
              
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            imgCompanyTheme.image=UIImage(named: "arbiclight")
//             imgPersonalTheme.image=UIImage(named: "arbiclight")
            
        }else{
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
              
        }
    }
    
    // MARK: - Navigation
    func setTapGestureOnView() {
        let tapDarkTheme = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
     //   viewCompanyTheme.addGestureRecognizer(tapDarkTheme)
        
        let tapLightTheme = UITapGestureRecognizer(target: self, action: #selector(self.handleTapLightTheme(_:)))
      //  viewPersonalTheme.addGestureRecognizer(tapLightTheme)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        //selectedTheme = .dark
        typeselect="shop"
      //  viewCompanyTheme.borderColor = UIColor.red
//        imgCompanyTheme.isHidden = false
//        lblCompanyTheme.textColor = .red
//        viewPersonalTheme.borderColor = UIColor.lightGray
//        imgPersonalTheme.isHidden = true
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
        // lblPersonalTheme.textColor = .white
                } else {
                  
       // lblPersonalTheme.textColor = .black
                      }
        
    }
    
    @objc func handleTapLightTheme(_ sender: UITapGestureRecognizer? = nil) {
        //selectedTheme = .light
        typeselect="user"
    //    viewCompanyTheme.borderColor = UIColor.lightGray
       // imgCompanyTheme.isHidden = true
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
       //  lblCompanyTheme.textColor = .white
                } else {
                  
       // lblCompanyTheme.textColor = .black
                      }
        
//        viewPersonalTheme.borderColor = UIColor.red
//        imgPersonalTheme.isHidden = false
//        lblPersonalTheme.textColor = .red
    }
    
//
//    @IBAction func btnskip(_ sender: Any) {
//     let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
//        vc.fetchLanguage = fetchLanguage
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    //MARK:- action
    @IBAction func actionContinue(_ sender: Any) {
        
     if (NameTxt.text?.isStringBlank())!{
        
        self.showCustomPopupView(altMsg:"Please enter name".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
     self.dismiss(animated: true, completion: nil)
    }
        return
     }else if(emailTxt.text?.isStringBlank())!{
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
    }
     
     else if(MobileTxt.text?.isStringBlank())!{
        self.showCustomPopupView(altMsg:"Please enter mobile number".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        self.dismiss(animated: true, completion: nil)
       }
        return
     }
     else if(PasswordTxt.text?.isStringBlank())!{
        self.showCustomPopupView(altMsg:"Please enter password".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        self.dismiss(animated: true, completion: nil)
       }
        return
     }else if(ConfirmPassTxt.text?.isStringBlank())!{
        self.showCustomPopupView(altMsg:"Please enter confirm password".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        self.dismiss(animated: true, completion: nil)
       }
        return
     }else if PasswordTxt.text != ConfirmPassTxt.text {
        
        self.showCustomPopupView(altMsg:"Password confirmation doesn't match Password".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        self.dismiss(animated: true, completion: nil)
       }
        return
        
     } else if(cityTxt.text?.isStringBlank())!{
        self.showCustomPopupView(altMsg:"Please select city".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        self.dismiss(animated: true, completion: nil)
       }
        return
     }
   
     else{
        
     SignUpApiCall()
    }
        
    }
    

    //MARK:- Action
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func actionLogin(_ sender: Any) {
        let vc = LoginViewController.instance(.main) as! LoginViewController
        vc.fetchLanguage = fetchLanguage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

func validEmailId(inputText: String)-> Bool {
    print("validate emilId: \(inputText)")
    let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: inputText)
    return result
}


extension SignupViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       // let newStr = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)

      
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        if textField == cityTxt{
            
            let vc = CityViewController.instance(.main) as! CityViewController
            vc.namestr = NameTxt.text ?? ""
            vc.emailStr = emailTxt.text ?? ""
            vc.mobileStr = MobileTxt.text ?? ""
            vc.passwordstr = PasswordTxt.text ?? ""
            vc.confirmPassStr = ConfirmPassTxt.text ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return false
    }
}


extension SignupViewController{
    
     func SignUpApiCall(){
        let dictRegParam = [
            
            "name": NameTxt.text ?? "",
            "email": emailTxt.text ?? "",
            "password": PasswordTxt.text ?? "",
            "password_confirmation": ConfirmPassTxt.text ?? "",
            "phone_no": MobileTxt.text ?? "",
            "city": "Jaipur",
            "region": "Rajasthan",
            "country": "India"
        ]  as [String : Any]
        
        
            print(dictRegParam)
               
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: RegisterURl, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
                
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    if let resdata = ResponseJson["data"].dictionary{
//                        let Userid = resdata["id"]?.string
//                        let phoneno=resdata["phone_no"]?.string
//                    
                    
                    let uData = UserModel2(userDetail: resdata)
                    UserModel.save(schoolModel: uData)
                    
                        
                        print(uData)
                            let City = resdata["city"]?.string
                            let Id = resdata["id"]?.string
                            let Region = resdata["region"]?.string
                            let country = resdata["country"]?.string
                            let username = resdata["name"]?.string
                            let Phone = resdata["phone_no"]?.string
                            let usersubscribe = resdata["is_subscribe"]?.string
                    obj.prefs.set(City, forKey: APP_ACCESS_TOKEN)
                    obj.prefs.set("1", forKey: APP_IS_LOGIN)
                    obj.prefs.set(username, forKey: APP_USER_NAME)
                    obj.prefs.set(country, forKey: App_User_Img)
                    obj.prefs.set(Phone, forKey: App_User_Role)
                    obj.prefs.set(Id, forKey: APP_MOBILE_NUM)
                    obj.prefs.set(Region, forKey: APP_USER_ID)
                    obj.prefs.set(usersubscribe, forKey: App_User_Subscribe)
                    
                    
                     self.RegisterUseronSocketServer()
                    
                    
                    let vc = LoginViewController.instance(.main) as! LoginViewController
                    vc.EmailStr = emailTxt.text!
                    vc.PasswordStr = PasswordTxt.text!
                 //   vc.fetchLanguage = fetchLanguage
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
               //            socket.write(string: message) //write some Data over the socket!
           }
       }
    }


    
    
    
    
    
