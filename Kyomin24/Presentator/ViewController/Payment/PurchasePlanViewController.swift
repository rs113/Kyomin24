//
//  PurchasePlanViewController.swift
//  Mzadi
//
//  Created by Emizentech on 29/09/21.
//

import UIKit
import Localize_Swift
import StoreKit

class PurchasePlanViewController: UIViewController{
    
    var vctype=""
    var products = Array<SKProduct>()
    var selectedPlan = 99
    var arrrpurchase:PurchasePlanModal?
    
    var arrprice = ["IQD 14600"]
    var arrcompanyprice=["IQD 43800","IQD 438000"]
    var plantimeuser = ["Purchase Monthly Plan".localized()]
    var plantimecompany = ["Purchase Monthly Plan".localized(),"Purchase Yearly Plan".localized()]
    var planuser = ["Plan".localized()]
    var plancompany = ["VIP Plan".localized(),"VIP Plan".localized()]
    var planfeatureuser = ["One VIP Featured Ad Per Month.".localized()]
    var planfeaturecompnay = ["Three VIP Featured Ad Per Month.".localized(),"Three VIP Featured Ad Per Month.".localized()]
    var productPrice=String()
    var plantype=String()
    
    
    @IBOutlet weak var tblPurchase: UITableView!
    @IBOutlet weak var lblpurchasetext: UILabel!
    @IBOutlet weak var btnback: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
            
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        self.tabBarController?.tabBar.isHidden=true
        
        SKPaymentQueue.default().add(self)
        GetPlan()
        
        //SKPaymentQueue.default().restoreCompletedTransactions()
        //Check if product is purchased
        
        //        if (defaults.boolForKey("purchased")){
        //           // Hide a view or show content depends on your requirement
        //           overlayView.hidden = true
        //        } else if (!defaults.boolForKey("stonerPurchased")) {
        //            print("false")
        //        }
        
