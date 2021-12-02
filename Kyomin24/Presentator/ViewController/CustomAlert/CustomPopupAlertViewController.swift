//
//  CustomPopupAlertViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.
//

import UIKit

class CustomPopupAlertViewController: UIViewController {

    @IBOutlet weak var lblALertTitle: UILabel!
    @IBOutlet weak var lblALertMessage: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var popupDismissBlock : ((String) -> Void)?


    var alertMsg:String?
    var alertTitle:String?
    var btnTitle = ""
    var btnTitle2 = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        lblALertTitle.text = alertMsg
        lblALertMessage.text = alertMsg
        btnClose.setTitle("Close".localized(), for: .normal)
        btnConfirm.setTitle("Confirm".localized(), for: .normal)

    }

    //MARK:- button action
    @IBAction func btnCancelAction(_ sender: Any) {
        self.dismiss(animated: true) {
            if let block = self.popupDismissBlock {
                block("no")
            }
        }
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
        self.dismiss(animated: true) {
            if let block = self.popupDismissBlock {
                block("yes")
            }
        }
    }
    
    @IBAction func tappedCancelBg(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
