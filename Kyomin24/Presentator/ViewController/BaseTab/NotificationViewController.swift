//
//  NotificationViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 02/07/21.
//

import UIKit
import Localize_Swift


class NotificationViewController: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var btnclearall: UIButton!
    @IBOutlet weak var lblnotificationhint: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    var arrNotifcation:NotificationModel?
    
    var selectedindex:Int?
    
    let refreshControl = UIRefreshControl()
    
    var NotiValue=false
    
    var NoDataView:NoDataScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tblList.addSubview(refreshControl)
        GetNotificationList()
        if Localize.currentLanguage() == "en" {
               self.btnBack.transform=CGAffineTransform(rotationAngle:0)
                      
                  }else{
                  self.btnBack.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
                  }
        
        lblnotificationhint.text="Notification".localized()
        btnclearall.setTitle("Clear".localized(), for: .normal)
        NoDataView = tblList.ShowCustomNoDataView(noDataMsg: "No notification found yet".localized())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func refresh(_ sender: AnyObject) {
        NotiValue=false
        GetNotificationList()
    }
    
    
    @IBAction func btnclear(_ sender: Any) {
      ClearNotiApiCall()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        NotiValue=false
        let data: [String:Any] = ["NotiValue": NotiValue]
        print(data)
        NotificationCenter.default.post(name:NSNotification.Name("myhome"), object: nil, userInfo:data)
    }
    
    
    func GetNotificationList(){
        self.refreshControl.endRefreshing()
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetNotificationUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: NotificationModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.arrNotifcation = resModel
                if self.arrNotifcation?.data.count ?? 0  == 0{
                    self.btnclearall.isHidden=true
                }else{
                    self.btnclearall.isHidden=false
                }
                self.tblList.reloadData()
            }else{
                self.tblList.reloadData()
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
    
    
    func ClearNotiApiCall(){
        let dictRegParam = [
            
            "":""
            ] as [String : Any]
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: ClearNotificationUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.GetNotificationList()
                self.tblList.reloadData()
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            
            
        }) { (Strerr,stCode) in
            
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
    
    
    
    
}

extension NotificationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrNotifcation?.data.count ?? 0  == 0{
             NoDataView?.isHidden = false
        }else{
              NoDataView?.isHidden = true

        }

        
        return arrNotifcation?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationTableViewCell.self), for: indexPath) as! NotificationTableViewCell
        
        
        
        cell.lblTitle.text=arrNotifcation?.data[indexPath.row].title.htmlToString
        cell.lblcreatenoti.text = arrNotifcation?.data[indexPath.row].createdAt
        cell.lblSubTitle.text=arrNotifcation?.data[indexPath.row].datumDescription.htmlToString
        
        
        if arrNotifcation?.data[indexPath.row].status == "0"{
           cell.viewBG.backgroundColor = .red
            cell.lblTitle.textColor = .white
            cell.lblcreatenoti.textColor = .white
            cell.lblSubTitle.textColor = .white
        }else{
            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
        cell.viewBG.backgroundColor = UIColor(red: 53/255, green: 71/255, blue: 82/255, alpha: 1)
                cell.lblTitle.textColor = .white
                cell.lblcreatenoti.textColor = .white
                cell.lblSubTitle.textColor = .white
            }else{
                cell.viewBG.backgroundColor = .white
                cell.lblTitle.textColor = .black
                cell.lblcreatenoti.textColor = .black
                cell.lblSubTitle.textColor = .black
            }

        }
        
        
        return cell
        
        //        cell.lblSubTitle.text=arrNotifcation.data[indexPath.row].datumDescription.htmlToString
        //        if selectedindex==indexPath.row {
        //            cell.viewBG.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.02352941176, blue: 0.04705882353, alpha: 1)
        //            cell.lblTitle.textColor = .white
        //            cell.lblSubTitle.textColor = .white
        //        }
        //        else{
        //            if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
        //               cell.viewBG.backgroundColor = UIColor(red: 53/255, green: 71/255, blue: 82/255, alpha: 1)
        //                cell.lblTitle.textColor = .white
        //                cell.lblSubTitle.textColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)
        //            }else{
        //                cell.viewBG.backgroundColor = .white
        //                cell.lblTitle.textColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        //                cell.lblSubTitle.textColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)
        //            }
        //
        //        }
        
        
        
        
        
        //        if indexPath.row == 1 {
        //            cell.viewBG.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.02352941176, blue: 0.04705882353, alpha: 1)
        //            cell.lblTitle.textColor = .white
        //            cell.lblSubTitle.textColor = .white
        //        }else {
        //
        //            cell.viewBG.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //            cell.lblTitle.textColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        //            cell.lblSubTitle.textColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)
        //
        //        }
        
    }
}

extension NotificationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrNotifcation?.data[indexPath.row].datumFor == "0" {
            let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
            vc.productId=arrNotifcation?.data[indexPath.row].forID ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //               selectedindex=indexPath.row
        //               print(selectedindex ?? 00)
        //               tblList.reloadData()
        
    }
}

