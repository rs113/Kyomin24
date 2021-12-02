//
//  AllPlanViewController.swift
//  Mzadi
//
//  Created by Emizentech on 29/09/21.
//

import UIKit
import Localize_Swift

class AllPlanViewController: UIViewController {
    
    var vctype=""
    var arrplanlist:ActiveExpireModal?
    
    @IBOutlet weak var lblnoplanfound: UILabel!
    @IBOutlet weak var lblremainingvip: UILabel!
    @IBOutlet weak var lblallplan: UILabel!
    @IBOutlet weak var Tblplan: UITableView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnexpired: UIButton!
    @IBOutlet weak var Btnactive: UIButton!
    
    var NoDataView:NoDataScreen?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden=true
        if Localize.currentLanguage() == "en" {
                   self.btnback.transform=CGAffineTransform(rotationAngle:0)
                   
               }else{
                   self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
               }
        Btnactive.isSelected=true
        getMyAllPlan()
    }
    
    
    func Settext(){
        Btnactive.setTitle("Active".localized(), for: .normal)
        btnexpired.setTitle("Expired".localized(), for: .normal)
        lblallplan.text="All Plan".localized()
        
    }
    
    
    
    @IBAction func BtnActiveExpireAction(_ sender: UIButton) {
        if sender == Btnactive {
             Btnactive.isSelected=true
            Btnactive.backgroundColor = .red
            btnexpired.backgroundColor = .white
            btnexpired.setTitleColor(.black, for: .normal)
            Btnactive.setTitleColor(.white, for: .normal)
        }else{
            Btnactive.isSelected=false
            Btnactive.backgroundColor = .white
            btnexpired.backgroundColor = .red
            btnexpired.setTitleColor(.white, for: .normal)
            Btnactive.setTitleColor(.black, for: .normal)
        }
        Tblplan.reloadData()
    }
    
    
//    @IBAction func btnexploreplan(_ sender: Any) {
//        let vc = PurchasePlanViewController.instance(.myAccountTab) as! PurchasePlanViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    

    @IBAction func btnback(_ sender: Any) {
        if vctype == "sidemenu"{
         NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
         self.navigationController?.popViewController(animated: true)
         }else{
        NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
        self.navigationController?.popViewController(animated: true)
         }
    }
    
    
    func getMyAllPlan(){
        let dictParam = ["":""]

        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: MyplanListUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: ActiveExpireModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                print(ResponseJson)
                if stCode == 200{
                    self.arrplanlist = resModel
                    if self.arrplanlist?.data.active.count == 0 {
                        self.lblremainingvip.isHidden=true
                        self.lblnoplanfound.text="No Plan Found"
                        
                    }else if self.arrplanlist?.data.expired.count == 0{
                       self.lblremainingvip.text="No Plan Found"
                    }
                    else{
                    self.lblnoplanfound.isHidden=true
                    self.lblremainingvip.isHidden=false
                    let vipileft = self.arrplanlist?.data.remaningVip ?? ""
                    let textyou = "You have"
                    let vippostleft = "VIP post left"
                    self.lblremainingvip.text="\(textyou) \(vipileft) \(vippostleft)"
                    }
                     self.Tblplan.reloadData()
                }else{
                    self.Tblplan.reloadData()
                    self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                    })
                }
            }) { (stError) in
                self.showCustomPopupView(altMsg: stError, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


extension AllPlanViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Btnactive.isSelected{

            return arrplanlist?.data.active.count ?? 0
        }else{

             return arrplanlist?.data.expired.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activecell", for: indexPath) as! ActivePlanCell
        if Btnactive.isSelected{
        cell.lblprice.text = "IQD \(arrplanlist?.data.active[indexPath.row].planCost ?? "")"
//        let expiredate = arrplanlist?.data.active[indexPath.row].endsAt ?? ""
//        let convertexpire = expiredate.getDateWithFrom
        let Expiretext="Expire on".localized()
        cell.lblexpire.text = "\(Expiretext) \(arrplanlist?.data.active[indexPath.row].endsAt ?? "")"
//        let purchasedate = arrplanlist?.data.active[indexPath.row].createdAt ?? ""
//        let convertpurchase = purchasedate.getDateFrom
            if arrplanlist?.data.active[indexPath.row].planCost ?? "" == "14600" {

                cell.lblthreevipitext.text="One VIP Featured Ad.".localized()
            }else{
              cell.lblthreevipitext.text="Three VIP Featured Ad.".localized()
            }
            
        let purchasetext="Purchase on".localized()
        let bycredit = "by Credit.".localized()
        cell.lblpurchasedate.text = "\(purchasetext) \(arrplanlist?.data.active[indexPath.row].createdAt ?? "") \(bycredit) "
        }else{
       cell.lblprice.text = "IQD \(arrplanlist?.data.expired[indexPath.row].planCost ?? "")"
//       let expiredate = arrplanlist?.data.expired[indexPath.row].endsAt ?? ""
//       let convertexpire = expiredate.getDateWithFrom
       let Expiretext="Expire on".localized()
        if arrplanlist?.data.expired[indexPath.row].planCost ?? "" == "14800" {

            cell.lblthreevipitext.text="One VIP Featured Ad.".localized()
        }else{
          cell.lblthreevipitext.text="Three VIP Featured Ad.".localized()
        }
        
       cell.lblexpire.text = "\(Expiretext) \(arrplanlist?.data.expired[indexPath.row].endsAt ?? "")"
//       let purchasedate = arrplanlist?.data.expired[indexPath.row].createdAt ?? ""
//       let convertpurchase = purchasedate.getDateFrom
       let purchasetext="Purchase on".localized()
       let bycredit = "by Credit.".localized()
       cell.lblpurchasedate.text = "\(purchasetext) \(arrplanlist?.data.expired[indexPath.row].createdAt ?? "") \(bycredit)"
        }
        
        return cell
    }
    
    
}
