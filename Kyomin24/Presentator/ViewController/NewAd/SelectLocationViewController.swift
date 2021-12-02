//
//  SelectLocationViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 25/06/21.
//

import UIKit

class SelectLocationViewController: UIViewController {

    @IBOutlet weak var lblLOcation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Navigation
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        let vc = AddPostViewController.instance(.newAdTab) as! AddPostViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }

}
