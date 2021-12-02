//
//  PostAdSuccessViewController.swift
//  Mzadi
//
//  Created by Emizentech on 29/08/21.
//

import UIKit

class PostAdSuccessViewController: UIViewController {
    
    
    @IBOutlet weak var btnviewad: UIButton!
    @IBOutlet weak var lblpostaddhint: UILabel!
    var productidL:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblpostaddhint.text="Post Ad Successfully ".localized()
        btnviewad.setTitle("View Ad", for: .normal)
    }
    
    @IBAction func btnviewAd(_ sender: Any) {
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
        vc.productId = String(productidL ?? 0)
        vc.vctype="Postsuccess"
        vc.Boolvalue=true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
