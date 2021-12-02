//
//  CustomPopupViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 08/06/21.
//

import UIKit

class CustomPopupViewController: UIViewController {

    var popupDismissBlock : ((String) -> Void)?
    
    @IBOutlet weak var lblALertMessage: UILabel!
    @IBOutlet weak var btnClose: UIButton!

    var alertMsg = ""
    var alertBtnTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        lblALertMessage.text = alertMsg
//        btnClose.setTitle(alertBtnTitle, for: .normal)

    }
    
    //MARK:- button action
    @IBAction func btnYesAction(_ sender: Any) {
        self.dismiss(animated: true) {
            if let block = self.popupDismissBlock {
                block("yes")
            }
        }
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func tappedCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
