//
//  AddTagListViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//

import UIKit

protocol ViewStrTagDelegate {
    func chooseValue(strValue: String)
}

class AddTagListViewController: UIViewController {
    

    @IBOutlet weak var categoryListTableView: UITableView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    @IBOutlet weak var btncontinue: DesignableButton!
    
    
    
    var callBack: ((_ dicvalue:Bool)-> Void)?
    
    var selectedIndex = -1
    
    var chooseViewFrom = ChooseViewFrom.category
    
    var Moveback=false
    
//    var viewFrom = ViewFrom.tag
    var arrTag = [CategoryModel]()
    var arrGoverence = [CategoryModel]()
    var arrMaterial = [CategoryModel]()
    var arrPattern = [CategoryModel]()
    var arrScarcity = [CategoryModel]()
    var arrCondition = [CategoryModel]()
    var arrProductionYear = [CategoryModel]()
    var delegate: ViewStrTagDelegate?
    
    var fieldLabel = ""
    var fieldPlaceholder = ""
    
    var index = Int()
    var dic = [FieldData]()
    var dicId:Int?
    var strSelectedValue = ""
    var selectedString = ""
    var selectedCateId = 0
    var istrue=false
    var boolvalue=""
    var selectindexvalue:Int?
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        istrue=false
        lblHeaderTitle.text = fieldLabel
        btncontinue.setTitle("Continue".localized(), for: .normal)
        
//        if viewFrom == .tag {
//            lblHeaderTitle.text = "Add Tag"
//            setTag()
//        }else if viewFrom == .goverenence {
//            lblHeaderTitle.text = "Goverenence"
//            setMaterial()
//        }else if viewFrom == .material {
//            lblHeaderTitle.text = "Choose The Material"
//            setMaterial()
//        }else if viewFrom == .pattern {
//            lblHeaderTitle.text = "Choose The Pattern"
//            setPattern()
//        }else if viewFrom == .scarcity {
//            lblHeaderTitle.text = "Choose Scarcity"
//            setScarcity()
//        }else if viewFrom == .codition {
//            lblHeaderTitle.text = "Choose Condition"
//            setCondition()
//        }else if viewFrom == .productionYear {
//            lblHeaderTitle.text = "Choose Production Year"
//            setProductionYear()
//        }
    }
    
