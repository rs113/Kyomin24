//
//  PostRejectedViewController.swift
//  Mzadi
//
//  Created by Emizentech on 15/09/21.
//

import UIKit
import Localize_Swift

class PostRejectedViewController: UIViewController {

    @IBOutlet weak var lblforfurther: UILabel!
    @IBOutlet weak var btntryagain: UIButton!
    @IBOutlet weak var lblreasonhint: UILabel!
    @IBOutlet weak var lblpostrejectedhint: UILabel!
    @IBOutlet weak var TblReason: UITableView!
    @IBOutlet weak var btnback: UIButton!
    
    
    var Arrresonlist:PostRejectedModal?
    var Postid=""
    
    var Checkscroll=false
    var editProId1 = ""
    var editProId2 = ""
    var removeDictionaryData : CommonModal?
    var editArray=[GetCategory]()
    var arrEdit:EditDetailModal?
    
    var catListArray: GetCategoryListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    PostRejectedApi(postid: Postid)
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
         
    }

    @IBAction func Btntryagain(_ sender: Any) {
        EditDetailApi()
    }
    
    @IBAction func btnback(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    func Settext(){
        lblpostrejectedhint.text="Post Add Rejected".localized()
        lblreasonhint.text="Reason".localized()
        btntryagain.setTitle("Try Again".localized(), for: .normal)
        lblforfurther.text="For further assistance please Contact Our Customer Service Team at : post@mzadi.net".localized()
        
    }
    
    func PostRejectedApi(postid:String){
        let dictParam = ["id":postid]
        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: PostRejectUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: PostRejectedModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.Arrresonlist = resModel
                    self.TblReason.reloadData()
                }else{
                    self.TblReason.reloadData()
                    
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
    
    
    func EditDetailApi(){
            let dictParam = ["product_id": Postid]
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: editproducturl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: EditDetailModal.self, success: { [self] (ResponseJson, resModel, st) in

                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                print(ResponseJson)
                if stCode == 200{
                    self.arrEdit = resModel
                    self.editArray = resModel.data?.getCategory ?? []
                    print(self.editArray)
                    if self.editArray.count != 0 {
                        self.editProId1 = self.editArray[0].categoryID ?? ""
                        self.editProId2 = self.editArray[1].categoryID ?? ""
                      self.GetCategoryList()
                    }
                    
                }else{
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
    
       func GetCategoryList(){
               
               let dictParam = ["":""]
           ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetCategoryListurl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: GetCategoryListModel.self, success: { [self] (ResponseJson, resModel, st) in
                   let stCode = ResponseJson["status_code"].int
                   let strMessage = ResponseJson["message"].string
                   if stCode == 200{
                       self.catListArray = resModel
                       if (self.catListArray?.data?.count ?? 0) > 0 {
                           for i in 0 ... (self.catListArray?.data?.count ?? 0)-1 {
                               if self.editProId1 == self.catListArray?.data?[i].id {
                                   let catTitle = self.catListArray?.data?[i].title ?? ""
                                   
                                   
                                   for j in 0 ... (self.catListArray?.data?[i].subcategory?.count ?? 0)-1 {
                                       if self.editProId2 == self.catListArray?.data?[i].subcategory?[j].id {
                                           let vc = AddMoreDetailViewController.instance(.newAdTab) as! AddMoreDetailViewController
                                           vc.CategoryId = self.editProId1
                                           vc.Subcatid = self.editProId2
                                           vc.Subcatname = self.catListArray?.data?[i].subcategory?[j].title ?? ""
                                           vc.selectCategory = catTitle
                                           vc.editArray = self.arrEdit
                                           vc.boolValue = true
                                           self.show(vc, sender: nil)
   //                                        let subCatTitle =
   //                                        print(catListArray?.data?[i].subcategory?[j].id)
                                       }
                                   }
                                   
                               }
                           }
                       }
                   }else{
                       
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


extension PostRejectedViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrresonlist?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostRejectedCell", for: indexPath) as! PostRejectedCell
        cell.lblreason.text=Arrresonlist?.data[indexPath.row].name
        return cell
    }
    
    
}


