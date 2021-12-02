//
//  SelectlanguageViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 07/06/21.
//

import UIKit
import Localize_Swift
import Alamofire
import SwiftyJSON

class SelectlanguageViewController: UIViewController {
    
    @IBOutlet weak var selectlanglbl: UILabel!
    //@IBOutlet weak var // imgleftarbic: UIImageView!
    
  //  @IBOutlet weak var // btncontinue: UIButton!
    @IBOutlet weak var viewBgBorder: UIView!
    @IBOutlet weak var viewArebic: UIView!
    @IBOutlet weak var ViewKorian: UIView!
    @IBOutlet weak var viewEnglish: UIView!
  //  @IBOutlet weak var // lblArebic: UILabel!
    @IBOutlet weak var LblKoarean: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    //  @IBOutlet weak var // imgArebic: UIImageView!
    @IBOutlet weak var ImgKorean: UIImageView!
    @IBOutlet weak var imgEnglish: UIImageView!
    
    var selectedLanguage = SelectLanguage.english
    var strlanguage=false
    var arbictrue=false
    var setview=false
    
    @IBOutlet weak var EngImg: UIImageView!
    @IBOutlet weak var EngRight: UIImageView!
    
    @IBOutlet weak var koreanImg: UIImageView!
    @IBOutlet weak var koreanRight: UIImageView!
    
    @IBOutlet weak var RadioEng: UIImageView!
    @IBOutlet weak var RadioKorean: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
        // Do any additional setup after loading the view.
        // viewBgBorder.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 30, borderColor: UIColor.lightGray, borderWidth: 1.0)
        setTapGestureOnView()

