//
//  OtpViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 08/06/21.
//

import UIKit
import SROTPView
import MKRingProgressView
import Localize_Swift

class OtpViewController: UIViewController {
    
    @IBOutlet weak var btnback: UIButton!
    
    @IBOutlet weak var viewProgress: UIView!
 //   @IBOutlet weak var welcomeMazadiTitleLabel: UILabel!
    
    @IBOutlet weak var doneButton: DesignableButton!
    
    @IBOutlet weak var lbldontreceiveotp: UILabel!
    @IBOutlet weak var lblsendcodelbl: UILabel!
    @IBOutlet weak var counterBtn: UILabel!
    @IBOutlet weak var resendBtn:UIButton!
    @IBOutlet weak var pinCodeView:SROTPView!
    @IBOutlet weak var lblInfos:UILabel!
    
    var fetchLanguage = ""
    var timeLeft = 59
    var otpTimer =  Timer()
    var phoneNumber=""
    var userid:String?
    var otppin:String?
    var otpstatic:Int?
    var firebasetoken=""
    var EmailStrSend = ""
    let ringProgressView = RingProgressView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        otpPinView.delegate = self
        //        self.selectLanguage(str: fetchLanguage)
        if Localize.currentLanguage() == "ar" {
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }
        
        resendBtn.isEnabled = false
        resendBtn.setTitleColor(.lightGray, for: .normal)
        
   
            
        lblInfos.text = EmailStrSend
        
     //   OtpResendApiCall()

        pinCodeView.otpTextFieldsCount  = 4
        pinCodeView.otpTextFieldFontColor = .black
        pinCodeView.size = (self.view.frame.width-90)/4
        pinCodeView.space = 10
        
        pinCodeView.otpTextFieldActiveBorderColor = UIColor.lightGray
        pinCodeView.otpTextFieldDefaultBorderColor = UIColor.lightGray
        
        pinCodeView.activeHeight = 1
        pinCodeView.inactiveHeight = 1
        pinCodeView.otpType = .UnderLined
        pinCodeView.textBackgroundColor = #colorLiteral(red: 0.9999504685, green: 0.9309937358, blue: 0.8583891392, alpha: 1)
        

        
//        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
//            pinCodeView.otpTextFieldActiveBorderColor = UIColor.clear
//            pinCodeView.otpTextFieldDefaultBorderColor = UIColor.clear
//            pinCodeView.textBackgroundColor = UIColor(red: 53/255, green: 71/255, blue: 42/255, alpha: 1)
//            pinCodeView.otpTextFieldFontColor = .white
//        } else {
//            pinCodeView.otpTextFieldActiveBorderColor = UIColor.lightGray
//            pinCodeView.otpTextFieldDefaultBorderColor = UIColor.lightGray
//            pinCodeView.textBackgroundColor = .white
//            pinCodeView.otpTextFieldFontColor = .black
//        }
//
        
       
        
//        if Localize.currentLanguage() == "ar" {
//            pinCodeView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            
//        }else{
//            pinCodeView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
//        
//        
//        
//        
        
    
        pinCodeView.becomeFirstResponder()

        pinCodeView.tintColor = .black
        
        pinCodeView.otpEnteredString = { pin in
            print("The entered pin is \(pin)")
            
            if pin.count == 4 {
                self.otppin=pin
            }
            
        }
        
        
        timerSetups()
        
        pinCodeView.setUpOtpView()
        
        settext()