//    func setTag() {
//        arrTag.append(CategoryModel(categoryName: "Sale"))
//        arrTag.append(CategoryModel(categoryName:"Rent"))
//        arrTag.append(CategoryModel(categoryName:"Required"))
//        arrTag.append(CategoryModel(categoryName:"Accesories"))
//        arrTag.append(CategoryModel(categoryName:"Exchange"))
//        arrTag.append(CategoryModel(categoryName:"Service"))
//    }
//
//    func setGoverence() {
//        arrTag.append(CategoryModel(categoryName:"Accesories"))
//        arrTag.append(CategoryModel(categoryName:"Exchange"))
//        arrTag.append(CategoryModel(categoryName:"Service"))
//    }
//
//    func setMaterial() {
//        arrMaterial.append(CategoryModel(categoryName: "Metal"))
//        arrMaterial.append(CategoryModel(categoryName:"Glass"))
//        arrMaterial.append(CategoryModel(categoryName:"Wooden"))
//        arrMaterial.append(CategoryModel(categoryName:"Paper"))
//        arrMaterial.append(CategoryModel(categoryName:"Pottery"))
//        arrMaterial.append(CategoryModel(categoryName:"Mosaic"))
//    }
//    func setPattern() {
//        arrPattern.append(CategoryModel(categoryName: "Smooth"))
//        arrPattern.append(CategoryModel(categoryName:"Embossed"))
//        arrPattern.append(CategoryModel(categoryName:"Draw"))
//        arrPattern.append(CategoryModel(categoryName:"Other"))
//    }
//
//    func setScarcity() {
//        arrScarcity.append(CategoryModel(categoryName: "Rare"))
//        arrScarcity.append(CategoryModel(categoryName:"Not Rare"))
//    }
//
//    func setCondition() {
//        arrCondition.append(CategoryModel(categoryName: "Excellent"))
//        arrCondition.append(CategoryModel(categoryName:"Damaged"))
//        arrCondition.append(CategoryModel(categoryName:"Restoration"))
//    }
//
//    func setProductionYear() {
//        arrProductionYear.append(CategoryModel(categoryName: "B.C"))
//        arrProductionYear.append(CategoryModel(categoryName: "0-500"))
//        arrProductionYear.append(CategoryModel(categoryName: "1100-1150"))
//        arrProductionYear.append(CategoryModel(categoryName: "1201-1300"))
//        arrProductionYear.append(CategoryModel(categoryName: "1301-1400"))
//        arrProductionYear.append(CategoryModel(categoryName: "1401-1500"))
//        arrProductionYear.append(CategoryModel(categoryName: "1501-1600"))
//        arrProductionYear.append(CategoryModel(categoryName: "1601-1700"))
//        arrProductionYear.append(CategoryModel(categoryName: "1701-1800"))
//        arrProductionYear.append(CategoryModel(categoryName: "1801-1900"))
//        arrProductionYear.append(CategoryModel(categoryName: "1901-2000"))
//        arrProductionYear.append(CategoryModel(categoryName: "2001-2100"))
//
//    }
//
    
    @IBAction func actionBackButton(_ sender: Any) {
        if Moveback == true {
            self.dismiss(animated: true, completion: nil)
        }else{
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionContinue(_ sender: Any) {

          if selectindexvalue != nil {
            let data: [String:Any] = ["SelectedValue": selectedString,"SelectedValueId": selectedCateId, "Index": index,"boolvalue":boolvalue,"selectedvalueindex":selectindexvalue ?? 0]
                    if Moveback == true {
                         self.dismiss(animated: true, completion: nil)
                         NotificationCenter.default.post(name: Notification.Name("Identifier"), object: nil, userInfo: data)
                     } else {
                         self.navigationController?.popViewController(animated: true)
                         NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: data)
                     }
                     
                 }else {
                     self.showCustomPopupView(altMsg: "Please Select One".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                         self.dismiss(animated: true, completion: nil)
                     }
                     
                 }
////  }
        
    }
    
}


extension AddTagListViewController : UITableViewDataSource , UITableViewDelegate,UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectCategoryTableViewCell.self)) as! SelectCategoryTableViewCell
        cell.lblName.text = dic[indexPath.row].title
    
        
        if dic[indexPath.row].Selectedid == dic[indexPath.row].id {
            cell.img.image = #imageLiteral(resourceName: "Checked")
            selectedString = dic[indexPath.row].title
            selectedCateId=dic[indexPath.row].id
            selectindexvalue=indexPath.row
            dicId=selectedCateId
            boolvalue="true"
            //cell.lblName.textColor = .red
        }else{
            cell.img.image = #imageLiteral(resourceName: "empty_circle")
        cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
        }
        
        
//        // change  id = 0 to 1 title = "no guaranty"
//        if(selectindexvalue == dic[indexPath.row].id && istrue == false)
//        {
//            cell.img.image = #imageLiteral(resourceName: "Checked")
//            cell.lblName.textColor = .red
//            istrue=false
//        }
//        else{
//
//        cell.img.image = #imageLiteral(resourceName: "empty_circle")
//        cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
//        if chooseViewFrom == .category {
//            if selectedIndex == indexPath.row {
//                cell.img.image = #imageLiteral(resourceName: "Checked")
//                cell.lblName.textColor = .red
//                istrue=true
//            } else {
//
//                cell.img.image = #imageLiteral(resourceName: "empty_circle")
//                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
//        }
//        }else {
//
//            if selectedIndex == indexPath.row {
//                cell.img.image = #imageLiteral(resourceName: "Checked")
//                cell.lblName.textColor = .red
//                istrue=true
//            } else {
//
//                cell.img.image = #imageLiteral(resourceName: "empty_circle")
//                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
//            }
//        }
//        }
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedString = dic[indexPath.row].title
        selectedCateId=dic[indexPath.row].id
        selectindexvalue=indexPath.row
        dicId=selectedCateId
        boolvalue="true"
        
        for i in 0...dic.count-1{
         dic[i].Selectedid = nil
        }
        dic[indexPath.row].Selectedid = dic[indexPath.row].id
        
        DispatchQueue.main.async {
            self.categoryListTableView.reloadData()
        }
        
        
    }
}
    



