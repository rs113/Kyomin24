//
//  SelectAdTypeViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//

import UIKit
import Localize_Swift

class SelectAdTypeViewController: UIViewController {
    
    @IBOutlet weak var lblbypost: UILabel!
    @IBOutlet weak var lblselectaddtypehint: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var continueButton: DesignableButton!

    @IBOutlet weak var selectlblAny: UILabel!
    @IBOutlet weak var viewBgBorder: UIView!
    @IBOutlet weak var viewFreeAdd: UIView!
    @IBOutlet weak var viewVipAd: UIView!
    @IBOutlet weak var lblFreeAd: UILabel!
    @IBOutlet weak var lblVipAd: UILabel!
    @IBOutlet weak var imgFreeAd: UIImageView!
    @IBOutlet weak var imgVipAd: UIImageView!
    
    var vctype=""
    var selectAddType = AddType.free
    var selectViewFrom = goToFrom.add
    var Selectone=""
    var selectvip=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden=true
       if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        setTapGestureOnView()
        Settext()
        //        viewFreeAdd.borderColor = UIColor.red
        //        imgFreeAd.isHidden = false
        //        lblFreeAd.textColor = .red
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setimage()
    }
    
    
    func Settext(){
        lblVipAd.text="VIP Ad".localized()
        lblFreeAd.text="Free Ad".localized()
        selectlblAny.text="Select Any".localized()
        continueButton.setTitle("Continue".localized(), for: .normal)
        lblselectaddtypehint.text="Select the Ad Type (Step 1)".localized()
        
    }
    
    
    func setimage(){
        if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ku" {
            
        }else if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
            imgFreeAd.image=UIImage(named: "arbiclight")
            imgVipAd.image=UIImage(named: "arbiclight")
            
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
        }
    }
    // MARK: - Navigation
    func setTapGestureOnView() {
        let tapFree = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewFreeAdd.addGestureRecognizer(tapFree)
        
        let tapVip = UITapGestureRecognizer(target: self, action: #selector(self.handleTapLightTheme(_:)))
        viewVipAd.addGestureRecognizer(tapVip)
    }
    
    //MARK:- action
    @IBAction func actionBack(_ sender: Any) {
        if vctype == "sidemenu"{
            NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
        }
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        
        
        if Selectone == ""{
            self.showCustomSnackAlert(altMsg: "Please select one") {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }else if selectvip == "vip" {
            //        self.showCustomSnackAlert(altMsg: "Please Purchase Vip Plan. To Proceed Further") {
            //                self.dismiss(animated: true, completion: nil)
            //            }
            SelectAddApi()
        }else if selectvip == "free" {
            
            SelectAddApi()
        }else{
            
        }
        //        let vc = SelectCategoryViewController.instance(.newAdTab) as! SelectCategoryViewController
        //        vc.chooseViewFrom = .category
        //        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func SelectAddApi(){
        let dictRegParam = [
            
            "post_type":selectvip
            ] as [String : Any]
        
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: SelectedAddTypeUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                let vc = ChooseLanguageViewController.instance(.newAdTab) as! ChooseLanguageViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                
                if obj.prefs.value(forKey: App_User_Subscribe) as? String == "0" {
                    self.showCustomPopupView(altMsg: "Please Purchase VIP Plan. to Proceed Further", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                        let vc = PurchasePlanViewController.instance(.myAccountTab) as! PurchasePlanViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                
                }else{
                    self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                
                
                
            }
            
            
            
        }) { (Strerr,stCode) in
            if obj.prefs.value(forKey: App_User_Subscribe) as? String == "0" {
                
                self.showCustomPopupViewAction(altMsg:"Please Purchase VIP Plan. to Proceed Further", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "PURCHASE", OkAction: {popup in
                    popup.dismiss(animated: true, completion: {
                        let vc = PurchasePlanViewController.instance(.myAccountTab) as! PurchasePlanViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                })
                
            }else{
                self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
        }
        
        
    }
    
    @IBAction func actionCheckUncheck(_ sender: Any) {
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("free")
        Selectone="value"
        selectvip="free"
        selectAddType = .free
        viewVipAd.borderColor = UIColor.lightGray
        imgVipAd.isHidden = true
        
        obj.prefs.set(0, forKey: App_User_Addtype)
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblVipAd.textColor = .white
        }else{
            lblVipAd.textColor = .black
        }
        
        
        viewFreeAdd.borderColor = UIColor.red
        
        imgFreeAd.isHidden = false
        
        lblFreeAd.textColor = .red
    }
    
    @objc func handleTapLightTheme(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("vip")
        Selectone="value"
        selectvip="vip"
        selectAddType = .vip
        viewVipAd.borderColor = UIColor.red
        imgVipAd.isHidden = false
        lblVipAd.textColor = .red
        
        viewFreeAdd.borderColor = UIColor.lightGray
        imgFreeAd.isHidden = true
        
        obj.prefs.set(1, forKey: App_User_Addtype)
        
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
            lblFreeAd.textColor = .white
        }else{
            lblFreeAd.textColor = .black
        }
        
    }
    
}


enum AddType: String {
    case free = "free"
    case vip = "vip"
}

enum goToFrom: String {
    case add = "add"
    case addAdvertise = "addAdvertise"
}