        SocketManager.shared.registerToScoket(observer: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    
    func settext(){
     //   welcomeMazadiTitleLabel.text="Enter Code Sent To Your Phone".localized()
        lblsendcodelbl.text="Please Enter the 4 Digit Code Sent to".localized()
        doneButton.setTitle("Submit".localized(), for: .normal)
        lbldontreceiveotp.text="Didn’t get an OTP".localized()
        resendBtn.setTitle("Resend".localized(), for: .normal)
    }
    
    
    
    
    func timerSetups(){
        otpTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timera in
            print("timer fired!")
            
            self.timeLeft = self.timeLeft-1
            // let seconds: Int = self.timeLeft % 60
            let seconds: Int = 0
            // let minutes: Int = (self.timeLeft / 60) % 60
            let minutes: Int = self.timeLeft
            let time = String(format: "%02d:%02d", seconds, minutes)
            self.counterBtn.text=time
            //self.counterBtn.setTitle(time, for: .normal)
            if(self.timeLeft==0){
                self.otpTimer.invalidate()
                self.counterBtn.isHidden = true
                self.viewProgress.isHidden = true
                self.resendBtn.isEnabled = true
                self.resendBtn.setTitleColor(App_main_clor, for: .normal)
            }
            // self.timeLeft -= 1
            UIView.animate(withDuration: 1.2) {
                //                           print(Double((50-self.timeLeft)/100))
                //                var sub = Float(30-self.timeLeft)*3.30
                //                           var flR:Float = sub/100
                //                           print("FIR:\(flR)")
                print(Double((50-self.timeLeft)/100))
                var sub = Float(60-self.timeLeft)*1.65
                var flR:Float = sub/100
                print("FIR:\(flR)")
                
                self.ringProgressView.progress = Double(flR)
            }
            
        })
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        pinCodeView.initializeUI()
        
    }
    
    
    
    
    
    func setupProgressBar(){
        
        ringProgressView.startColor = .red
        ringProgressView.endColor = .clear
        ringProgressView.style = .round
        ringProgressView.shadowOpacity = 0.0
        ringProgressView.gradientImageScale = 0.0
        ringProgressView.ringWidth = 3
        ringProgressView.progress = 0.0
        viewProgress.addSubview(ringProgressView)
    }
    
    
    
    //MARK:- Action
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionDone(_ sender: Any) {
        
        if otppin?.count ?? 0 < 4{
            self.showCustomPopupView(altMsg: "Please Enter OTP".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
                
            }
        }else{
            EmailOtpVerifyApiCall()
        }
        
    }
    
    @IBAction func btnresend(_ sender: Any) {
        
        OtpResendApiCall()
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


extension OtpViewController {
    func EmailOtpVerifyApiCall(){
        self.firebasetoken=UserDefaults.standard.string(forKey:"fcmToken") ?? ""
        print("firebasetoken:\(self.firebasetoken)")
        let dictRegParam = [
            
            "email":EmailStrSend ,
            "otp":otppin ?? "",
            
            ] as [String : Any]
        print(dictRegParam)
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: OtpVerifyUrl, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.otpTimer.invalidate()
                if let resdata = ResponseJson["data"].dictionary{
                    let uData = UserModel2(userDetail: resdata)
                    UserModel.save(schoolModel: uData)
                    
                    
                    //                    print(uData)
                    //                        let uToken = resdata["token"]?.string
                    //                        let usermob = resdata["phone_no"]?.string
                    //                        let userid = resdata["id"]?.string
                    //                        let userimg = resdata["profile_pic"]?.string
                    //                        let username = resdata["name"]?.string
                    //                        let roleuser = resdata["role"]?.string
                    //                        let usersubscribe = resdata["is_subscribe"]?.string
                    //                obj.prefs.set(uToken, forKey: APP_ACCESS_TOKEN)
                    //                obj.prefs.set("1", forKey: APP_IS_LOGIN)
                    //                obj.prefs.set(username, forKey: APP_USER_NAME)
                    //                obj.prefs.set(userimg, forKey: App_User_Img)
                    //                obj.prefs.set(roleuser, forKey: App_User_Role)
                    //                obj.prefs.set(usermob, forKey: APP_MOBILE_NUM)
                    //                obj.prefs.set(userid, forKey: APP_USER_ID)
                    //                obj.prefs.set(usersubscribe, forKey: App_User_Subscribe)
                    
                    
                    self.RegisterUseronSocketServer()
                    let vc = CreatePass_ViewController.instance(.main) as! CreatePass_ViewController
                    vc.EmailStr = EmailStrSend
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                    self.pinCodeView.setUpOtpView()
                    self.otppin = ""
                })
            }
            
            
            
        }) { (Strerr,stCode) in
            
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
                self.pinCodeView.setUpOtpView()
                self.otppin = ""
            })
        }
        
        
    }
    
    
    func OtpResendApiCall() {
        let dictRegParam = [
             
             "user_email": EmailStrSend

         ]  as [String : Any]

      print(dictRegParam)
            
      ApiManager.apiShared.sendRequestServerPostWithHeader(url: otpsend, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
             
             let stCode = ResponseJson["status_code"].int
             let strMessage = ResponseJson["message"].string
        if stCode == 200{
            
            
            
            self.counterBtn.isHidden = false
            self.viewProgress.isHidden=false
            self.otpTimer.invalidate()
            //        self.otpTimer = nil
            self.timeLeft = 59
            self.resendBtn.isEnabled = false
            self.resendBtn.setTitleColor(.lightGray, for: .normal)
            self.timerSetups()
            self.setupProgressBar()
            
            self.pinCodeView.setUpOtpView()
            self.otppin = ""
           
            
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


extension OtpViewController: SocketObserver {
    func registerFor() -> [ResponseType] {
        return [.loginOrCreate]
    }

    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        print("observer ",{observerWithIdentifire})
        guard let data = data["data"] as? [String : Any] else {
            return
        }

      //  LoginUserModel.shared.login(userData: data)
       // print("UsersListForLoginViewController:: \(LoginUserModel.shared.userId)")

//        let vc = RoomListViewController()
//
//        self.navigationController?.show(vc, sender: nil)
    }


    func socketConnection(status: SocketConectionStatus) {
        print(status)
        if status == .connected{
           // RegisterUseronSocketServer()
        }
    }
}


extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}




////MARK: - CallingFunction
//extension OtpViewController {
//    func selectLanguage(str:String) {
//        self.welcomeMazadiTitleLabel.text = "Enter Code Sent To Your Phone".addLocalizableLanguage(str: str)
//        self.otpDescriptionLabel.text = "We will sent to the number 4 digit otp to this no. +964 (265) XX XX 259".addLocalizableLanguage(str: str)
//        self.doneButton.setTitle("Done".addLocalizableLanguage(str: str), for: .normal)
//
//    }
//}


