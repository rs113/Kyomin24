//
//  SelectSubCategoryViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//





//
//  SelectSubCategoryViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 24/06/21.
//

import UIKit
import Localize_Swift


class SelectSubCategoryViewController: UIViewController {
    
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var categoryListTableView: UITableView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var ProductSearchbar: UISearchBar!
    
      var langEng = ""
      var langKur = ""
       var langAr = ""
    
      var MoveBack=false
    
      var callBack: (( _ SelectedText: String, _ SelectedId: String, _ returnBool: Bool)-> Void)?
    
       var selectedIndex = ""
       var chooseViewFrom = ChooseViewFrom.category
       var selectedSubCategory = ""
       var selectCategory = ""
       var selectCategoryid = ""
       var selectSubCatId = ""
       
       var dic = [Subcategory]()
       var ArrCategorylist = [Subcategory]()
       var FilteredData = [Subcategory]()
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        lblHeaderTitle.text="Choose Sub Category (Step 4)".localized()
        ProductSearchbar.placeholder="Search".localized()
        btncontinue.setTitle("Continue".localized(), for: .normal)
        
        FilteredData = dic
        ArrCategorylist = dic
        categoryListTableView.tableFooterView=UIView()
        ProductSearchbar.delegate = self
        ProductSearchbar.backgroundImage = UIImage()
        self.dismissKeyboard()
    }
    

    
    // MARK: - Navigation
    @IBAction func actionBackButton(_ sender: Any) {
      if MoveBack == true {
                self.dismiss(animated: true, completion: nil)
            }else{
            self.navigationController?.popViewController(animated: true)
            }
   }

    @IBAction func actionContinue(_ sender: Any) {
        if chooseViewFrom == .category {
            if selectedIndex != "" {
                if MoveBack == true {
                self.dismiss(animated: true, completion: nil)
                    self.callBack?(selectedSubCategory, selectSubCatId, false)
                }else{
                let vc = AddMoreDetailViewController.instance(.newAdTab) as! AddMoreDetailViewController
                vc.Subcatname = selectedSubCategory
                vc.selectCategory = selectCategory
                vc.Subcatid = selectSubCatId
                vc.CategoryId=selectCategoryid
                vc.langEng = langEng
                vc.langKur = langKur
                vc.langAr = langAr
                self.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                
                self.showCustomPopupView(altMsg: "Please Select Sub Category".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                                   self.dismiss(animated: true, completion: nil)
            }
//                Util.showAlertWithCallback("Alert", message: "Please Select Category", okStr: "Ok", cancelStr: "", isWithCancel: false)
            
            }
        }else {
            if selectedIndex != "" {
//                delegate?.chooseSubCategory(strSubCategory: selectedSubCategory)
                self.navigationController?.popViewController(animated: true)
            }else {
                self.showCustomPopupView(altMsg: "Please Select SubCategory".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage()) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func dismissKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(SelectSubCategoryViewController.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
        @objc private func dismissKeyboardTouchOutside() {
           view.endEditing(true)
        }
}

//MARK: - UITableViewDataSource And Delegate
extension SelectSubCategoryViewController : UITableViewDataSource , UITableViewDelegate,UISearchBarDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if chooseViewFrom == .category {
//            return arrCategory.count
//        }else {
//            return arrSubCategory.count
//        }
        return FilteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectCategoryTableViewCell.self)) as! SelectCategoryTableViewCell
        
        cell.lblName.text = FilteredData[indexPath.row].title
        
        if chooseViewFrom == .category {
            if selectedIndex == FilteredData[indexPath.row].id {
                cell.img.image = #imageLiteral(resourceName: "Checked")
               // cell.lblName.textColor = .red
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
            } else {
                cell.img.image = #imageLiteral(resourceName: "empty_circle")
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
        }
        }else {
   
            if selectedIndex == FilteredData[indexPath.row].id {
                cell.img.image = #imageLiteral(resourceName: "Checked")
                //cell.lblName.textColor = .red
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
            } else {
                cell.img.image = #imageLiteral(resourceName: "empty_circle")
                cell.lblName.textColor = UIColor(red:141/255, green:153/255, blue:174/255, alpha: 1)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chooseViewFrom == .category {
            selectedIndex = FilteredData[indexPath.row].id ?? ""
            selectedSubCategory = FilteredData[indexPath.row].title ?? ""
            selectSubCatId = FilteredData[indexPath.row].id ?? ""
            DispatchQueue.main.async {
                self.categoryListTableView.reloadData()
            }
        }else if chooseViewFrom == .subCategory {
            selectedIndex = FilteredData[indexPath.row].id ?? ""
//            selectedSubCategory = arrSubCategory[indexPath.row].categoryName
            DispatchQueue.main.async {
                self.categoryListTableView.reloadData()
            }
        }else {
            selectedIndex = FilteredData[indexPath.row].id ?? ""
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
           FilteredData = ArrCategorylist
            let filter  = self.FilteredData.filter({($0.title?.localizedCaseInsensitiveContains(searchText)) ?? false})
            
            self.FilteredData = filter
            categoryListTableView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        FilteredData=ArrCategorylist
        searchBar.text = ""
        categoryListTableView.reloadData()
    }
}
