//
//  AddMoreDetailViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 01/07/21.
//

import UIKit
import Localize_Swift

class AddMoreTbleCell: UITableViewCell {
    
    
    
    @IBOutlet weak var Btndidtap: UIButton!
    @IBOutlet weak var Btncross: UIButton!
    @IBOutlet weak var ClickImg: UIImageView!
    @IBOutlet weak var lblFeildLable: UILabel!
    @IBOutlet weak var lblFeildPlaceholder: UITextField!
    // @IBOutlet weak var placeholderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


class AddMoreDetailViewController: UIViewController {
    
    @IBOutlet weak var lblsubcategorieshint: UILabel!
    @IBOutlet weak var lblcategorieshint: UILabel!
    @IBOutlet weak var lbladdmoretext: UILabel!
    @IBOutlet weak var ImgSubArrow: UIImageView!
    @IBOutlet weak var ImgCatArrow: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    
    @IBOutlet weak var Btnsubcategory: UIButton!
    @IBOutlet weak var Btncategory: UIButton!
    @IBOutlet weak var btnback: UIButton!
    
    @IBOutlet weak var btncontinue: UIButton!
    
    
    var edittext=""
    
    var Subcatid:String?
    var Subcatname:String?
    var CategoryId:String?
    var selectCategory = ""
    
    var listArray: SlideListModal?
    var editArray: EditDetailModal?
    
    var matchArray: SlideListModal?
    
    var idArray = [Int]()
    var feildNameArray = [String]()
    
    
    
    var index = Int()
    var getIndex = Int()
    var getStr = ""
    var getselecteid=0
    var getboolvalue=""
    var getselectedindex:Int?
    
    var langEng = ""
    var langKur = ""
    var langAr = ""
    
    var adtype=0
    var protype=0
    var procondition=0
    var proguaranty=0
    var city=0
    var proKm=""
    var promodal=0
    var procamera=0
    var procapicity=0
    var prosim=0
    
    
    var proquality=0
    var progear=0
    var pronoroom=""
    
    var profurnishing=0
    var proarea=""
    var progender=0
    var prounite=0
    var promaterial=0
    
    var price=""
    var entitle=""
    var endescription=""
    var artitle=""
    var ardescription=""
    var kutitle=""
    var kudescription=""
    
    var Arrimagevalue = [[String:Any]]()
    
    var lat = Double()
    var long = Double()
    var locationtext=""
    var boolValue=false
    
    var boolAddress=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden=true
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        if boolValue == true{
            ImgCatArrow.isHidden=true
            ImgSubArrow.isHidden=true
            let edithint="Edit".localized()
            lbladdmoretext.text="\(edithint) \(edittext)"
        }else{
            ImgCatArrow.isHidden=false
            ImgSubArrow.isHidden=false
            lbladdmoretext.text="Add More Details (Step 5)".localized()
        }
        lblCategory.text = selectCategory
        lblSubCategory.text = Subcatname
        
