//
//  CustomPopView.swift
//  Mzadi
//
//  Created by Emizentech on 05/08/21.
//

import UIKit

class CustomPopView: UIViewController {
    

     @IBOutlet weak var AlertImg: UIImageView!
     @IBOutlet weak var lblAlertMsg: UILabel!
    
     @IBOutlet weak var LblAlertTitle: UILabel!
     
    @IBOutlet weak var btnOk: UIButton!
    
    
    var alertMessage = ""
    var alertTitle=""
    var alertImage=UIImage()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    lblAlertMsg.text = alertMessage
    LblAlertTitle.text = alertTitle
    AlertImg.image=alertImage

    btnOk.setTitle("OK".localized(), for: .normal)
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
              OKNewCallBack!()
          }
          
    @IBAction func btncross(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view?.frame.origin.y == 0{
           self.dismiss(animated: true, completion: nil)
        }
    }

}
