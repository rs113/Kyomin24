//
//  EditProfileViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 06/07/21.
//

import UIKit
import SDWebImage
import Localize_Swift
import YPImagePicker

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var backview: CornerBGView!
 
    @IBOutlet weak var btnaddress: UIButton!
    @IBOutlet weak var btnsave: UIButton!
    @IBOutlet weak var lblsomethinghint: UILabel!
    @IBOutlet weak var lbladdresshint: UILabel!
    @IBOutlet weak var lblemailhint: UILabel!
    @IBOutlet weak var lblnamehint: UILabel!
    @IBOutlet weak var lblmobilehint: UILabel!
    @IBOutlet weak var lbliamhint: UILabel!
   
    @IBOutlet weak var txtsomething: UITextView!
    
    @IBOutlet weak var profileimg: UIImageView!
    
    var nameStr = ""
    var EmailStr = ""
    var MobileStr = ""
    var CityStr = ""
    var SomthingStr = ""
    var CountryStr = ""
    var RegionStr = ""
    
    var name=""
    var type=""
    var mobileno=""
    var email=""
    var about=""
    var address=""
    var userimg=""
    var latit:String?
    var longit:String?
    var UpdateImage:UIImage?
    
    var ArrMyProduct:GetProfileModel?
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var MobileTxt: UITextField!
    @IBOutlet weak var CityTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if Localize.currentLanguage() == "en" {
         //   self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
          //  self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        nameTxt.text = nameStr
        EmailTxt.text = EmailStr
        MobileTxt.text = MobileStr
        CityTxt.text = CityStr
        txtsomething.text = SomthingStr
        
     //   Settext()
//        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
//            backview.borderColor = App_main_dark
//            backview.borderWidth = 0
//        }else{
//            backview.borderWidth = 0.5
//            backview.borderColor = Applightcolor
//        }
//        NotificationCenter.default.addObserver(self, selector: #selector(Changebordercolor), name:NSNotification.Name("color"), object: nil)
        
//        txtmobile.textColor = .black
//        txttype.textColor = .black
//        txttype.text=type
//        txtname.text=name
//        txtmobile.text="+964 \(mobileno)"
//        txtemail.text=email
//        txtaddress.text=address
        print(userimg)
        
        txtsomething.text=about
        self.profileimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.profileimg.contentMode = .scaleAspectFill
        self.profileimg.sd_setImage(with: URL(string:userimg), placeholderImage: UIImage(named: ""))
        SocketManager.shared.registerToScoket(observer: self)
    }
    
    
    
    
//
//    func Settext(){
//        Lbleditprofilehint.text="Edit Profile".localized()
//        lbliamhint.text="I am".localized()
//        lblmobilehint.text="Mobile no".localized()
//        lblnamehint.text="Your name".localized()
//        txtname.placeholder="Enter name".localized()
//        lblemailhint.text="Email".localized()
//        txtemail.placeholder="Enter email".localized()
//        lbladdresshint.text="Address".localized()
//        txtaddress.placeholder="Enter address".localized()
//        lblsomethinghint.text="Something about you".localized()
//        btnsave.setTitle("Save".localized(), for: .normal)
//    }
    
    
    func RegisterUseronSocketServer(userimg:String){
           let messageDictionary = [
               "request": "login",
               "userId": obj.prefs.value(forKey: APP_USER_ID) as? String ?? "",
               "type": "loginOrCreate",
               "fcm_token":obj.prefs.value(forKey: APP_FCM_TOKEN) ?? "",
            "userName":nameTxt.text ?? "",
               "firstName":nameTxt.text ?? "",
               "password": "12345678",
               "profile_pic":userimg,
               "lastSeen":Date().currentTimeMillis()
               
           ] as [String : Any]
           
           let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary)
           let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
           if let message:String = jsonString as String?{
               SocketManager.shared.sendMessageToSocket(message: message)
               //            socket.write(string: message) //write some Data over the socket!
           }
       }
    
    
    
    
