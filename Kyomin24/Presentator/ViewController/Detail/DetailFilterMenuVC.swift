//
//  DetailFilterMenuVC.swift
//  Mzadi
//
//  Created by Emizen tech on 17/08/21.
//




import UIKit
import Localize_Swift

class DetailFilterTableCell: UITableViewCell {
    @IBOutlet weak var ClickImg: UIImageView!
    @IBOutlet weak var lblFeildLable: UILabel!
    @IBOutlet weak var lblFeildPlaceholder: UITextField!
    @IBOutlet weak var placeholderView: UIView!
    
}
class DetailFilterMenuVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var fromPriceTxt: UITextField!
    @IBOutlet weak var toPriceTxt: UITextField!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var priceStackview: UIStackView!
    
    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var btnresetfilter: UIButton!
    @IBOutlet weak var lblsubcategories: UILabel!
    @IBOutlet weak var lblcategorieshint: UILabel!
    @IBOutlet weak var lblfilterhint: UILabel!
    var Subcatid:String?
    var Subcatname:String?
    var MainCatName:String?
    var CategoryId:String?
    var selectCategory = ""
    
    var ArrCategorylist:GetCategoryListModel?
    var dicdata = [Subcategory]()
    
    var listArray: SlideListModal?
    var index = Int()
    var getIndex = Int()
    var getStr = ""
    var getselecteid = 0
    var getselectedindex:Int?
    
    var idArray = [Int]()
    var feildNameArray = [String]()
    
    var adtype=0
    var protype=0
    var procondition=0
    var proguaranty=0
    var city=0
    var promodal=0
    var prokm=""
    var procamera=0
    var procapicity=0
    var prosim=0
    
    
    
    var location = ""
    var hidden = ""
    
    var SelectedValue = false
    
    var selectdText = ""
    
    var SubCategoryCallBack: ((_ SelectedSubCatId: String)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Settext()
        GetCategoryList()
        if SelectedValue == false {
            getFilterData(SubCatid: Subcatid ?? "")
        }
        
        if SelectedValue == true{
            self.lblSubCategory.text = "Choose Sub Category".localized()
             priceStackview.isHidden=true
        } else {
            lblSubCategory.text = Subcatname
            priceStackview.isHidden=false
            
        }
        
        lblCategory.text=MainCatName
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getValue(notification:)), name: Notification.Name("Identifier"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.BackButton(notification:)), name: Notification.Name("Back"), object: nil)
        
        
        if Localize.currentLanguage() == "en" {
        self.btnBack.transform=CGAffineTransform(rotationAngle:0)
               
           }else{
           self.btnBack.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
           }
        
    }
    
    
    @objc func BackButton(notification: Notification) {
        SelectedValue = true
        if SelectedValue == true {
            self.lblSubCategory.text = "Choose Sub Category".localized()
            
        }
        tableview.reloadData()
    }
    
    
    func Settext(){
        lblfilterhint.text="Filter".localized()
        lblcategorieshint.text="Categories".localized()
        lblsubcategories.text="Sub Categories".localized()
        btnresetfilter.setTitle("Reset Filter".localized(), for: .normal)
        btnsearch.setTitle("Search".localized(), for: .normal)
        toPriceTxt.placeholder="To".localized()
        fromPriceTxt.placeholder="From".localized()
    }
    
    @IBAction func didTapDismis(_ sender: Any) {
        let data: [String:Any] = ["check": SelectedValue,"CatName" : lblCategory.text!] as [String:Any]
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("CheckValue"), object: nil, userInfo: data)
    }
    
    @IBAction func Btnfilter(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("ResetFilter"), object: nil)
    }
    @IBAction func didTapSearch(_ sender: Any) {
        if SelectedValue == false {

        priceStackview.isHidden=true
        for i in 0...(listArray?.data?.count ?? 0)-1{
            let cell = tableView(tableview, cellForRowAt: IndexPath(row: i, section: 0)) as! DetailFilterTableCell
            if listArray?.data?[i].fieldName == "pro_km" {
                prokm = cell.lblFeildPlaceholder.text ?? ""
            }
            
        }
       }
        
        self.dismiss(animated: true, completion: nil)
//        if priceStackview.isHidden == true {
//            SelectedValue = true
//                       let data: [String:Any] = ["check": SelectedValue,"CatName" : lblCategory.text!] as [String:Any]
//                              self.dismiss(animated: true, completion: nil)
//                              NotificationCenter.default.post(name: Notification.Name("Search"), object: nil, userInfo: data)
//
//        }
        let data: [String:Any] = ["prokm": prokm, "from": fromPriceTxt.text ?? "", "to": toPriceTxt.text ?? ""]
        NotificationCenter.default.post(name: Notification.Name("DetailText"), object: nil, userInfo: data)
        
    }
    
    
    
    @IBAction func CategoryAction(_ sender: Any) {
        let vc = SelectCategoryViewController.instance(.newAdTab) as! SelectCategoryViewController
        vc.modalPresentationStyle = .fullScreen
        vc.MoveBack=true
        self.present(vc, animated: true, completion: nil)
        vc.callBack = { (SelectedText: String,SelectedId:String,SelectedSubCat: [Subcategory],  returnValue: Bool) in
            self.SelectedValue = returnValue
            
            self.dicdata = SelectedSubCat
            self.lblCategory.text=SelectedText
            
            if self.SelectedValue == true {
                self.lblSubCategory.text = "Choose Sub Category".localized()
                self.lblprice.isHidden = true
                self.priceStackview.isHidden = true
            } else {
                self.lblSubCategory.text = self.selectdText
                self.lblprice.isHidden = false
                self.priceStackview.isHidden = false
            }
            
            
            let data: [String:Any] = ["CatID": SelectedId]
            NotificationCenter.default.post(name: Notification.Name("CatID"), object: nil, userInfo: data)
            
            self.tableview.reloadData()
        }
    }
    
    @IBAction func SubcategoryAction(_ sender: Any) {
        let vc = SelectSubCategoryViewController.instance(.newAdTab) as! SelectSubCategoryViewController
        vc.modalPresentationStyle = .fullScreen
        
        for i in 0...(ArrCategorylist?.data?.count ?? 0) - 1{
            if lblCategory.text == ArrCategorylist?.data?[i].title {
            dicdata = ArrCategorylist?.data?[i].subcategory ?? []
                vc.dic = dicdata
            }
        }
        
        vc.MoveBack=true
        self.present(vc, animated: true, completion: nil)
        vc.callBack = { [self] (SelectedText: String,SelectedId:String,returnBool: Bool) in
            self.Subcatid=SelectedId
            self.SelectedValue = returnBool
            self.selectdText = SelectedText
            
            if self.SelectedValue == true {
                self.lblSubCategory.text = "Choose Sub Category".localized()
                self.lblprice.isHidden = true
                self.priceStackview.isHidden = true
            } else {
                self.lblSubCategory.text = self.selectdText
                self.lblprice.isHidden = false
                self.priceStackview.isHidden = false
            }
            
            
            self.SubCategoryCallBack?(SelectedId)
            self.getFilterData(SubCatid: SelectedId)
            
            
        }
        
        
    }
    
    
    
    
    
    @objc func getValue(notification: Notification) {
        getStr = (notification.userInfo!["SelectedValue"]! as! String)
        getselectedindex=(notification.userInfo!["selectedvalueindex"]! as! Int)
        getselecteid = (notification.userInfo!["SelectedValueId"]! as! Int)
        getIndex = (notification.userInfo!["Index"]! as! Int)
        if index == getIndex {
            listArray?.data?[getIndex].selectedtext = getStr
            listArray?.data?[getIndex].selectedid = getselecteid
            for i in 0..<(listArray?.data?[getIndex].dataItams?.count)!{
             listArray?.data?[getIndex].dataItams?[i].Selectedid=nil
            }
            listArray?.data?[getIndex].dataItams?[getselectedindex ?? 0].Selectedid=getselecteid
            
            let fieldLable = listArray?.data?[getIndex].fieldName ?? ""
            
            for i in 0...(listArray?.data?.count ?? 0)-1{
                //                let cell = tableView(tableview, cellForRowAt: IndexPath(row: i, section: 0)) as! AddMoreTbleCell
                
                if listArray?.data?[i].fieldName == "ad_type" {
                    adtype=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "pro_type" {
                    protype=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "pro_condition" {
                    procondition=listArray?.data?[i].selectedid ?? 0
                }
                else  if listArray?.data?[i].fieldName == "pro_guaranty" {
                    proguaranty=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "city" {
                    city=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "pro_model" {
                    promodal=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "pro_sim"{
                    prosim=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "pro_capacity"{
                    procapicity=listArray?.data?[i].selectedid ?? 0
                }
                else if listArray?.data?[i].fieldName == "pro_camera"{
                    procamera=listArray?.data?[i].selectedid ?? 0
                }
                
                
            }
            
            let data: [String:Any] = ["adtype": adtype, "protype": protype, "procondition": procondition, "proguaranty": proguaranty, "city": city, "subCatId": Subcatid ?? "", "catId": CategoryId ?? "", "promodal": promodal,"procamera":procamera,"procapicity":procapicity,"prosim":prosim]
            
            
            NotificationCenter.default.post(name: Notification.Name("Detail"), object: nil, userInfo: data)
            
        }
        
        
        
        //  idArray.append(id)
        
        
        tableview.reloadData()
        
    }
}

extension DetailFilterMenuVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        listArray?.data?[textField.tag].selectedtext = textField.text ?? ""
        tableview.reloadData()
    }
}

extension DetailFilterMenuVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SelectedValue == true {
            return 0
        } else {
            return listArray?.data?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFilterTableCell", for: indexPath) as! DetailFilterTableCell
        cell.lblFeildPlaceholder.delegate = self
        cell.lblFeildPlaceholder.tag = indexPath.row
        
        cell.lblFeildLable.text = listArray?.data?[indexPath.row].fieldLabel ?? ""
        hidden = listArray?.data?[indexPath.row].fieldType ?? ""
        location = listArray?.data?[indexPath.row].fieldName ?? ""
        
        if listArray?.data?[indexPath.row].selectedtext == "" {
            cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
        } else {
            cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
        }
        
        if listArray?.data?[indexPath.row].fieldType == "input" {
            cell.lblFeildPlaceholder.keyboardType = .asciiCapableNumberPad
            if  cell.lblFeildPlaceholder.text == listArray?.data?[indexPath.row].fieldPlaceholder ?? "" {
                cell.lblFeildPlaceholder.text = ""
                cell.lblFeildPlaceholder.placeholder = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
            } else {
                cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
            }
            cell.ClickImg.isHidden=true
            cell.placeholderView.isHidden = true
        } else {
            cell.placeholderView.isHidden = false
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hidden == "hidden" || location == "location"{
            return 0
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if listArray?.data?[indexPath.row].fieldLabel != "input" {
            if listArray?.data?[indexPath.row].fieldName != "location" {
                let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
                vc.dic = listArray?.data?[indexPath.row].dataItams ?? []
                
                //vc.dicId = listArray?.data?[indexPath.row].selectedid ?? 0
                vc.fieldLabel = listArray?.data?[indexPath.row].fieldLabel ?? ""
                if listArray?.data?[indexPath.row].selectedtext == "" {
                    vc.fieldPlaceholder = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
                } else {
                    vc.fieldPlaceholder = listArray?.data?[indexPath.row].selectedtext ?? ""
                }
                vc.index = indexPath.row
                index = indexPath.row
                vc.modalPresentationStyle = .fullScreen
                vc.Moveback = true
                self.present(vc, animated: true, completion: nil)
                
                
            } else {
                index = indexPath.row
                
                let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
                vc.index = indexPath.row
                vc.bool = true
                self.show(vc, sender: nil)
            }
            
        }else{
            index = indexPath.row
            
            let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
            vc.index = indexPath.row
            vc.bool = true
            self.show(vc, sender: nil)
        }
        
        //        let data: [String:Any] = ["dic": listArray?.data?[indexPath.row].dataItams ?? [], "Value": listArray?.data?[indexPath.row].fieldLabel ?? ""]
        //        NotificationCenter.default.post(name: Notification.Name("Data"), object: nil, userInfo: data)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        //        let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
        //        vc.dic = listArray?.data?[indexPath.row].dataItams ?? []
        //        vc.strSelectedValue = listArray?.data?[indexPath.row].fieldLabel ?? ""
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailFilterMenuVC{
    
    func GetCategoryList(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: GetCategoryListurl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: GetCategoryListModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrCategorylist = resModel
                
//                if (self.ArrCategorylist?.data?.count ?? 0) > 0 {
//                    for i in 0 ... (self.ArrCategorylist?.data?.count ?? 0)-1 {
//                        if self.MainCatName == self.ArrCategorylist?.data?[i].title {
//                            let catTitle = self.ArrCategorylist?.data?[i].title ?? ""
//
//
//                            for j in 0 ... (self.ArrCategorylist?.data?[i].subcategory?.count ?? 0)-1 {
//                                if self.Subcatid == self.ArrCategorylist?.data?[i].subcategory?[j].id {
//                                 self.dicdata = self.ArrCategorylist?.data?[0].subcategory ?? []
//                                }
//                            }
//
//                        }
//                    }
//                }
                
                                if ((self.ArrCategorylist?.data?[0].subcategory) != nil) {
                                    self.dicdata = self.ArrCategorylist?.data?[0].subcategory ?? []
                                }
                
            }else{
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
    
    
    func getFilterData(SubCatid: String){
        let dictParam = ["sub_cat": SubCatid]
        
        
        print(dictParam)
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetOptionList, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SlideListModal.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(ResponseJson)
            if stCode == 200{
                self.listArray = resModel
                self.tableview.reloadData()
            }else{
                self.tableview.reloadData()
                
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
//import UIKit
//class DetailFilterTableCell: UITableViewCell {
//    @IBOutlet weak var ClickImg: UIImageView!
//    @IBOutlet weak var lblFeildLable: UILabel!
//    @IBOutlet weak var lblFeildPlaceholder: UITextField!
//    @IBOutlet weak var placeholderView: UIView!
//
//}
//class DetailFilterMenuVC: UIViewController {
//    @IBOutlet weak var tableview: UITableView!
//    @IBOutlet weak var lblCategory: UILabel!
//    @IBOutlet weak var lblSubCategory: UILabel!
//    @IBOutlet weak var fromPriceTxt: UITextField!
//    @IBOutlet weak var toPriceTxt: UITextField!
//
//
//    var Subcatid:String?
//    var Subcatname:String?
//    var MainCatName:String?
//    var CategoryId:String?
//    var selectCategory = ""
//
//    var ArrCategorylist:GetCategoryListModel?
//    var FilteredData:GetCategoryListModel?
//    var dicdata = [Subcategory]()
//
//    var listArray: SlideListModal?
//    var index = Int()
//    var getIndex = Int()
//    var getStr = ""
//    var getselecteid = 0
//
//    var idArray = [Int]()
//    var feildNameArray = [String]()
//
//    var adtype=0
//    var protype=0
//    var procondition=0
//    var proguaranty=0
//    var city=0
//    var promodal=0
//    var prokm=""
//
//
//    var location = ""
//    var hidden = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        GetCategoryList()
//        getFilterData()
//        lblSubCategory.text = Subcatname
//        lblCategory.text=MainCatName
//
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.getValue(notification:)), name: Notification.Name("Identifier"), object: nil)
//
//    }
//
//    @IBAction func didTapDismis(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func didTapSearch(_ sender: Any) {
//        for i in 0...(listArray?.data?.count ?? 0)-1{
//                let cell = tableView(tableview, cellForRowAt: IndexPath(row: i, section: 0)) as! DetailFilterTableCell
//           if listArray?.data?[i].fieldName == "pro_km" {
//            prokm = cell.lblFeildPlaceholder.text ?? ""
//            }
//
//
//
//        }
//        self.dismiss(animated: true, completion: nil)
//        let data: [String:Any] = ["prokm": prokm, "from": fromPriceTxt.text ?? "", "to": toPriceTxt.text ?? ""]
//        NotificationCenter.default.post(name: Notification.Name("DetailText"), object: nil, userInfo: data)
//
//    }
//
//
//
//    @IBAction func CategoryAction(_ sender: Any) {
//       let vc = SelectCategoryViewController.instance(.newAdTab) as! SelectCategoryViewController
//               vc.modalPresentationStyle = .fullScreen
//               vc.MoveBack=true
//               self.present(vc, animated: true, completion: nil)
//        vc.callBack = { (SelectedText: String,SelectedId:String) in
//        self.lblCategory.text=SelectedText
//         }
//    }
//
//    @IBAction func SubcategoryAction(_ sender: Any) {
//        let vc = SelectSubCategoryViewController.instance(.newAdTab) as! SelectSubCategoryViewController
//               vc.modalPresentationStyle = .fullScreen
//               vc.MoveBack=true
//               self.present(vc, animated: true, completion: nil)
//        vc.callBack = { (SelectedText: String,SelectedId:String) in
//            self.Subcatid=SelectedId
//        self.lblSubCategory.text=SelectedText
//            self.getFilterData()
//
//         }
//    }
//
//
//    func GetCategoryList(){
//
//        let dictParam = ["":""]
//        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: GetCategoryListurl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: GetCategoryListModel.self, success: { (ResponseJson, resModel, st) in
//            let stCode = ResponseJson["status_code"].int
//            let strMessage = ResponseJson["message"].string
//            if stCode == 200{
//                self.ArrCategorylist = resModel
//                self.FilteredData=resModel
//            }else{
//               self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
//                self.dismiss(animated: true, completion: nil)
//                })
//            }
//        }) { (stError) in
//            self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//
//
//    @objc func getValue(notification: Notification) {
//          getStr = (notification.userInfo!["SelectedValue"]! as! String)
//
//           getselecteid = (notification.userInfo!["SelectedValueId"]! as! Int)
//          getIndex = (notification.userInfo!["Index"]! as! Int)
//          if index == getIndex {
//              listArray?.data?[getIndex].selectedtext = getStr
//              listArray?.data?[getIndex].selectedid = getselecteid
//              let fieldLable = listArray?.data?[getIndex].fieldName ?? ""
//
//            for i in 0...(listArray?.data?.count ?? 0)-1{
////                let cell = tableView(tableview, cellForRowAt: IndexPath(row: i, section: 0)) as! AddMoreTbleCell
//
//                if listArray?.data?[i].fieldName == "ad_type" {
//                    adtype=listArray?.data?[i].selectedid ?? 0
//                }
//               else if listArray?.data?[i].fieldName == "pro_type" {
//                    protype=listArray?.data?[i].selectedid ?? 0
//                }
//               else if listArray?.data?[i].fieldName == "pro_condition" {
//                    procondition=listArray?.data?[i].selectedid ?? 0
//                }
//              else  if listArray?.data?[i].fieldName == "pro_guaranty" {
//                    proguaranty=listArray?.data?[i].selectedid ?? 0
//                }
//               else if listArray?.data?[i].fieldName == "city" {
//                    city=listArray?.data?[i].selectedid ?? 0
//                }
//               else if listArray?.data?[i].fieldName == "pro_model" {
//                    promodal=listArray?.data?[i].selectedid ?? 0
//                }
//
//
//            }
//
//            let data: [String:Any] = ["adtype": adtype, "protype": protype, "procondition": procondition, "proguaranty": proguaranty, "city": city, "subCatId": Subcatid ?? "", "catId": CategoryId ?? "", "promodal": promodal]
//            NotificationCenter.default.post(name: Notification.Name("Detail"), object: nil, userInfo: data)
//
//        }
//
//
//
//            //  idArray.append(id)
//
//              tableview.reloadData()
//
//      }
//}
//
//extension DetailFilterMenuVC: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        listArray?.data?[textField.tag].selectedtext = textField.text ?? ""
//        tableview.reloadData()
//    }
//}
//
//extension DetailFilterMenuVC: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listArray?.data?.count ?? 0
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFilterTableCell", for: indexPath) as! DetailFilterTableCell
//        cell.lblFeildPlaceholder.delegate = self
//        cell.lblFeildPlaceholder.tag = indexPath.row
//
//        cell.lblFeildLable.text = listArray?.data?[indexPath.row].fieldLabel ?? ""
//        hidden = listArray?.data?[indexPath.row].fieldType ?? ""
//        location = listArray?.data?[indexPath.row].fieldName ?? ""
//
//        if listArray?.data?[indexPath.row].selectedtext == "" {
//            cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
//        } else {
//            cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
//        }
//
//        if listArray?.data?[indexPath.row].fieldType == "input" {
//            if  cell.lblFeildPlaceholder.text == listArray?.data?[indexPath.row].fieldPlaceholder ?? "" {
//                cell.lblFeildPlaceholder.text = ""
//                cell.lblFeildPlaceholder.placeholder = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
//            } else {
//                cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
//            }
//            cell.ClickImg.isHidden=true
//            cell.placeholderView.isHidden = true
//        } else {
//            cell.placeholderView.isHidden = false
//        }
//
//
//
//            return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if hidden == "hidden" || location == "location"{
//            return 0
//        } else {
//            return 100
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if listArray?.data?[indexPath.row].fieldLabel != "KM" {
//            if listArray?.data?[indexPath.row].fieldName != "location" {
//                let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
//                vc.dic = listArray?.data?[indexPath.row].dataItams ?? []
//                vc.dicId = listArray?.data?[indexPath.row].selectedid ?? 0
//                vc.fieldLabel = listArray?.data?[indexPath.row].fieldLabel ?? ""
//                if listArray?.data?[indexPath.row].selectedtext == "" {
//                    vc.fieldPlaceholder = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
//                } else {
//                    vc.fieldPlaceholder = listArray?.data?[indexPath.row].selectedtext ?? ""
//                }
//                vc.index = indexPath.row
//                index = indexPath.row
//                vc.modalPresentationStyle = .fullScreen
//                vc.Moveback = true
//                self.present(vc, animated: true, completion: nil)
//
//
//            } else {
//                index = indexPath.row
//
//                let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
//                vc.index = indexPath.row
//                vc.bool = true
//                self.show(vc, sender: nil)
//            }
//
//        }
//
////        let data: [String:Any] = ["dic": listArray?.data?[indexPath.row].dataItams ?? [], "Value": listArray?.data?[indexPath.row].fieldLabel ?? ""]
////        NotificationCenter.default.post(name: Notification.Name("Data"), object: nil, userInfo: data)
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//
////        let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
////        vc.dic = listArray?.data?[indexPath.row].dataItams ?? []
////        vc.strSelectedValue = listArray?.data?[indexPath.row].fieldLabel ?? ""
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension DetailFilterMenuVC{
//    func getFilterData(){
//        let dictParam = ["sub_cat":"\(Subcatid ?? "")"]
////        let dictParam = ["sub_cat":"66"]
//
//        print(dictParam)
//            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetOptionList, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SlideListModal.self, success: { (ResponseJson, resModel, st) in
//                let stCode = ResponseJson["status_code"].int
//                let strMessage = ResponseJson["message"].string
//                if stCode == 200{
//                    self.listArray = resModel
//                    self.tableview.reloadData()
//                }else{
//                    self.tableview.reloadData()
//
//                   self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
//                    self.dismiss(animated: true, completion: nil)
//                    })
//                }
//            }) { (stError) in
//                self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
//                    self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//}