        //  selectedLanguage = .english
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setlanguage()
        Settext()
        
    }
    
    func Settext(){
        
        selectlanglbl.text="Select Language".localized()
        // btncontinue.setTitle("Login".localized(), for: .normal)
        
        
    }
    
    func SetButton(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar" {
            // btncontinue.imageEdgeInsets=UIEdgeInsets(top: 0, left:-40, bottom: 0, right:80)
            // btncontinue.titleEdgeInsets=UIEdgeInsets(top: 0, left:0, bottom: 0, right:-40)
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
            // btncontinue.imageEdgeInsets=UIEdgeInsets(top: 0, left:-90, bottom: 0, right:80)
            // btncontinue.titleEdgeInsets=UIEdgeInsets(top: 0, left:0, bottom: 0, right:-40)
        }else{
            // btncontinue.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -190)
            // btncontinue.titleEdgeInsets=UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
            
        }
        
    }
    
    // for instant change of ui and text according to language
    func SetRootVc(){
        let vc = SelectlanguageViewController.instance(.main) as! SelectlanguageViewController
        let NavVC = UINavigationController(rootViewController: vc)
        NavVC.isNavigationBarHidden = true
        UIApplication.shared.windows[0].rootViewController = NavVC
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    func setTapGestureOnView() {
        //        let tapArebic = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        //        viewArebic.addGestureRecognizer(tapArebic)
        
        let tapKurdish = UITapGestureRecognizer(target: self, action: #selector(self.handleTapKurdish(_:)))
        ViewKorian.addGestureRecognizer(tapKurdish)
        
        let tapEnglish = UITapGestureRecognizer(target: self, action: #selector(self.handleTapEnglish(_:)))
        viewEnglish.addGestureRecognizer(tapEnglish)
    }
    
    func setlanguage(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
            strlanguage=true
           // UIView.appearance().semanticContentAttribute = .forceRightToLeft
            selectedLanguage = .arebic
            arbictrue=true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                //    // lblArebic.textColor = .white
                //    lblEnglish.textColor = .white
            }else{
                //   // lblArebic.textColor = .black
                lblEnglish.textColor = .black
            }
            
            // viewArebic.borderColor = UIColor.lightGray
            // imgArebic.isHidden = true
            
            
            ViewKorian.borderColor = UIColor.orange
           // ImgKorean.isHidden = false
            ImgKorean.image=UIImage(named: "Rectangle 287")
            LblKoarean.textColor = .orange
            RadioEng.image = #imageLiteral(resourceName: "CiityRadio")
            RadioKorean.image = #imageLiteral(resourceName: "RadioLan")
            
            viewEnglish.borderColor = UIColor.lightGray
            imgEnglish.isHidden = true
         //   imgEnglish.image=UIImage(named: "Rectangle 287")

            // imgleftarbic.isHidden=true
            SetButton()
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
            strlanguage=true
           // UIView.appearance().semanticContentAttribute = .forceRightToLeft
            selectedLanguage = .arebic
            arbictrue=true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                LblKoarean.textColor = .white
                lblEnglish.textColor = .white
            }else{
                LblKoarean.textColor = .black
                lblEnglish.textColor = .black
            }
            
            ViewKorian.borderColor = UIColor.lightGray
            ImgKorean.isHidden = true
            
            
            viewEnglish.borderColor = UIColor.lightGray
            imgEnglish.isHidden = true
            
            SetButton()
        }else{
            strlanguage=true
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                //    // lblArebic.textColor = .white
                LblKoarean.textColor = .white
            }else{
                // // lblArebic.textColor = .black
                LblKoarean.textColor = .black
            }
            //  viewArebic.borderColor = UIColor.lightGray
            // // // imgArebic.isHidden = true
            
            
            ViewKorian.borderColor = UIColor.lightGray
            ImgKorean.isHidden = true
            
            
            viewEnglish.borderColor = UIColor.orange
            imgEnglish.isHidden = false
            lblEnglish.textColor = .orange
            RadioKorean.image = #imageLiteral(resourceName: "CiityRadio")
            RadioEng.image = #imageLiteral(resourceName: "RadioLan")
            // imgleftarbic.isHidden=true
            SetButton()
        }
    }
    
    //MARK:- tap action
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("arebic")
        strlanguage=true
        Localize.setCurrentLanguage("ar")
        print(Localize.currentLanguage())
        // for arabic set right to left at runtime
        obj.prefs.set("ar", forKey: APP_CURRENT_LANG)
        
        
      //  UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblEnglish.textColor = .white
            LblKoarean.textColor = .white
        }else{
            LblKoarean.textColor = .black
            lblEnglish.textColor = .black
        }
        
        // selectedLanguage = .arebic
        //  viewArebic.borderColor = UIColor.red
        // imgArebic.isHidden = false
        
        // // lblArebic.textColor = .red
        
        ViewKorian.borderColor = UIColor.lightGray
        ImgKorean.isHidden = true
      

        
        viewEnglish.borderColor = UIColor.lightGray
        imgEnglish.isHidden = true
        
        SetRootVc()
    }
    
    @objc func handleTapKurdish(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("kurdish")
        strlanguage=true
        Localize.setCurrentLanguage("ku")
        
        // for english set left to right at runtime
       // UIView.appearance().semanticContentAttribute = .forceRightToLeft
        obj.prefs.set("ku", forKey: APP_CURRENT_LANG)
        //selectedLanguage = .kurdish
        
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblEnglish.textColor = .white
            //    // lblArebic.textColor = .white
        }else{
            //  // lblArebic.textColor = .black
            lblEnglish.textColor = .black
        }
        //    viewArebic.borderColor = UIColor.lightGray
        // imgArebic.isHidden = true
        //        // lblArebic.textColor = .black
        
        ViewKorian.borderColor = UIColor.orange
        
        if arbictrue == true {
            ImgKorean.isHidden = false
            ImgKorean.image=UIImage(named: "arbiclight")
        }else{
            ImgKorean.isHidden = false
        }
        
        
        LblKoarean.textColor = .orange
        
        viewEnglish.borderColor = UIColor.lightGray
        imgEnglish.isHidden = true
        
        
        SetRootVc()
    }
    
    @objc func handleTapEnglish(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("english")
        // selectedLanguage = .english
        strlanguage=true
        Localize.setCurrentLanguage("en")
        // for english set left to right at runtime
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        obj.prefs.set("en", forKey: APP_CURRENT_LANG)
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            //  // lblArebic.textColor = .white
            LblKoarean.textColor = .white
        }else{
            // lblArebic.textColor = .black
            LblKoarean.textColor = .black
        }
        //   viewArebic.borderColor = UIColor.lightGray
        // imgArebic.isHidden = true
        // // lblArebic.textColor = .black
        
        ViewKorian.borderColor = UIColor.lightGray
        ImgKorean.isHidden = true
        // LblKoarean.textColor = .black
        
        viewEnglish.borderColor = UIColor.orange
        
        
        if arbictrue == true {
            imgEnglish.isHidden = false
            imgEnglish.image=UIImage(named: "arbiclight")
        }else{
            imgEnglish.isHidden = false
        }
        RadioEng.image = #imageLiteral(resourceName: "RadioLan")
        lblEnglish.textColor = .orange
        
        SetRootVc()
        
    }
    
    //MARK:- action
    @IBAction func actionContinue(_ sender: Any) {
        
        if strlanguage == false{
            Localize.setCurrentLanguage("en")
            // for english set left to right at runtime
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            obj.prefs.set("en", forKey: APP_CURRENT_LANG)
        }
        
        let vc = LoginViewController.instance(.main) as! LoginViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


enum SelectLanguage: String {
    case arebic = "ar"
    case kurdish = "ku"
    case english = "en"
    case none = "none"
}

extension String {
    func addLocalizableLanguage(str:String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "", bundle: bundle!, value: "", comment: "")
    }
}
