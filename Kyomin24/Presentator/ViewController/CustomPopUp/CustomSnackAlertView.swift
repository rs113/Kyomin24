//
//  CustomSnackAlertView.swift
//  Mzadi
//
//  Created by Emizentech on 09/08/21.
//

import UIKit

class CustomSnackAlertView: UIViewController {

    @IBOutlet weak var btnok: UIButton!
    @IBOutlet weak var lblalert: UILabel!
    
    var alertMsg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblalert.text=alertMsg
        btnok.setTitle("Ok".localized(), for: .normal)
    }
   
    @IBAction func btnOk(_ sender: Any) {
        OKNewCallBack!()
   }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view?.frame.origin.y == 0{
           self.dismiss(animated: true, completion: nil)
        }
    }

}
