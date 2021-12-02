//
//  ChooseLanguageViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//

import UIKit
import Localize_Swift

class ChooseLanguageViewController: BaseMoreMenuViewController {
    
    @IBOutlet weak var imgengleft: UIImageView!
    @IBOutlet weak var imgkurdishleft: UIImageView!
    @IBOutlet weak var imgarabicleft: UIImageView!
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var lblchoosehint: UILabel!
    @IBOutlet weak var lblselectlanguagehint: UILabel!
    @IBOutlet weak var lblselectthreehint: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var viewBgBorder: UIView!
    @IBOutlet weak var viewArebic: UIView!
    @IBOutlet weak var viewKurdish: UIView!
    @IBOutlet weak var viewEnglish: UIView!
    @IBOutlet weak var lblArebic: UILabel!
    @IBOutlet weak var lblKurdish: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var imgArebic: UIImageView!
    @IBOutlet weak var imgKurdish: UIImageView!
    @IBOutlet weak var imgEnglish: UIImageView!
    @IBOutlet weak var imgEnglishCheck: UIImageView!
    @IBOutlet weak var imgKurdishCheck: UIImageView!
    @IBOutlet weak var imgArebicCheck: UIImageView!
    
    
    var selectedLanguage = ""
    var selectViewFrom = goToFrom.add
    var selectedIndex = -1
    
    var langEng = ""
    var langKur = ""
    var langAr = ""
    
    var counteng=0
    var countkur=0
    var countar=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
            
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
            
        }
        Settext()
        selectEnglish(isSelect: false)
        selectKurdish(isSelect: false)
        selectArebic(isSelect: false)
        
    }
    
    
    func Settext(){
        
        lblselectlanguagehint.text="Select Language (Step 2)".localized()
        lblselectthreehint.text="Please Select in Three Languages".localized()
        lblchoosehint.text="You can choose multiple Language".localized()
            btncontinue.setTitle("Continue".localized(), for:.normal)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Button Action
    @IBAction func actionBackButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func actionArebic(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        selectArebic(isSelect: sender.isSelected)
        langAr = "ar"
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String  ?? "en" == "en"{
             imgArebic.image=UIImage(named: "Group 726")
        }else{
             imgArebic.image=UIImage(named: "arbiclight")
        }
       
        selectedLanguage = langAr
    }
    
    @IBAction func actionKurdish(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        selectKurdish(isSelect: sender.isSelected)
        langKur = "ku"
        
        selectedLanguage = langKur
        
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en" == "en"{
            imgKurdish.image=UIImage(named: "Group 726")
        }else{
            imgKurdish.image=UIImage(named: "arbiclight")
        }
    }
    
    @IBAction func actionEnglish(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        selectEnglish(isSelect: sender.isSelected)
        langEng = "en"
        selectedLanguage = langEng
        
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"  == "en"{
            imgEnglish.image=UIImage(named: "Group 726")
        }else{
            imgEnglish.image=UIImage(named: "arbiclight")
        }
    }
    
    @IBAction func actionContinueButton(_ sender: Any) {
        
        
        
        if selectedLanguage == "" {
            self.showCustomPopupView(altMsg: "Please Select Language", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
        }else {
            let vc = SelectCategoryViewController.instance(.newAdTab) as! SelectCategoryViewController
            vc.chooseViewFrom = .category
            if counteng == 0 && countkur == 0 && countar == 0{
                self.showCustomPopupView(altMsg: "Please Select Language", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                if(counteng != 0)
                {
                    vc.langEng = langEng
                }
                if(countkur != 0)
                {
                    vc.langKurs = langKur
                }
                if(countar != 0)
                {
                    vc.langAr = langAr
                }
                
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        
    }
    
    
    
    
    
    
    
    //    //MARK:- tap action
    //    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    //        // handling code
    //        print("arebic")
    //
    //        langAr = "ar"
    //        selectedLanguage = langAr
    //        selectArebic(isSelect: true)
    //    }
    //
    //    @objc func handleTapKurdish(_ sender: UITapGestureRecognizer? = nil) {
    //        // handling code
    //        print("kurdish")
    //
    //         langKur = "ku"
    //        selectedLanguage = langKur
    //        selectKurdish(isSelect: true)
    //    }
    //
    //    @objc func handleTapEnglish(_ sender: UITapGestureRecognizer? = nil) {
    //        // handling code
    //        print("english")
    //
    //        langEng = "en"
    //        selectedLanguage = langEng
    //        selectEnglish(isSelect: true)
    //
    //    }
    
    
    func selectEnglish(isSelect: Bool) {
        if isSelect == true {
            viewEnglish.borderColor = UIColor.red
            imgEnglish.isHidden = false
            lblEnglish.textColor = .red
            imgEnglishCheck.image = #imageLiteral(resourceName: "Checked")
            counteng=1
        }else {
            counteng=0
            viewEnglish.borderColor = UIColor.lightGray
            imgEnglish.isHidden = true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                lblEnglish.textColor = .white
            }else{
                lblEnglish.textColor = .black
            }
            
            imgEnglishCheck.image = #imageLiteral(resourceName: "Oval")
        }
    }
    
    func selectKurdish(isSelect: Bool) {
        if isSelect == true {
            countkur=1
            viewKurdish.borderColor = UIColor.red
            imgKurdish.isHidden = false
            lblKurdish.textColor = .red
            imgKurdishCheck.image = #imageLiteral(resourceName: "Checked")
        }else {
            countkur=0
            viewKurdish.borderColor = UIColor.lightGray
            imgKurdish.isHidden = true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                lblKurdish.textColor = .white
            }else{
                lblKurdish.textColor = .black
            }
            
            imgKurdishCheck.image = #imageLiteral(resourceName: "empty_circle")
        }
    }
    
    func selectArebic(isSelect: Bool) {
        if isSelect == true {
            countar=1
            viewArebic.borderColor = UIColor.red
            imgArebic.isHidden = false
            lblArebic.textColor = .red
            imgArebicCheck.image = #imageLiteral(resourceName: "Checked")
        }else {
            countar=0
            viewArebic.borderColor = UIColor.lightGray
            imgArebic.isHidden = true
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                lblArebic.textColor = .white
            }else{
                lblArebic.textColor = .black
            }
            
            imgArebicCheck.image = #imageLiteral(resourceName: "Oval")
        }
    }
    
}