//    @objc func Changebordercolor(){
//        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
//            backview.borderColor = App_main_dark
//            backview.borderWidth = 0
//        }else{
//            backview.borderWidth = 0.5
//            backview.borderColor = Applightcolor
//        }
//        
//    }
//    
    
    
    @IBAction func chagneBtnClicked(_ sender: Any) {
        
        let vc = ChagnePass_ViewController.instance(.myAccountTab) as! ChagnePass_ViewController
        vc.EmailStrPass = EmailStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    @IBAction func BtnAddress(_ sender: Any) {
        let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
        vc.callBack = { (storeloc: String,lat:Double,long:Double) in
            print(storeloc,lat,long)
           // self.txtaddress.text=storeloc
            self.latit="\(lat)"
            self.longit="\(long)"
        //    UserDefaults.standard.setValue(self.txtaddress.text, forKey: "storelocation")
            UserDefaults.standard.set(self.latit, forKey: "latitude")
            UserDefaults.standard.set(self.longit, forKey: "longitude")
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btncamera(_ sender: Any) {
        //        obj.imagePick(objVC: self)
        //            obj.callback = { img in
        //                self.profileimg.image = img
        //                self.profileimg.contentMode = .scaleAspectFill
        //                self.UpdateImage = img
        //                let selectedimg = self.UpdateImage
        //        }
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.showsPhotoFilters = false
        config.showsCrop = .rectangle(ratio: 1)
        config.shouldSaveNewPicturesToAlbum = false
        
        //        config.wordings.libraryTitle = "Gallery"
        //        config.wordings.cameraTitle = "Camera"
        //        config.wordings.next = "OK"
        
        let picker = YPImagePicker(configuration:config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    
                    self.profileimg.image = photo.image
                    self.profileimg.contentMode = .scaleAspectFill
                    self.UpdateImage = photo.image
                    let selectedimg = self.UpdateImage
                    // self.profileImageUpload(Img: self.UpdateImage)
                    
                })
                
                
                //                self.ImgProduct.image = photo.image
                //                self.ImgProduct.contentMode = .scaleAspectFill
                //                self.ProductImage=photo.image
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnsave(_ sender: Any) {
        //        if (txttype.text?.isStringBlank())!{
        //
        //        self.showCustomPopupView(altMsg:"Please enter type", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        //         self.dismiss(animated: true, completion: nil)
        //        }
        //            return
        //
        if (nameTxt.text?.isStringBlank())! {
            
            self.showCustomPopupView(altMsg:"Please enter name".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
            //        }else if (txtemail.text?.isStringBlank())! {
            //
            //            self.showCustomPopupView(altMsg:"Please enter email", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            //            self.dismiss(animated: true, completion: nil)
            //            }
            //            return
            //        }else if (txtaddress.text?.isStringBlank())! {
            //
            //            self.showCustomPopupView(altMsg:"Please enter address", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            //            self.dismiss(animated: true, completion: nil)
            //            }
            //            return
            //        }else if self.txtsomething.text.isStringBlank() || self.txtsomething.text == ""{
            //        self.showCustomPopupView(altMsg:"Please enter something", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            //                       self.dismiss(animated: true, completion: nil)
            //                       }
            //                       return
            //        }
            //        else if profileimg == nil {
            //
            //    self.showCustomPopupView(altMsg:"Please click profile img", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            //            self.dismiss(animated: true, completion: nil)
            //            }
            //            return
            //        }
            //
        }else{
            profileImageUpload()
        }
        
    }
    
    
    // MARK: - Action
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func profileImageUpload(){
        if Reachability.isConnectedToNetwork() {
            let param = [
                
                "name":nameTxt.text ?? "",
                "email":EmailTxt.text ?? "",
                "phone_no":MobileTxt.text ?? "",
                "city":CityTxt.text ?? "",
                "description":txtsomething.text ?? "",
                "country":CountryStr,
                "regions":RegionStr,

                ]  as [String : Any]
            
            if profileimg.image != nil {
                
                print("s")
            }
            
            ApiManager.apiShared.postImageAPI(image:profileimg.image ?? UIImage(), imageName:"profile_image", VCType: self, isShowLoader:true, parameter: param, url:UpdateProfileURl, { (json) in
                debugPrint(json)
                
                let stCode = json["status_code"].int
                
                let strMessage = json["message"].string
                
                if stCode == 200 {
               let resdata = json["data"].dictionary
                   let imgurl = resdata?["profile_image"]?.string
                    let username=resdata?["name"]?.string
                    obj.prefs.set(username, forKey: APP_USER_NAME)
                    obj.prefs.set(imgurl, forKey: App_User_Img)
                    self.RegisterUseronSocketServer(userimg: imgurl ?? "")
                    DispatchQueue.main.async {
                    self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Success".localized(), alertimg: UIImage(named: "Successimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                    })
                    }
                }
                else{
                    self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                }
                
            })
            { (error) in
                debugPrint(error)
                DispatchQueue.main.async{
                    self.showCustomPopupView(altMsg:"An unexpected error has occurred. Please try again".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                }
            }
        }
        else{
            DispatchQueue.main.async{
                self.showCustomPopupView(altMsg:"Your internet connection seems to be lost.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
                
                
            }
        }
    }
    
    
}

extension EditProfileViewController: SocketObserver {
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





