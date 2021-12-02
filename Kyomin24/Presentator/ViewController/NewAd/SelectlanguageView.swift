//
//  SelectlanguageView.swift
//  Mzadi
//
//  Created by Emizentech on 19/08/21.
//

import UIKit
import Localize_Swift

class SelectlanguageView: BaseMoreMenuViewController {
    
    @IBOutlet weak var btncontinue: DesignableButton!
    @IBOutlet weak var lblchoosehint: UILabel!
    @IBOutlet weak var lblselectlanguagehint: UILabel!
    @IBOutlet weak var lblselectthreehint: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imgleftarbic: UIImageView!
    @IBOutlet weak var viewArebic: UIView!
    @IBOutlet weak var viewKurdish: UIView!
    @IBOutlet weak var viewEnglish: UIView!
    @IBOutlet weak var lblArebic: UILabel!
    @IBOutlet weak var lblKurdish: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var imgArebic: UIImageView!
    @IBOutlet weak var imgKurdish: UIImageView!
    @IBOutlet weak var imgEnglish: UIImageView!
    
    //var selectedLanguage = SelectLanguage.english
    var strlanguage=""
    var arbictrue=false
    var vctype=""
    var prenav:UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden=true
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
            
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        //Settext()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setlanguage()
        Settext()
        
    }
    
    
    func Settext(){
        lblselectlanguagehint.text="Select Language".localized()
        lblselectthreehint.text="Please Select in Three Languages".localized()
        lblchoosehint.text="You can choose multiple Language".localized()
        btncontinue.setTitle("Continue".localized(), for:.normal)
        
    }
    
    
    
    
    
    func setTapGestureOnView() {
        let tapArebic = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewArebic.addGestureRecognizer(tapArebic)
        
        let tapKurdish = UITapGestureRecognizer(target: self, action: #selector(self.handleTapKurdish(_:)))
        viewKurdish.addGestureRecognizer(tapKurdish)
        
        let tapEnglish = UITapGestureRecognizer(target: self, action: #selector(self.handleTapEnglish(_:)))
        viewEnglish.addGestureRecognizer(tapEnglish)
    }
    
    
    
    
    
    
    func setlanguage(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                lblArebic.textColor = .white
                lblEnglish.textColor = .white
            }else{
                lblArebic.textColor = .black
                lblEnglish.textColor = .black
            }
            
            viewArebic.borderColor = UIColor.lightGray
            imgArebic.isHidden = true
            
            
            viewKurdish.borderColor = UIColor.red
            imgKurdish.isHidden = false
            imgKurdish.image=UIImage(named: "arbiclight")
            lblKurdish.textColor = .red
            
            viewEnglish.borderColor = UIColor.lightGray
            imgEnglish.isHidden = true
            imgleftarbic.isHidden=true
            
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            //  selectedLanguage = .arebic
            arbictrue=true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                lblKurdish.textColor = .white
                lblEnglish.textColor = .white
            }else{
                lblKurdish.textColor = .black
                lblEnglish.textColor = .black
            }
            viewArebic.borderColor = UIColor.red
            imgArebic.isHidden = false
            imgArebic.image=UIImage(named: "arbiclight")
            //imgleftarbic.isHidden=false
            lblArebic.textColor = .red
            
            
            viewKurdish.borderColor = UIColor.lightGray
            imgKurdish.isHidden = true
            
            
            viewEnglish.borderColor = UIColor.lightGray
            imgEnglish.isHidden = true
            
            
            
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                lblArebic.textColor = .white
                lblKurdish.textColor = .white
            }else{
                lblArebic.textColor = .black
                lblKurdish.textColor = .black
            }
            viewArebic.borderColor = UIColor.lightGray
            imgArebic.isHidden = true
            
            
            viewKurdish.borderColor = UIColor.lightGray
            imgKurdish.isHidden = true
            
            
            viewEnglish.borderColor = UIColor.red
            imgEnglish.isHidden = false
            lblEnglish.textColor = .red
            
            imgleftarbic.isHidden=true
            
        }
    }
    
    
    func SetRootVc(){
        let vc = SelectlanguageView.instance(.newAdTab) as! SelectlanguageView
        let NavVC = UINavigationController(rootViewController: vc)
        NavVC.isNavigationBarHidden = true
        UIApplication.shared.windows[0].rootViewController = NavVC
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    @IBAction func BtnArbic(_ sender: Any) {
        print("arebic")
        
        Localize.setCurrentLanguage("ar")
        print(Localize.currentLanguage())
        // for arabic set right to left at runtime
        obj.prefs.set("ar", forKey: APP_CURRENT_LANG)
        
        DispatchQueue.main.async {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblEnglish.textColor = .white
            lblKurdish.textColor = .white
        }else{
            lblKurdish.textColor = .black
            lblEnglish.textColor = .black
        }
        
        // selectedLanguage = .arebic
        viewArebic.borderColor = UIColor.red
        imgArebic.isHidden = false
        
        lblArebic.textColor = .red
        
        viewKurdish.borderColor = UIColor.lightGray
        imgKurdish.isHidden = true
        
        
        viewEnglish.borderColor = UIColor.lightGray
        imgEnglish.isHidden = true
        SetRootVc()
    }
    
    @IBAction func btnkudish(_ sender: Any) {
        print("kurdish")
        Localize.setCurrentLanguage("ku")
        
        obj.prefs.set("ku", forKey: APP_CURRENT_LANG)
        
        // for english set left to right at runtime
        DispatchQueue.main.async {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        //selectedLanguage = .kurdish
        
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblEnglish.textColor = .white
            lblArebic.textColor = .white
        }else{
            lblArebic.textColor = .black
            lblEnglish.textColor = .black
        }
        
        viewArebic.borderColor = UIColor.lightGray
        imgArebic.isHidden = true
        //        lblArebic.textColor = .black
        
        viewKurdish.borderColor = UIColor.red
        
        if arbictrue == true {
            imgKurdish.isHidden = false
            imgKurdish.image=UIImage(named: "arbiclight")
        }else{
            imgKurdish.isHidden = false
        }
        
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "en"{
            imgKurdish.image=UIImage(named: "Group 726")
        }else{
            imgKurdish.image=UIImage(named: "arbiclight")
        }
        
        
        lblKurdish.textColor = .red
        
        viewEnglish.borderColor = UIColor.lightGray
        imgEnglish.isHidden = true
        
        SetRootVc()
    }
    
    @IBAction func btnenglish(_ sender: Any) {
        print("english")
        // selectedLanguage = .english
        
        Localize.setCurrentLanguage("en")
        // for english set left to right at runtime
        
        DispatchQueue.main.async {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        obj.prefs.set("en", forKey: APP_CURRENT_LANG)
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblArebic.textColor = .white
            lblKurdish.textColor = .white
        }else{
            lblArebic.textColor = .black
            lblArebic.textColor = .black
        }
        viewArebic.borderColor = UIColor.lightGray
        imgArebic.isHidden = true
        // lblArebic.textColor = .black
        
        viewKurdish.borderColor = UIColor.lightGray
        imgKurdish.isHidden = true
        // lblKurdish.textColor = .black
        
        viewEnglish.borderColor = UIColor.red
        
        
        if arbictrue == true {
            imgEnglish.isHidden = false
            imgEnglish.image=UIImage(named: "arbiclight")
        }else{
            imgEnglish.isHidden = false
        }
        
        
        
        lblEnglish.textColor = .red
        
        SetRootVc()
    }
    //MARK:- tap action
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("arebic")
        
        
        
        Localize.setCurrentLanguage("ar")
        print(Localize.currentLanguage())
        // for arabic set right to left at runtime
        obj.prefs.set("ar", forKey: APP_CURRENT_LANG)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblEnglish.textColor = .white
            lblKurdish.textColor = .white
        }else{
            lblKurdish.textColor = .black
            lblEnglish.textColor = .black
        }
        
        // selectedLanguage = .arebic
        viewArebic.borderColor = UIColor.red
        imgArebic.isHidden = false
        
        lblArebic.textColor = .red
        
        viewKurdish.borderColor = UIColor.lightGray
        imgKurdish.isHidden = true
        
        
        viewEnglish.borderColor = UIColor.lightGray
        imgEnglish.isHidden = true
        
        // SetButton()
    }
    
    @objc func handleTapKurdish(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("kurdish")
        Localize.setCurrentLanguage("ku")
        // for english set left to right at runtime
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        obj.prefs.set("ku", forKey: APP_CURRENT_LANG)
        //selectedLanguage = .kurdish
        
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblEnglish.textColor = .white
            lblArebic.textColor = .white
        }else{
            lblArebic.textColor = .black
            lblEnglish.textColor = .black
        }
        viewArebic.borderColor = UIColor.lightGray
        imgArebic.isHidden = true
       
        
        viewKurdish.borderColor = UIColor.red
        
        
        
        lblKurdish.textColor = .red
        
        viewEnglish.borderColor = UIColor.lightGray
        imgEnglish.isHidden = true
        //        lblEnglish.textColor = .black
        // SetButton()
    }
    
    @objc func handleTapEnglish(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("english")
        // selectedLanguage = .english
        
        Localize.setCurrentLanguage("en")
        // for english set left to right at runtime
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        obj.prefs.set("en", forKey: APP_CURRENT_LANG)
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblArebic.textColor = .white
            lblKurdish.textColor = .white
        }else{
            lblArebic.textColor = .black
            lblArebic.textColor = .black
        }
        viewArebic.borderColor = UIColor.lightGray
        imgArebic.isHidden = true
        // lblArebic.textColor = .black
        
        viewKurdish.borderColor = UIColor.lightGray
        imgKurdish.isHidden = true
        // lblKurdish.textColor = .black
        
        viewEnglish.borderColor = UIColor.red
        
        
        if arbictrue == true {
            imgEnglish.isHidden = false
            imgEnglish.image=UIImage(named: "arbiclight")
        }else{
            imgEnglish.isHidden = false
        }
        
        
        
        lblEnglish.textColor = .red
        // SetButton()
    }
    
    @IBAction func btnback(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
        
        self.PopToSpecificController(vcMove: BaseTabBarViewController.self)
        
    }
    //MARK:- action
    @IBAction func actionContinue(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("Basetab"), object: nil, userInfo: nil)
        var navArr = self.navigationController!.viewControllers as Array
        var isfind = false
        for vc in navArr{
            
            navArr.remove(at: navArr.count-1)
        }
        
        let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
        let NavVC = UINavigationController(rootViewController: vc)
        NavVC.isNavigationBarHidden = true
        UIApplication.shared.windows[0].rootViewController = NavVC
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
}


//extension String {
//    func AddLocalizableLanguage(str:String) -> String {
//        let path = Bundle.main.path(forResource: str, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        return NSLocalizedString(self, tableName: "", bundle: bundle!, value: "", comment: "")
//    }
//}