        //    if  obj.prefs.value(forKey: App_User_Role) as? String != "user"{
        //        selectedPlan=0
        //
        //    }else{
        //        selectedPlan=1
        //
        //    }
        //
        
        
    }
    
    
    func Settext(){
        lblpurchasetext.text="Purchase Plan".localized()
        
    }
    
    
    
    func GetPlan(){
        
        let dictParam = ["":""] as [String : Any]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: PlanListUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: PurchasePlanModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                
                self.arrrpurchase = resModel
                self.getProduct()
                self.tblPurchase.reloadData()
            }else{
                self.tblPurchase.reloadData()
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
    
    
    
    func getProduct(){
        
        MzadiProducts.store.requestProducts { [weak self] success, products in
            guard let self = self else { return }
            guard success else {
                
                DispatchQueue.main.async {
                    self.showCustomPopupView(altMsg:"Something went wrong! Please try again later".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
                
                return
            }
            
            print(products)
            
          
            self.products=products ?? [SKProduct]()
            
            
        }
        
    }
    
    
    
    
    
    func SubcriptionPlanApi(planprice:String,transactionid:String,interval:String,status:String,Plantag:String){
        
        let dictRegParam = [
            
            "plan_cost":planprice ,
            "transaction_id":transactionid ,
            "intervel":interval,
            "status":status,
            "plan_tag":Plantag
            ] as [String : Any]
        
        print(dictRegParam)
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: SubcriptionPlanUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            print(ResponseJson)
            self.hideLoader()
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                
                if let resdata = ResponseJson["data"].dictionary{
                            
                let subcriptionstatus = resdata["status"]?.string
                if subcriptionstatus == "1"{
                   obj.prefs.set("1", forKey: App_User_Subscribe)
                }else{
                     obj.prefs.set("0", forKey: App_User_Subscribe)
                }
                
                 DispatchQueue.main.async {
                        let vc = HomeView.instance(.homeTab) as! HomeView
                    self.navigationController?.pushViewController(vc, animated: true)
                                    }
                }
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
    
    
    
    @IBAction func btnback(_ sender: Any) {
        if vctype == "sidemenu"{
            NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
    @objc func btnPurchase(sender:UIButton){
      
        var selectedplan:SKProduct?
        for pro in products  {
                   if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
                    if pro.productIdentifier=="Mzadi_One_Month_User_Plan".localized(){
                        print(pro.price)
                        print(pro.priceLocale)
                        selectedplan=pro
                        break
                       }
                   }else{
                    if arrrpurchase?.data[sender.tag].intervel == "1 Month" {
                        if pro.productIdentifier=="Mzadi_One_Month_Complany_Plan".localized(){
                         selectedplan=pro
                          break
                        }
                    }else{
                        if pro.productIdentifier=="Maadi_OneYear_Company_Plan".localized(){
                        selectedplan=pro
                            break
                        }
                    }

                   }
                   }
        
      
        if selectedplan == nil{
            return
        }
        MzadiProducts.store.buyProduct(selectedplan!) { [weak self] success, productId in
            guard let self = self else { return }
            guard success else {
                
                
                DispatchQueue.main.async {
                    self.showCustomPopupView(altMsg:"Something went wrong! Please try again later.".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                                      self.dismiss(animated: true, completion: nil)
                                  }
                }
                
//                DispatchQueue.main.async {
//                    let alertController = UIAlertController(title: "Error!",
//                                                            message: "Something went wrong!! Please try again or later.",
//                                                            preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
//                    self.present(alertController, animated: true, completion: nil)
                
                return
            }
            self.validateReciept()
        }
        
    }
    
    func validateReciept(){
       
        let verifyReceiptURL = MzadiProducts.store.SandBox
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let jsonDict: [String: AnyObject] = ["receipt-data" : recieptString! as AnyObject, "password" : MzadiProducts.store.sharedSecret as AnyObject, "exclude-old-transaction": true as AnyObject]
        
        do {
            let requestData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let storeURL = URL(string: verifyReceiptURL)!
            var storeRequest = URLRequest(url: storeURL)
            storeRequest.httpMethod = "POST"
            storeRequest.httpBody = requestData
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) in
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                        
                        print("Response :",jsonResponse)
                        if let date = self?.getExpirationDateFromResponse(jsonResponse) {
                            print(date)
                            var dateMS = ""
                            var param : [String:Any] = [:]
                            
                            if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
                                
                                let lastReceipt = receiptInfo.firstObject as! NSDictionary
                                let timeinterval = lastReceipt["expires_date_ms"] as! String
                                print(timeinterval)
                                let productid = lastReceipt["product_id"] as! String
                                print(productid)
                                let transactionId = lastReceipt["transaction_id"] as! String
                                print(transactionId)
                                
                                if productid == "Mzadi_One_Month_User_Plan"{
                                    self?.productPrice="14800"
                                    self?.plantype="One Month"
                                }else if productid == "Mzadi_One_Month_Complany_Plan"{
                                    self?.productPrice="43800"
                                    self?.plantype="One Month"
                                }else{
                                    self?.productPrice="438000"
                                    self?.plantype="One Year"
                                }
                                
                                DispatchQueue.main.async {
                                    self?.SubcriptionPlanApi(planprice: self?.productPrice ?? "", transactionid: transactionId, interval: timeinterval, status: "1", Plantag: self?.plantype ?? "")
                                }
                            
                            
//                            if Int64(dateMS)! > Date().currentTimeMillis(){
//                                param = ["user_id" : obj.prefs.value(forKey: APP_USER_ID) ?? "",
//                                         "status" : "1",
//                                         "exp_date" : dateMS
//                                ]
//
//                            }else{
//                                param = ["user_id" : obj.prefs.value(forKey: APP_USER_ID) ?? "",
//                                         "status" : "0",
//                                         "exp_date" : dateMS
//                                ]
//
//                            }
                     
                          
                   
                   
                        }
                        }
//                        DispatchQueue.main.async {
//
//                let vc = HomeView.instance(.homeTab) as! HomeView
//                   self?.navigationController?.pushViewController(vc, animated: true)
//                    }
                    }
                } catch let parseError {
                    print(parseError)
                }
            })
            task.resume()
        } catch let parseError {
            print(parseError)
        }
    }
    
    func getExpirationDateFromResponse(_ jsonResponse: NSDictionary) -> Date? {
        
        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
            
            let lastReceipt = receiptInfo.firstObject as! NSDictionary
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            
            if let expiresDate = lastReceipt["expires_date"] as? String {
                return formatter.date(from: expiresDate)
            }
            
            return nil
        }
        else {
            return nil
        }
    }
    
    //        func updateSubscriptionStatus(param:[String:Any]){
    //    //        AppUtils.showLoader()
    //            let apiURL = "familymember/iphone_subscription_status"
    //            let apimethod:HTTPMethod = .post
    //            NetworkManager.shared().requestAPI(params: param, url: apiURL, methodType:apimethod, success: { (response) in
    //                AppUtils.hideLoader()
    //                if self.isFromRegister{
    //                    let homeViewController = UIStoryboard.loadViewController(identifierVC: "HomeViewController") as? HomeViewController
    //                    homeViewController?.parentmodel = self.user
    //                    AppUtils.saveIsFromPersonnel(value: false)
    //                    self.navigationController?.pushViewController(homeViewController!, animated: true)
    //                }else{
    //                    self.navigationController?.popViewController(animated: true)
    //                }
    //
    //            }) { (error) in
    //
    //                debugPrint(error.localizedDescription)
    //                AlertManager.showAlertWithTitleOnController(title: "Error", message: error.localizedDescription,controller: self)
    //            }
    //        }
    //    }
    //
    //
    
    
}

extension PurchasePlanViewController:SKPaymentTransactionObserver{
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    //                       defaults.setBool(true , forKey: "purchased")
                    //                       overlayView.hidden = true
                    
                    break;
                case .failed:
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                default:
                    break;
                }
            }
        }
    }
    
    
    //    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
    //        for transaction in queue.transactions {
    //            let t: SKPaymentTransaction = transaction
    //            let prodID = t.payment.productIdentifier as String
    //
    //            switch prodID {
    //            case "ProductID1":
    //                // implement the given in-app purchase as if it were bought
    //            case "ProductID2":
    //                // implement the given in-app purchase as if it were bought
    //            default:
    //                print("iap not found")
    //            }
    //        }
    //    }
    
    
}


extension PurchasePlanViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
            return arrprice.count
         }else{
            return arrcompanyprice.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as! PurchaseTableViewCell
        if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
            cell.lblplanmonth.text = plantimeuser[indexPath.row]
            cell.lblprice.text = arrprice[indexPath.row]
            cell.lblfeature.text=planfeatureuser[indexPath.row]
            cell.lblplantype.text=planuser[indexPath.row]
        }else{
            cell.lblplanmonth.text = plantimecompany[indexPath.row]
            cell.lblprice.text = arrcompanyprice[indexPath.row]
            cell.lblfeature.text=planfeaturecompnay[indexPath.row]
            cell.lblplantype.text=plancompany[indexPath.row]
        }
//        cell.lblprice.text = arrrpurchase?.data[indexPath.row].price ?? ""
//       cell.lblplantype.text = arrrpurchase?.data[indexPath.row].title ?? ""
        cell.btnpurchase.tag=indexPath.row
        cell.btnpurchase.addTarget(self, action: #selector(btnPurchase(sender:)), for: .touchUpInside)
        return cell
    }
    
    
}
