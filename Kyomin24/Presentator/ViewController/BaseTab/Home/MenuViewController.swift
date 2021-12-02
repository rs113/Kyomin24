//
//  MenuViewController.swift
//  Mzadi
//
//  Created by Emizentech on 16/08/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    

    @IBOutlet weak var SubcatTbl: UITableView!
    var ArrMenuProfile:LeftMenuCategoryModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    
    navigationController?.navigationBar.isHidden=true
    
    }
    override func viewWillAppear(_ animated: Bool) {
        GetSidebarCategory()
    }
    
    
    func GetSidebarCategory(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: SidebarSubCatUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: LeftMenuCategoryModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrMenuProfile=resModel
                self.SubcatTbl.reloadData()
            }else{
                self.SubcatTbl.reloadData()
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }) { (stError) in
            self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    


}
extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrMenuProfile?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        cell.lblcategoryname.text=ArrMenuProfile?.data?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
    let st = UIStoryboard(name:"HomeTab", bundle:nil)
    let vc = st.instantiateViewController(withIdentifier: "SubCategoryDetailViewController") as! SubCategoryDetailViewController
            vc.Subcatid=self.ArrMenuProfile?.data?[indexPath.row].id
            vc.Subcatname=self.ArrMenuProfile?.data?[indexPath.row].title
     vc.vctype="Menu"
     self.navigationController?.pushViewController(vc, animated: true)
    }
        
    }
    
    
    
}
