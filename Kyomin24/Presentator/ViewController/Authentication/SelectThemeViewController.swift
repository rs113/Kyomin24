//
//  SelectThemeViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 09/06/21.
//

import UIKit
import Localize_Swift

class SelectThemeViewController: UIViewController {
    
    
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var continueButton: DesignableButton!
    @IBOutlet weak var selectThemeLabel: UILabel!
    @IBOutlet weak var viewBgBorder: UIView!
    @IBOutlet weak var viewDarkTheme: UIView!
    @IBOutlet weak var viewLightTheme: UIView!
    @IBOutlet weak var lblDarkTheme: UILabel!
    @IBOutlet weak var lblLightTheme: UILabel!
    @IBOutlet weak var imgDarkTheme: UIImageView!
    @IBOutlet weak var imgLightTheme: UIImageView!
    
    var fetchLanguage = ""
    var theme="light"
    var selectedTheme = SelectTheme.dark
    let userDefaults = UserDefaults.standard
    var switchvalue="Off"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        Settext()
        setTapGestureOnView()
        checkInterfaceMod()
        setlanguage()
        
        
        
    }
    
    
    func Settext(){
        selectThemeLabel.text="Select Theme".localized()
        lblLightTheme.text="Light Theme".localized()
        lblDarkTheme.text="Dark Theme".localized()
        continueButton.setTitle("Continue".localized(), for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //setlanguage()
    }
    
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //
    //        let currentlanguage = obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
    //
    //
    //        if currentlanguage == "ar" {
    //            UIView.appearance().semanticContentAttribute = .forceRightToLeft
    //            Localize.setCurrentLanguage(currentlanguage)
    //
    //        }else if currentlanguage == "ku" {
    //            UIView.appearance().semanticContentAttribute = .forceRightToLeft
    //         Localize.setCurrentLanguage(currentlanguage)
    //        }else{
    //
    //           UIView.appearance().semanticContentAttribute = .forceLeftToRight
    //           Localize.setCurrentLanguage(currentlanguage)
    //        }
    //
    //    }
    //
    
    func checkInterfaceMod() {
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
            //                  if #available(iOS 13.0, *) {
            //                      UIApplication.shared.windows.forEach { window in
            //                              window.overrideUserInterfaceStyle = .dark
            //                          }            }
            viewLightTheme.borderColor = UIColor.lightGray
            imgLightTheme.isHidden = true
            lblLightTheme.textColor = .white
            viewDarkTheme.borderColor = UIColor.red
            imgDarkTheme.isHidden = false
            lblDarkTheme.textColor = .red
        } else {
            viewLightTheme.borderColor = UIColor.red
            imgLightTheme.isHidden = false
            lblLightTheme.textColor = .red
            viewDarkTheme.borderColor = UIColor.lightGray
            imgDarkTheme.isHidden = true
            lblDarkTheme.textColor = .black
            //                  if #available(iOS 13.0, *) {
            //                  UIApplication.shared.windows.forEach { window in
            //                          window.overrideUserInterfaceStyle = .light
            //                      }          }
        }
        
        
    }
    
    
    func SetButton(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
            imgDarkTheme.image=UIImage(named: "arbiclight")
            imgLightTheme.image=UIImage(named: "arbiclight")
            continueButton.imageEdgeInsets=UIEdgeInsets(top: 0, left:-40, bottom: 0, right:80)
            continueButton.titleEdgeInsets=UIEdgeInsets(top: 0, left:0, bottom: 0, right:-40)
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku"{
            imgDarkTheme.image=UIImage(named: "arbiclight")
            imgLightTheme.image=UIImage(named: "arbiclight")
            continueButton.imageEdgeInsets=UIEdgeInsets(top: 0, left:-100, bottom: 0, right:80)
            continueButton.titleEdgeInsets=UIEdgeInsets(top: 0, left:0, bottom: 0, right:-40)
        }else{
            continueButton.imageEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -190)
            continueButton.titleEdgeInsets=UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
            
        }
        
        //         if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
        //            continueButton.imageEdgeInsets=UIEdgeInsets(top: 0, left:-40, bottom: 0, right:80)
        //            continueButton.titleEdgeInsets=UIEdgeInsets(top: 0, left:0, bottom: 0, right:-40)
        //            imgDarkTheme.image=UIImage(named: "arbiclight")
        //            imgLightTheme.image=UIImage(named: "arbiclight")
        //         }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
        //
        //        }else{
        //
        //        }
        
    }
    //
    func setlanguage(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
            //UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            SetButton()
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
           // UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
            SetButton()
        }else{
            // UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            SetButton()
        }
    }
    
    
    
    
    
    // MARK: - Navigation
    func setTapGestureOnView() {
        let tapLightTheme = UITapGestureRecognizer(target: self, action: #selector(self.handleTapLightTheme(_:)))
        viewLightTheme.addGestureRecognizer(tapLightTheme)
        
        let tapDarkTheme = UITapGestureRecognizer(target: self, action: #selector(self.handleTapDarkTheme(_:)))
        viewDarkTheme.addGestureRecognizer(tapDarkTheme)
    }
    
    //MARK:- action
    @IBAction func actionContinue(_ sender: Any) {
        print(switchvalue)
        obj.prefs.set(switchvalue, forKey: SwitchValue)
        let vc = LoginViewController.instance(.main) as! LoginViewController
        vc.fetchLanguage = fetchLanguage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Action
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapLightTheme(_ sender: UITapGestureRecognizer? = nil) {
        // selectedTheme = .dark
        //overrideUserInterfaceStyle = .light
        // obj.prefs.set(theme, forKey: App_CURRENT_THEME)
        
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        switchvalue="Off"
        Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
        viewLightTheme.borderColor = UIColor.red
        imgLightTheme.isHidden = false
        lblLightTheme.textColor = .red
        viewDarkTheme.borderColor = UIColor.lightGray
        imgDarkTheme.isHidden = true
        lblDarkTheme.textColor = .black
        
        
    }
    
    @objc func handleTapDarkTheme(_ sender: UITapGestureRecognizer? = nil) {
        //selectedTheme = .light
        // overrideUserInterfaceStyle = .dark
        //  theme = "dark"
        //  obj.prefs.set(theme, forKey: App_CURRENT_THEME)
        
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
        switchvalue="On"
        Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
        viewLightTheme.borderColor = UIColor.lightGray
        imgLightTheme.isHidden = true
        lblLightTheme.textColor = .white
        viewDarkTheme.borderColor = UIColor.red
        imgDarkTheme.isHidden = false
        lblDarkTheme.textColor = .red
    }
    
    func SetTheme(){
        if self.overrideUserInterfaceStyle == .unspecified {
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
                self.overrideUserInterfaceStyle = .light
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
                Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
            } else {
                self.overrideUserInterfaceStyle = .dark
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
                Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
                
            }
            
        } else  if self.overrideUserInterfaceStyle == .light {
            
            self.overrideUserInterfaceStyle = .dark
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            
            Defaults.saveBool(true, key: ConstantApp.IS_DARK_MODE_UNABLE)
            
        } else  if self.overrideUserInterfaceStyle == .dark {
            
            self.overrideUserInterfaceStyle = .light
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
            
            Defaults.saveBool(false, key: ConstantApp.IS_DARK_MODE_UNABLE)
            
        }
        
    }
    
}


enum SelectTheme: String {
    case dark = "dark"
    case light = "light"
}



////MARK: - CallingFunction
//extension SelectThemeViewController {
//   // "Select Theme"="Select Theme";
//    func selectLanguage(str:String) {
//        self.lblDarkTheme.text = "Dark Theme".addLocalizableLanguage(str: str)
//        self.lblLightTheme.text = "Light Theme".addLocalizableLanguage(str: str)
//        self.selectThemeLabel.text = "Select Theme".addLocalizableLanguage(str: str)
//        self.continueButton.setTitle("Continue".addLocalizableLanguage(str: str), for: .normal)
//    }
//}
