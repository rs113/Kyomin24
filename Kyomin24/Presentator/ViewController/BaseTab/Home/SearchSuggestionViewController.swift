//
//  SearchSuggestionViewController.swift
//  Mzadi
//
//  Created by Emizentech on 20/08/21.
//

import UIKit
import Localize_Swift

class SearchSuggestionViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var categoryListTableView: UITableView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    @IBOutlet weak var btnsearch: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var TxtSearch: UITextField!
    
     var ArrCategorylist:SearchSuggestionModal?
    var FilteredData:SearchSuggestionModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TxtSearch.delegate=self
        if Localize.currentLanguage() == "en" {
        self.btnBack.transform=CGAffineTransform(rotationAngle:0)
               
           }else{
           self.btnBack.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
           }
        
        Settext()
        if Localize.currentLanguage() == "ar" || Localize.currentLanguage() == "ku"{
         btnsearch.imageEdgeInsets=UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
         }
    }
    override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden=true
    }
    
    func Settext(){
        lblHeaderTitle.text="Search".localized()
        btnsearch.setTitle("Search".localized(), for: .normal)
        TxtSearch.placeholder="Search here".localized()
    }
    
    @IBAction func btnsearch(_ sender: Any) {
        if (TxtSearch.text?.isStringBlank())!{
            
        self.showCustomPopupView(altMsg:"Please enter search text".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
         self.dismiss(animated: true, completion: nil)
        }
        }else{
            let vc = DetailVC.instance(.homeTab) as! DetailVC
            vc.Searchtext=TxtSearch.text ?? ""
            vc.Vctype="true"
            vc.Subcatname="Choose Sub Category"
            vc.MainCatName="Choose Category"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    func GetCategoryList(searchtext:String){
       let dictParam = ["keyword":searchtext]
       ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: HomeSearchSuggestionUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SearchSuggestionModal.self, success: { (ResponseJson, resModel, st) in
        print(ResponseJson)
           let stCode = ResponseJson["status_code"].int
           let strMessage = ResponseJson["message"].string
          
           if stCode == 200{
               self.ArrCategorylist = resModel
               self.FilteredData=resModel
               self.categoryListTableView.reloadData()
           }else{
              self.categoryListTableView.reloadData()
//              self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
//               self.dismiss(animated: true, completion: nil)
//               })
           }
       }) { (stError) in
//           self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
//               self.dismiss(animated: true, completion: nil)
//           }
       }
   }
    
    
    
func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool {
   // let newStr = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
    
    if let text = TxtSearch.text,
           let textRange = Range(range, in: text) {
    let updatedText = text.replacingCharacters(in: textRange,
               
                                                      with: string)
             GetCategoryList(searchtext: updatedText)
             categoryListTableView.reloadData()
          
        }
        return true
    }

}

//MARK: - UITableViewDataSource And Delegate
extension SearchSuggestionViewController : UITableViewDataSource , UITableViewDelegate,UISearchBarDelegate {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrCategorylist?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath)as! SearchSuggestionCell
        cell.lblmaincategory.text=ArrCategorylist?.data[indexPath.row].title
        cell.lblcolor.backgroundColor = .random
        
        if  ArrCategorylist?.data[indexPath.row].type == TypeEnum.cat {
            let textin="In".localized()
            cell.lblsubcategory.text="\(textin) \(ArrCategorylist?.data[indexPath.row].mainCategory.title ?? "")"
       }else{
          cell.lblsubcategory.text=ArrCategorylist?.data[indexPath.row].mainCategory.title
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
//    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.contentView.backgroundColor = UIColor(hex: cellColors[indexPath.row % cellColors.count])
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(ArrCategorylist?.data[indexPath.row].type)
        if  ArrCategorylist?.data[indexPath.row].type == TypeEnum.cat{
            let vc = DetailVC.instance(.homeTab) as! DetailVC
            vc.categoryId=ArrCategorylist?.data[indexPath.row].id
            vc.catid=ArrCategorylist?.data[indexPath.row].mainCategory.subCategory.id
            vc.Vctype="false"
            vc.MainCatName=ArrCategorylist?.data[indexPath.row].title
            vc.Subcatname="Choose Sub Category"
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = DetailVC.instance(.homeTab) as! DetailVC
            vc.categoryId=ArrCategorylist?.data[indexPath.row].mainCategory.id
            vc.Vctype="right"
            vc.catid=ArrCategorylist?.data[indexPath.row].mainCategory.subCategory.id
            vc.ProductProId=ArrCategorylist?.data[indexPath.row].id
            vc.Subcatid=ArrCategorylist?.data[indexPath.row].mainCategory.subCategory.id
            vc.Subcatname=ArrCategorylist?.data[indexPath.row].mainCategory.subCategory.title
            vc.MainCatName=ArrCategorylist?.data[indexPath.row].mainCategory.title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    }
    

//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == "" {
//             FilteredData=ArrCategorylist
//            categoryListTableView.reloadData()
//        }else {
//           print(searchText)
//
//           GetCategoryList(searchtext: searchText)
//            categoryListTableView.reloadData()
//   }
//
//    }
//
//        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            FilteredData=ArrCategorylist
//            searchBar.text = ""
//            categoryListTableView.reloadData()
//        }
    
    
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//       // Stop doing the search stuff
//       // and clear the text in the search bar
//       searchBar.text = ""
//
//       // Hide the cancel button
//       searchBar.showsCancelButton = false
//   }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = nil
//        searchBar.showsCancelButton = false
//
//        // Remove focus from the search bar.
//        searchBar.endEditing(true)
//
//        // Perform any necessary work.  E.g., repopulating a table view
//        // if the search bar performs filtering.
//    }

    





