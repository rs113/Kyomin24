//
//  SelectCategoryViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//

//
//  SelectCategoryViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//

import UIKit
import Localize_Swift

protocol ViewSubCategoryDelegate {
    func chooseSubCategory(strSubCategory: String)
}

class SelectCategoryViewController: UIViewController{
    
   
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var categoryListTableView: UITableView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var ProductSearchbar: UISearchBar!
    
    var callBack: (( _ SelectedText: String, _ SelectedId: String,  _ SelectedSubCat: [Subcategory],  _ returnValue: Bool)-> Void)?
    var arrCategory = [CategoryModel]()
    var arrSubCategory = [CategoryModel]()
    var selectedIndex = ""
    var chooseViewFrom = ChooseViewFrom.category
    var selectedCategory = ""
    var selectedCategoryid=""
    var selectedSubCategory = ""
    
    var ArrCategorylist:GetCategoryListModel?
    var FilteredData:GetCategoryListModel?
    var dicdata = [Subcategory]()
    var type=""
    
    var MoveBack=false
    
    var delegate: ViewSubCategoryDelegate?
    
    var langEng = ""
    var langKurs = ""
    var langAr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(langEng)
        print(langKurs)
        print(langAr)
        if chooseViewFrom == .category {
            lblHeaderTitle.text = "Choose Category (Step 3)".localized()
        }else {
            lblHeaderTitle.text = "Choose SubCategory"
        }
        btncontinue.setTitle("Continue".localized(), for: .normal)
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        categoryListTableView.tableFooterView=UIView()
        //
        GetCategoryList()
        self.dismissKeyboard()
        ProductSearchbar.placeholder="Search".localized()
        ProductSearchbar.delegate=self
        ProductSearchbar.backgroundImage = UIImage()
        
        
    }
    
    
    
    
    func GetCategoryList(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetCategoryListurl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: GetCategoryListModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrCategorylist = resModel
                self.FilteredData=resModel
                self.categoryListTableView.reloadData()
            }else{
                self.categoryListTableView.reloadData()
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
    
    
    
    
    
    
    @IBAction func actionBackButton(_ sender: Any) {
        if MoveBack == true {
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("Back"), object: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        
        if chooseViewFrom == .category {
            if selectedIndex != "" {
                if MoveBack == true {
                    self.dismiss(animated: true, completion: nil)
                    self.callBack?(selectedCategory, selectedCategoryid, dicdata, true)
                }else{
                    let vc = SelectSubCategoryViewController.instance(.newAdTab) as! SelectSubCategoryViewController
                    vc.dic = dicdata
                    vc.selectCategory = selectedCategory
                    vc.selectCategoryid=selectedCategoryid
                    vc.langEng = langEng
                    vc.langKur = langKurs
                    vc.langAr = langAr
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                
                self.showCustomPopupView(altMsg: "Please Select Category".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
                //                Util.showAlertWithCallback("Alert", message: "Please Select Category", okStr: "Ok", cancelStr: "", isWithCancel: false)
                
            }
        }else {
            if selectedIndex != "" {
                delegate?.chooseSubCategory(strSubCategory: selectedSubCategory)
                self.navigationController?.popViewController(animated: true)
            }else {
                self.showCustomPopupView(altMsg: "Please Select SubCategory".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(SelectCategoryViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}


//MARK: - UITableViewDataSource And Delegate
extension SelectCategoryViewController : UITableViewDataSource , UITableViewDelegate,UISearchBarDelegate {
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if chooseViewFrom == .category {
        //            return arrCategory.count
        //        }else {
        //            return arrSubCategory.count
        //        }
        return FilteredData?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectCategoryTableViewCell.self)) as! SelectCategoryTableViewCell
        
        cell.lblName.text = FilteredData?.data?[indexPath.row].title
        
        if chooseViewFrom == .category {
            if selectedIndex == FilteredData?.data?[indexPath.row].id ?? "" {
                cell.img.image = #imageLiteral(resourceName: "Checked")
                // cell.lblName.textColor = .red
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
            } else {
                cell.img.image = #imageLiteral(resourceName: "empty_circle")
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
            }
        }else {
            
            if selectedIndex == FilteredData?.data?[indexPath.row].id ?? "" {
                cell.img.image = #imageLiteral(resourceName: "Checked")
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
                // cell.lblName.textColor = .red
            } else {
                cell.img.image = #imageLiteral(resourceName: "empty_circle")
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
            }
        }
        //
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chooseViewFrom == .category {
            selectedIndex = FilteredData?.data?[indexPath.row].id ?? ""
            selectedCategory = FilteredData?.data?[indexPath.row].title ?? ""
            selectedCategoryid=FilteredData?.data?[indexPath.row].id ?? ""
            dicdata = (FilteredData?.data?[indexPath.row].subcategory!)!
            DispatchQueue.main.async {
                self.categoryListTableView.reloadData()
            }
        }else if chooseViewFrom == .subCategory {
            selectedIndex = FilteredData?.data?[indexPath.row].id ?? ""
            selectedSubCategory = arrSubCategory[indexPath.row].categoryName
            DispatchQueue.main.async {
                self.categoryListTableView.reloadData()
            }
        }else {
            selectedIndex = FilteredData?.data?[indexPath.row].id ?? ""
            DispatchQueue.main.async {
                self.categoryListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Searchbar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            FilteredData=ArrCategorylist
            categoryListTableView.reloadData()
        }else {
            
            FilteredData=ArrCategorylist
            
            let filter  = self.FilteredData?.data?.filter({($0.title?.localizedCaseInsensitiveContains(searchText)) ?? false})
            self.FilteredData?.data=filter
            
            
            //             FilteredData=FilteredData.filter({$0.title.localizedCaseInsensitiveContains(searchText)})
            
            categoryListTableView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        FilteredData=ArrCategorylist
        searchBar.text = ""
        categoryListTableView.reloadData()
    }
    
    
    
    
    
}


struct CategoryModel {
    var categoryName: String
}

enum ChooseViewFrom: String {
    case category = "Category"
    case subCategory = "SubCategory"
}