        getFilterData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.GetLocation(notification:)), name: Notification.Name("LOCATION"), object: nil)
        Settext()
        
    }
    
    
    
    func Settext(){
        btncontinue.setTitle("Continue".localized(), for: .normal)
        lblsubcategorieshint.text="Sub Categories".localized()
        lblcategorieshint.text="Categories".localized()
    }
    
    
    // MARK: - Button Action
    @IBAction func didTapCategoryButton(_ sender: Any) {
        if boolValue == true{
            Btncategory.isUserInteractionEnabled=false
        }else{
            Btncategory.isUserInteractionEnabled=true
            self.PopToSpecificController(vcMove:SelectCategoryViewController.self)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSubCategoryButton(_ sender: Any) {
        if boolValue == true{
            Btnsubcategory.isUserInteractionEnabled=false
        }else{
            Btnsubcategory.isUserInteractionEnabled=true
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        getStr = (notification.userInfo!["SelectedValue"]! as! String)
        getboolvalue = (notification.userInfo!["boolvalue"]! as! String)
        getselecteid = (notification.userInfo!["SelectedValueId"]! as! Int)
        getIndex = (notification.userInfo!["Index"]! as! Int)
        getselectedindex=(notification.userInfo!["selectedvalueindex"]! as! Int)
        if index == getIndex {
            listArray?.data?[getIndex].selectedtext = getStr
            listArray?.data?[getIndex].selectedid = getselecteid
            
            for i in 0..<(listArray?.data?[getIndex].dataItams?.count)!{
                listArray?.data?[getIndex].dataItams?[i].Selectedid=nil
            }
            listArray?.data?[getIndex].dataItams?[getselectedindex ?? 0].Selectedid=getselecteid
            let fieldLable = listArray?.data?[getIndex].fieldName ?? ""
            //  idArray.append(id)
            feildNameArray.append(fieldLable)
            tableview.reloadData()
        }
    }
    
    @objc func GetLocation(notification: Notification) {
        getStr = (notification.userInfo!["SelectedValue"]! as! String)
        locationtext=getStr
        getIndex = (notification.userInfo!["Index"]! as! Int)
        lat = (notification.userInfo!["lati"]! as! Double)
        print(lat)
        long = (notification.userInfo!["long"]! as! Double)
        print(long)
        boolAddress=(notification.userInfo!["booleanvalue"]! as! Bool)
        if index == getIndex {
            listArray?.data?[getIndex].selectedtext = getStr
           tableview.reloadData()
        }
    }
    
    @objc func SetCross(sender:UIButton){
        //sender.tag = index
        let cell = tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as!AddMoreTbleCell
        cell.lblFeildPlaceholder.placeholder = ""
        cell.lblFeildPlaceholder.text=""
        cell.Btncross.isHidden=true
        getStr=""
        lat = Double()
        long = Double()
        locationtext=""
        boolAddress=false
        getIndex=Int()
        listArray?.data?[sender.tag].selectedtext=""
        listArray?.data?[sender.tag].selectedid=0
        cell.lblFeildPlaceholder.attributedPlaceholder = NSAttributedString(string: "Select the Current location",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        //cell.lblFeildPlaceholder.placeholder = listArray?.data?[sender.tag].fieldPlaceholder
    }
    
    
    
    @objc func Didtap(sender:UIButton){
        if listArray?.data?[sender.tag].fieldType != "input"  {
            if listArray?.data?[sender.tag].fieldName != "location" {
                let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
                
                vc.dic = listArray?.data?[sender.tag].dataItams ?? []
                
                vc.fieldLabel = listArray?.data?[sender.tag].fieldLabel ?? ""
                
                if listArray?.data?[sender.tag].selectedtext == "" {
                    vc.fieldPlaceholder = listArray?.data?[sender.tag].fieldPlaceholder ?? ""
                } else {
                    vc.fieldPlaceholder = listArray?.data?[sender.tag].selectedtext ?? ""
                }
                
                vc.index = sender.tag
                index = sender.tag
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
                
            else {
                index = sender.tag
                let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
                vc.index = sender.tag
                vc.bool = true
                self.show(vc, sender: nil)
                
            }
            
            
        }else{
            let cell = tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as!AddMoreTbleCell
            if listArray?.data?[sender.tag].fieldPlaceholder == "Select the Current location" {
                if(cell.lblFeildPlaceholder.placeholder == listArray?.data?[sender.tag].fieldPlaceholder && getStr=="")
                {
                    index = sender.tag
                    let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
                    vc.index = sender.tag
                    vc.bool = true
                    self.show(vc, sender: nil)
                }else if
                    cell.lblFeildPlaceholder.placeholder == listArray?.data?[sender.tag].fieldPlaceholder && getStr != ""{
                    index = sender.tag
                    let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
                    vc.index = sender.tag
                    vc.bool = true
                    self.show(vc, sender: nil)
                    
                }
                else
                {
                    cell.Btncross.isHidden=true
                    // cell.placeholderView.isHidden = false
                    cell.lblFeildPlaceholder.placeholder = ""
                    cell.lblFeildPlaceholder.text=""
                    cell.lblFeildPlaceholder.placeholder = listArray?.data?[sender.tag].fieldPlaceholder
                    getStr=""
                }
                
            }
            else
            {
                if listArray?.data?[sender.tag].fieldType == "input" {
                    cell.lblFeildPlaceholder.keyboardType = .asciiCapableNumberPad
                    cell.Btncross.isHidden=true
                    cell.Btndidtap.isUserInteractionEnabled=false
                }else{
                    self.index = sender.tag
                    let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
                    vc.index = sender.tag
                    vc.bool = true
                    self.show(vc, sender: nil)
                }
            }
            
            
        }
        
    }
    
    
    @IBAction func didTapContinue(_ sender: Any) {
        
        var Isblank=false
        self.tableview.reloadData()
        for i in 0...(listArray?.data?.count ?? 0)-1{
            let cell = tableView(tableview, cellForRowAt: IndexPath(row: i, section: 0)) as! AddMoreTbleCell
            if cell.lblFeildPlaceholder.text == listArray?.data?[i].fieldPlaceholder && cell.lblFeildPlaceholder.text != "Select the Current location" {
                
                if listArray?.data?[i].fieldPlaceholder != "" {
                    self.showCustomPopupView(altMsg: (listArray?.data?[i].fieldPlaceholder ?? "") , alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                        self.dismiss(animated: true, completion: nil)
                        // self.tableview.reloadData()
                        //Isblank=true
                    }
                    return
                }
            }
            else if listArray?.data?[i].fieldType == "input"{
                if cell.lblFeildPlaceholder.text == ""
                {
                    self.showCustomPopupView(altMsg:listArray?.data?[i].fieldPlaceholder ?? "" , alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                        self.dismiss(animated: true, completion: nil)
                        return
                    }
                }
                
            }
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
            }else if listArray?.data?[i].fieldName == "pro_km"{
                proKm=cell.lblFeildPlaceholder.text ?? ""
            }else if listArray?.data?[i].fieldName == "pro_model"{
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
                
                
                
                
            else if listArray?.data?[i].fieldName == "pro_gender"{
                progender=listArray?.data?[i].selectedid ?? 0
            }
                
            else if listArray?.data?[i].fieldName == "pro_no_room"{
                pronoroom=cell.lblFeildPlaceholder.text ?? ""
            }
                
            else if listArray?.data?[i].fieldName == "pro_furnishing"{
                profurnishing=listArray?.data?[i].selectedid ?? 0
            }
                
            else if listArray?.data?[i].fieldName == "pro_gear"{
                progear=listArray?.data?[i].selectedid ?? 0
            }
                
            else if listArray?.data?[i].fieldName == "pro_area"{
                proarea=cell.lblFeildPlaceholder.text ?? ""
            }
                
            else if listArray?.data?[i].fieldName == "pro_no_room"{
                pronoroom=cell.lblFeildPlaceholder.text ?? ""
            }
            else if listArray?.data?[i].fieldName == "pro_unite"{
                prounite=listArray?.data?[i].selectedid ?? 0
            }
            else if listArray?.data?[i].fieldName == "pro_material"{
                promaterial=listArray?.data?[i].selectedid ?? 0
            }
            
            
            
            
            
            
            
            
            
            
        }
        
        let vc = AddPostViewController.instance(.newAdTab) as! AddPostViewController
        vc.lat = lat
        vc.long = long
        vc.prokm=proKm
        vc.procamera=procamera
        vc.procapicity=procapicity
        vc.prosim=prosim
        vc.categoryid=CategoryId ?? ""
        vc.subcategoryid=Subcatid ?? ""
        vc.location=locationtext
        vc.adtypeid=adtype
        vc.protypeid=protype
        vc.proconditionid=procondition
        vc.proguarantyid=proguaranty
        vc.cityid=city
        vc.promodal=promodal
        vc.langEng = langEng
        vc.langKur = langKur
        vc.langAr = langAr
        
        vc.proquality=proquality
        vc.progear=progear
        vc.pronoroom=pronoroom
        vc.profurnishing=profurnishing
        vc.proarea=proarea
        vc.progender=progender
        vc.prounite=prounite
        vc.promaterial=promaterial
        
        vc.price=editArray?.data?.price ?? ""
        vc.entitle=editArray?.data?.enTitle ?? ""
        vc.endescription=editArray?.data?.enDescription ?? ""
        vc.artitle=editArray?.data?.arTitle ?? ""
        vc.ardescription=editArray?.data?.arDescription ?? ""
        vc.kutitle=editArray?.data?.kuTitle ?? ""
        vc.kudescription=editArray?.data?.kuDescription ?? ""
        vc.boolValue = boolValue
        vc.productid=editArray?.data?.id ?? ""
        
        
        
        
        Arrimagevalue.removeAll()
        for i in 0..<(editArray?.data?.getGallery?.count ?? 0){
            let datadic = ["file_type":self.editArray?.data?.getGallery?[i].fileType ?? "","id":self.editArray?.data?.getGallery?[i].id ?? ""] as [String : Any]
            print(datadic)
            self.Arrimagevalue.append((datadic as [String : Any]))
        }
        vc.ArrSendData=Arrimagevalue
        vc.ArrGallery=editArray?.data?.getGallery ?? []
        print(vc.ArrGallery)
        self.show(vc, sender: nil)
        
        
    }
    
}

//MARK:- Add More Detail Controller
extension AddMoreDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMoreTbleCell", for: indexPath) as! AddMoreTbleCell
        
        if listArray?.data?[indexPath.row].fieldName == "location"{
            //
            cell.ClickImg.image=UIImage(named: "locationpath")
        }else{
            cell.ClickImg.image=UIImage(named: "right_arrow")
            
        }
        
        
        cell.lblFeildPlaceholder.delegate = self
        cell.lblFeildPlaceholder.tag = indexPath.row
        
        cell.lblFeildLable.text = listArray?.data?[indexPath.row].fieldLabel ?? ""
        
        cell.Btndidtap.tag=indexPath.row
        cell.Btndidtap.addTarget(self, action: #selector(Didtap(sender:)), for: .touchUpInside)
        cell.Btncross.tag=indexPath.row
        cell.Btncross.addTarget(self, action: #selector(SetCross(sender:)), for: .touchUpInside)
        
        if listArray?.data?[indexPath.row].selectedtext == "" {
            cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
        } else {
            cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
        }
        
        if listArray?.data?[indexPath.row].fieldType == "input" {
            //            cell.lblFeildPlaceholder.keyboardType = .asciiCapableNumberPad
            cell.Btncross.isHidden=true
            if  cell.lblFeildPlaceholder.text == listArray?.data?[indexPath.row].fieldPlaceholder ?? "" {
                cell.lblFeildPlaceholder.text = ""
                cell.lblFeildPlaceholder.placeholder = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
            } else {
                cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
            }
            
           
            if boolAddress == true || boolValue == true
            {
                if   cell.lblFeildPlaceholder.text != "" && listArray?.data?[indexPath.row].fieldName != "location" {
                    cell.Btncross.isHidden=true
                }
                else if cell.lblFeildPlaceholder.text != "" && listArray?.data?[indexPath.row].fieldName == "location"
                {
                    cell.Btncross.isHidden=false
                }
                else{
                    if cell.lblFeildPlaceholder.placeholder != listArray?.data?[indexPath.row].fieldPlaceholder
                    {
                        cell.Btncross.isHidden=false
                    }
                }
            }
            
            // cell.placeholderView.isHidden = tru
        } else {
             cell.Btncross.isHidden=true
            // cell.placeholderView.isHidden = false
        }
        
        if listArray?.data?[indexPath.row].fieldName == "location" {
            // cell.placeholderView.isHidden = false
            
            if listArray?.data?[indexPath.row].selectedtext == "" {
                cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
            } else {
                cell.lblFeildPlaceholder.text = listArray?.data?[indexPath.row].selectedtext ?? ""
            }
            
        }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listArray?.data?[indexPath.row].fieldType ?? "" == "hidden" {
            return 0
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMoreTbleCell", for: indexPath) as! AddMoreTbleCell
        //        if listArray?.data?[indexPath.row].fieldType != "input"  {
        //            if listArray?.data?[indexPath.row].fieldLabel != "KM" {
        //            if listArray?.data?[indexPath.row].fieldName != "location" {
        //                let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
        //
        //                vc.dic = listArray?.data?[indexPath.row].dataItams ?? []
        //
        //
        //
        //                vc.fieldLabel = listArray?.data?[indexPath.row].fieldLabel ?? ""
        //
        //                if listArray?.data?[indexPath.row].selectedtext == "" {
        //                    vc.fieldPlaceholder = listArray?.data?[indexPath.row].fieldPlaceholder ?? ""
        //                } else {
        //                    vc.fieldPlaceholder = listArray?.data?[indexPath.row].selectedtext ?? ""
        //                }
        //
        //                vc.index = indexPath.row
        //                index = indexPath.row
        //                self.navigationController?.pushViewController(vc, animated: true)
        //
        //            }
        //            }
        //            else {
        //                index = indexPath.row
        //                let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
        //                vc.index = indexPath.row
        //                vc.bool = true
        //                self.show(vc, sender: nil)
        //
        //            }
        //
        //
        //        }else{
        //            let cell = tableview.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as!AddMoreTbleCell
        //            if listArray?.data?[indexPath.row].fieldPlaceholder == "Select the Current location" {
        //                if(cell.lblFeildPlaceholder.placeholder == listArray?.data?[indexPath.row].fieldPlaceholder && getStr=="")
        //                {
        //                      index = indexPath.row
        //                    let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
        //                        vc.index = indexPath.row
        //                        vc.bool = true
        //                        self.show(vc, sender: nil)
        //                }else if
        //                    cell.lblFeildPlaceholder.placeholder == listArray?.data?[indexPath.row].fieldPlaceholder && getStr != ""{
        //                    index = indexPath.row
        //                    let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
        //                    vc.index = indexPath.row
        //                    vc.bool = true
        //                    self.show(vc, sender: nil)
        //
        //                }
        //                else
        //                {
        //                    cell.Btncross.isHidden=true
        //                    cell.placeholderView.isHidden = false
        //                    cell.lblFeildPlaceholder.placeholder = ""
        //                        cell.lblFeildPlaceholder.text=""
        //                    cell.lblFeildPlaceholder.placeholder = listArray?.data?[indexPath.row].fieldPlaceholder
        //                    getStr=""
        //                }
        //
        //            }
        //            else
        //            {
        //            index = indexPath.row
        //            let vc = AddressViewController.instance(.myAccountTab) as! AddressViewController
        //            vc.index = indexPath.row
        //            vc.bool = true
        //            self.show(vc, sender: nil)
        //            }
        //
        //
        //        }
        
    }
    
}

extension AddMoreDetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        listArray?.data?[textField.tag].selectedtext = textField.text ?? ""
        tableview.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}



extension AddMoreDetailViewController{
    func getFilterData(){
        let dictParam = ["sub_cat":"\(Subcatid ?? "")"]
        //        let dictParam = ["sub_cat":"66"]
        print(dictParam)
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetOptionList, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SlideListModal.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.listArray = resModel
                self.editedData()
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


extension AddMoreDetailViewController {
    func editedData(){
        tableview.reloadData()
        for i in 0...(listArray?.data?.count ?? 0)-1{
            if listArray?.data?[i].fieldName == "ad_type" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.adType ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        adtype = Int(editArray?.data?.adType ?? "") ?? 0
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_type" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proType ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        protype = Int(editArray?.data?.proType ?? "") ?? 0
                        
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_condition" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proCondition ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        procondition = Int(editArray?.data?.proCondition ?? "") ?? 0
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_guaranty" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proGuaranty ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        proguaranty = Int(editArray?.data?.proGuaranty ?? "") ?? 0
                    }
                }
            }else if listArray?.data?[i].fieldName == "city" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.city ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        city = Int(editArray?.data?.city ?? "") ?? 0
                        
                    }
                }
            }else if listArray?.data?[i].fieldName == "location" {
                listArray?.data?[i].selectedtext = editArray?.data?.location ?? ""
                locationtext = editArray?.data?.location ?? ""
                //                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                //                    let x = listArray?.data?[i]
                //                    if x?.dataItams?[j].id == Int(editArray?.data?.location ?? ""){
                //                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                //                    }
                //                }
            }else if listArray?.data?[i].fieldName == "pro_model" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proModel ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        promodal = Int(editArray?.data?.proModel ?? "") ?? 0
                    }
                }
            }else if listArray?.data?[i].fieldName == "pro_km" {
                listArray?.data?[i].selectedtext = editArray?.data?.proKM ?? ""
                proKm = editArray?.data?.proKM ?? ""
            }
            else if listArray?.data?[i].fieldName == "pro_no_room" {
                listArray?.data?[i].selectedtext = editArray?.data?.proNoRoom ?? ""
                pronoroom = editArray?.data?.proNoRoom ?? ""
            }
            else if listArray?.data?[i].fieldName == "pro_quality" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proQuality ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        proquality = Int(editArray?.data?.proQuality ?? "") ?? 0
                    }
                }
            }else if listArray?.data?[i].fieldName == "pro_gear" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proGear ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        progear = Int(editArray?.data?.proGear ?? "") ?? 0
                        
                    }
                }
            }else if listArray?.data?[i].fieldName == "pro_sim" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proSim ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        prosim = Int(editArray?.data?.proSim ?? "") ?? 0
                        
                    }
                }
            }else if listArray?.data?[i].fieldName == "pro_capacity" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proCapacity ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        procapicity = Int(editArray?.data?.proCapacity ?? "") ?? 0
                        
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_camera" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proCamera ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        procamera = Int(editArray?.data?.proCamera ?? "") ?? 0
                        
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_furnishing" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proFurnishing ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        profurnishing = Int(editArray?.data?.proFurnishing ?? "") ?? 0
                        
                    }
                }
                
            }else if listArray?.data?[i].fieldName == "pro_area" {
                listArray?.data?[i].selectedtext = editArray?.data?.proArea ?? ""
                proarea = editArray?.data?.proArea ?? ""
                
                //            } else if listArray?.data?[i].fieldName == "pro_area" {
                //                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                //                    let x = listArray?.data?[i]
                //                    if x?.dataItams?[j].id == Int(editArray?.data?.proArea ?? ""){
                //                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                //                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                //                        proarea = Int(editArray?.data?.proArea ?? "") ?? 0
                //
                //                    }
                //                }
            } else if listArray?.data?[i].fieldName == "pro_gender" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proGender ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        progender = Int(editArray?.data?.proGender ?? "") ?? 0
                        
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_unite" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proUnite ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        prounite = Int(editArray?.data?.proUnite ?? "") ?? 0
                        
                    }
                }
            } else if listArray?.data?[i].fieldName == "pro_material" {
                for j in 0...(listArray?.data?[i].dataItams?.count ?? 0 )-1 {
                    let x = listArray?.data?[i]
                    if x?.dataItams?[j].id == Int(editArray?.data?.proMaterial ?? ""){
                        listArray?.data?[i].selectedtext =  x?.dataItams?[j].title ?? ""
                        listArray?.data?[i].selectedid = x?.dataItams?[j].id ?? 0
                        
                    }
                }
            }
            else if listArray?.data?[i].fieldName == "lat" {
                lat =  Double(editArray?.data?.lat ?? "") ?? 0.0
            }
            else if listArray?.data?[i].fieldName == "long" {
                long =  Double(editArray?.data?.long ?? "") ?? 0.0
            }
            
            
            
        }
    }
}
