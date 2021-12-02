//
//  ReportViewController.swift
//  Mzadi
//
//  Created by Emizentech on 07/09/21.
//

import UIKit
import ActionSheetPicker_3_0
import Localize_Swift
import SwiftyPickerPopover

class ReportViewController: UIViewController {

    @IBOutlet weak var lblforfurther: UILabel!
    @IBOutlet weak var btnchoosereason: UIButton!
        @IBOutlet weak var txtreason: UITextField!
        @IBOutlet weak var txtview: UITextView!
        @IBOutlet weak var btnsubmit: DesignableButton!
        @IBOutlet weak var lblreportaddtext: UILabel!
        
        var prenav:UINavigationController?
        var selectedRow: Int = 0
        var ArrReasonList:ReasonListModal?
        var Arrreason=[String]()
        var SelectedId=""
        var PostId=""
        var langAdd=""
        var vctype=""
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if vctype == "Detail"{
            if langAdd == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                Localize.setCurrentLanguage("ar")
            }else{
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                Localize.setCurrentLanguage("en")
            }
            
            }
            
            
            txtview.placeholder = "Type here".localized()
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
                txtreason.attributedPlaceholder = NSAttributedString(string: "Choose a Reason".localized(),
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }else{
                txtreason.attributedPlaceholder = NSAttributedString(string: "Choose a Reason".localized(),
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            }
            Settext()
            ReasonList()
        }
    
    
    

    override func viewWillDisappear(_ animated: Bool) {
        let currentlanguage = obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
                if vctype == "Detail"{
               if currentlanguage == "ar" {
                   UIView.appearance().semanticContentAttribute = .forceRightToLeft
                   Localize.setCurrentLanguage(currentlanguage)
                   
               }else if currentlanguage == "ku" {
                   UIView.appearance().semanticContentAttribute = .forceRightToLeft
                Localize.setCurrentLanguage(currentlanguage)
               }else{
                   
                  UIView.appearance().semanticContentAttribute = .forceLeftToRight
                  Localize.setCurrentLanguage(currentlanguage)
               }
               }
        
        
        
//        if vctype == "Detail"{
//        if langAdd == "ar" {
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            Localize.setCurrentLanguage("en")
//
//        }else{
//           UIView.appearance().semanticContentAttribute = .forceRightToLeft
//           Localize.setCurrentLanguage("ar")
//        }
//        }
    }
    
        
        
        @IBAction func btncross(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func btnsubmit(_ sender: Any) {
            
            if self.txtreason.text == "" {
                self.showCustomPopupView(altMsg: "Please select a reason".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
                return
            }
            else if self.txtview.text == "" {
                self.showCustomPopupView(altMsg: "Please type here".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
                return
                
            }
            self.dismiss(animated: true) {
                self.ReportAd(reasonid: self.SelectedId )
            }
        }
    
    
    
    func Settext(){
        lblreportaddtext.text="Report Ad".localized()
        btnsubmit.setTitle("Submit".localized(), for: .normal)
        lblforfurther.text="For further assistance please Contact Our Costomer Service Team at:post@mzadi.net".localized()
        
    }
        
        
        func Dropdown(choices:[String],title:String,sender:UIButton){
            ActionSheetStringPicker.show(withTitle:title, rows: choices, initialSelection: 0, doneBlock: { (acp, SelInd, selTxt) in
                // print("done row \(self.selectedRow) \(selTxt ?? "")")
                print(SelInd)
                self.selectedRow = SelInd
            
                if sender == self.btnchoosereason {
                    self.txtreason.text = "\(selTxt ?? "")"
                    self.SelectedId = self.ArrReasonList?.data[SelInd].id ?? ""
                    print(self.SelectedId)
                    
                }
                
                
                
            }, cancel: { (act) in
            
            }, origin: sender)
            
        }
    
    
    
    func dropdown(choices:[String],title:String,sender:UIButton){
            StringPickerPopover(title: title, choices: choices)
                .setValueChange(action: { _, SelInd, selectedString in
                    print("current string: \(selectedString)")
                    
                    if sender == self.btnchoosereason {
                        self.txtreason.text = "\(selectedString )"
                self.SelectedId = self.ArrReasonList?.data[SelInd].id ?? ""
                        print(self.SelectedId)
                                       
                                   }
                    
                })
                .setArrowColor(.white)
                .setFontSize(16)
                .setDoneButton(title: "Done".localized(), font: .systemFont(ofSize: 16), color: .systemBlue, action: nil)
                .setDoneButton(
                    action: { popover, selectedRow, selectedString in
                        print("done row \(selectedRow) \(selectedString)")
                        self.selectedRow = selectedRow
                        
                })
                .setCancelButton(title: "Cancel".localized(), font: .systemFont(ofSize: 16), color: .systemBlue, action: nil)
                .setCancelButton(action: {_, _, _ in
                    print("cancel") })
                .setSelectedRow(selectedRow)
                .appear(originView: sender, baseViewController: self)
        }
        
        
        @IBAction func BtnChooseReason(_ sender: UIButton) {
            dropdown(choices: Arrreason, title: "Choose a Reason".localized(), sender: btnchoosereason)
//            Dropdown(choices: Arrreason, title: "Choose a Reason".localized(), sender: btnchoosereason)
        }
        
        
        
        func ReasonList(){
            let dictParam = ["reason_for":"3"]
            ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: ReasonListUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: ReasonListModal.self, success: { [self] (ResponseJson, resModel, st) in
                
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.ArrReasonList=resModel
                    for i in 0...(self.ArrReasonList?.data.count ?? 0)-1 {
                        self.Arrreason.append(self.ArrReasonList?.data[i].title ?? "")
                    }
                    
                }else{
                    
                    self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }) { (stError) in
                self.showCustomPopupView(altMsg: stError, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        
        
        
        
        func ReportAd(reasonid:String){
            let dictRegParam = [
                "reason_id":reasonid,
                "repoted_id":PostId,
                "report_for":"0",
                "post_id":PostId,
                "description":txtview.text ?? ""
                
                ] as [String : Any]
            print(dictRegParam)
            
            ApiManager.apiShared.sendRequestServerPostWithHeader(url: ReportSubmitUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
                
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name("Notification"), object: nil, userInfo: nil)
                    }
                    
                    
                }else{
                    self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                
                
                
            }) { (Strerr,stCode) in
                self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
        
    }

