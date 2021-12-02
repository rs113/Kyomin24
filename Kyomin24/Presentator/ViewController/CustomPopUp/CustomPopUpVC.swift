//
//  CustomPopUpVC.swift
//  Mzadi
//
//  Created by Emizentech on 04/08/21.
//

import UIKit

class CustomPopUpVC: UIViewController {

    
    @IBOutlet weak var AlertImg: UIImageView!
    @IBOutlet weak var lblAlertMsg: UILabel!
   
    @IBOutlet weak var LblAlertTitle: UILabel!
    
        @IBOutlet weak var btnConfirm: UIButton!
        @IBOutlet weak var btnClose: UIButton!
    
    
        var alertMessage = ""
        var alertTitle=""
        var alertImage=UIImage()
        var cancelHide = false
        override func viewDidLoad() {
            super.viewDidLoad()

            lblAlertMsg.text = alertMessage
            LblAlertTitle.text = alertTitle
            AlertImg.image=alertImage
            if cancelHide{
                btnClose.isHidden = true
            }else{
                btnClose.isHidden = false
            }
            btnClose.setTitle("Close".localized(), for: .normal)
            btnConfirm.setTitle("Confirm".localized(), for: .normal)
        }
    
    
    
    
       
        
        @IBAction func btnConfirmAction(_ sender: Any) {
            OKNewCallBack!()
        }
        
        @IBAction func btnCloseAction(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            
        }
    
    @IBAction func btncross(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
       }
    
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if touches.first?.view?.frame.origin.y == 0{
               self.dismiss(animated: true, completion: nil)
            }
        }
//        
    }

