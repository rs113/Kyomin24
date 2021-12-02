//
//  BlockUserViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.
//

import UIKit
import Localize_Swift

class BlockUserViewController: BaseMoreMenuViewController {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lblblockuserhint: UILabel!
    @IBOutlet weak var tblList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
 self.tabBarController?.tabBar.isHidden=true
    if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
    }
    
    // MARK: - Action
    @IBAction func actionMenu(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
              self.navigationController?.popViewController(animated: true)
    }

}

extension BlockUserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BlockUserTableViewCell.self), for: indexPath) as! BlockUserTableViewCell
        return cell
    }
}

extension BlockUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
