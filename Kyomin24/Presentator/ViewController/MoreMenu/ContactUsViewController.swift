//
//  ContactUsViewController.swift
//  Mzadi
//
//  Created by Emizentech on 03/09/21.
//

import UIKit
import Localize_Swift

class ContactUsViewController: UIViewController {

    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var lblanyquestionhint: UILabel!
    @IBOutlet weak var lblcontactushint: UILabel!
    @IBOutlet weak var txtsubject: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtview: UITextView!
    @IBOutlet weak var btnback: UIButton!
    
    var vctype=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        Settext()
        self.tabBarController?.tabBar.isHidden=true
        txtview.placeholder="Description".localized()
    }
    
    
    
    
    func Settext(){
        lblcontactushint.text="Contact Us".localized()
        lblanyquestionhint.text="Any question ? Please write us".localized()
        txtname.placeholder="Name".localized()
        txtemail.placeholder="Email".localized()
        txtsubject.placeholder="Subject".localized()
        btnsubmit.setTitle("Submit".localized(), for: .normal)
    }
    

    @IBAction func btnback(_ sender: Any) {
         if vctype == "sidemenu"{
                NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
                self.navigationController?.popViewController(animated: true)
                }else{
               NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
               self.navigationController?.popViewController(animated: true)
                }
    }
    
    
    
    func ContactUsApiCall(){
        let dictRegParam = [
            
            "name":txtname.text ?? "",
            "email":txtemail.text ?? "",
            "subject":txtsubject.text ?? "",
            "description":txtview.text ?? ""
            ] as [String : Any]
        
        print(dictRegParam)
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: ContactusUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
                self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func btnsubmit(_ sender: Any) {
        if (txtname.text?.isStringBlank())!{
            
        self.showCustomPopupView(altMsg:"Please enter name".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
         self.dismiss(animated: true, completion: nil)
        }
            return
         }else if(txtemail.text?.isStringBlank())!{
            self.showCustomPopupView(altMsg:"Please enter email".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            self.dismiss(animated: true, completion: nil)
           }
            return
         }
         else if (txtsubject.text?.isStringBlank())!{
            self.showCustomPopupView(altMsg:"Please enter subject".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            self.dismiss(animated: true, completion: nil)
            }
            return
        }else if (txtview.text?.isStringBlank())!{
        self.showCustomPopupView(altMsg:"Please enter description".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
        self.dismiss(animated: true, completion: nil)
        }
        return
         
        } else{
         ContactUsApiCall()
        }
            
        }
        
        

}



