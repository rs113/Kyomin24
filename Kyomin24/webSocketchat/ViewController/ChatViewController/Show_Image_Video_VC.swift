//
//  Show_Image_Video_VC.swift
//  Walkys
//
//  Created by emizen on 09/10/20.
//  Copyright © 2020 emizen. All rights reserved.
//

import UIKit
import AVKit

class Show_Image_Video_VC: UIViewController {

   
    @IBOutlet weak var imgFull: UIImageView!
//    @IBOutlet weak var pagCounts: UIPageControl!
//    @IBOutlet weak var view_Out_Header: BottomRoundView!
//    @IBOutlet weak var coll_View_Image: UICollectionView!
     
    var selectedTag:Int?
    var vctype = ""
    var imgFullUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        imgFull.sd_setImage(with: URL(string:imgFullUrl), placeholderImage: UIImage(named: "placeHolder"))
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    

    @IBAction func BtnBackTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated:  true, completion:   nil)
    }

}

    

