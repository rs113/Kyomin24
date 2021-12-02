//
//  MyAddViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 01/07/21.
//

import UIKit
import Localize_Swift
import SDWebImage
import ActionSheetPicker_3_0

protocol MyAddCollectionCellDelegate {
    func didTapMoreButton(cell: MyAddCollectionCell)
}

class MyAddCollectionCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblEye: UILabel!
    @IBOutlet weak var lblIQD: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblRejected: UILabel!
    @IBOutlet weak var statusVw: UIView!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnarrow: UIButton!
    @IBOutlet weak var BtnPostRejected: UIButton!
    
    @IBOutlet weak var lblfeatured: UILabel!
    
    var delegate : MyAddCollectionCellDelegate!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didtapMore(_ sender: Any) {
        delegate.didTapMoreButton(cell: self)
    }
}

class MyAddFilterTableCell: UITableViewCell{
    @IBOutlet weak var lbl: UILabel!
    
}

class MyAddViewController: BaseMoreMenuViewController {
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterVw_HC: NSLayoutConstraint!
    
    @IBOutlet weak var lblallad: UILabel!
    @IBOutlet weak var lblyouhavenoadd: UILabel!
    @IBOutlet weak var lblmyadd: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bgButton: UIButton!
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    
    @IBOutlet weak var NoAddView: UIView!
    
    var edittitle = ""
    var vctype=""
    var Checkscroll=false
    var tag = 0
    var productID=""
    var editProId1 = ""
    var editProId2 = ""
    var removeDictionaryData : CommonModal?
    var editArray=[GetCategory]()
    var arrEdit:EditDetailModal?
    var arrAdds:MyAddsModalApi?
    var Status=""
    var pageCount = 1
    private var lastContentOffset: CGFloat = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    
    var catListArray: GetCategoryListModel?
    
    
    
    var filterArr = ["All".localized(),"Pending".localized(),"Active".localized(),"InActive".localized(),"Rejected".localized(),"Mark as sold".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        Settext()
        
        filterView.isHidden = true
        filterVw_HC.constant = 0
        bgButton.isHidden = true
        lblAll.text = filterArr.first
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Checkscroll == true{
            didScrollGetData(page: pageCount, status: "")
        }else{
            getAddList(satus:"")
        }
    }
    
    
    func Settext(){
        lblmyadd.text="My Ads".localized()
        lblallad.text="All Ads".localized()
        
    }
    
    
    @IBAction func actionMenu(_ sender: Any) {
        if vctype == "sidemenu"{
            NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func didTapAllFilterButton(_ sender: UIButton) {
        if tag == 0 {
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 215
                self.filterView.isHidden = false
                self.bgButton.isHidden = false
                self.tag = 1
            })
        } else {
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                sender.tag = 0
            })
        }
    }
    
    @IBAction func didTapBgButton(_ sender: Any) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.filterVw_HC.constant = 0
            self.filterView.isHidden = true
            self.bgButton.isHidden = true
            self.tag = 0
        })
    }
    
    
    @objc func MovePostRejected(sender:UIButton){
        if arrAdds?.data?.adsList?[sender.tag].status == "3"{
            let vc = PostRejectedViewController.instance(.newAdTab) as! PostRejectedViewController
            vc.Postid = arrAdds?.data?.adsList?[sender.tag].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

//extension MyAddViewController: UITableViewDataSource, UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return self.filterArr.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAddFilterTableCell", for: indexPath) as! MyAddFilterTableCell
//        cell.lbl.text = filterArr[indexPath.row]
//        cell.separatorInset = .zero
//            return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 35
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.filterVw_HC.constant = 0
//                self.filterView.isHidden = true
//                self.bgButton.isHidden = true
//                self.tag = 0
//            })
//            lblAll.text = "All"
//            Status=""
//            getAddList(satus:Status)
//
////            pageCount=1
////            self.arrAdds = nil
////            if Checkscroll == true {
////                didScrollGetData(page: pageCount, status: Status)
////            }else{
////
////                getAddList(satus:Status)
////            }
//            break
//        case 1:
//            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.filterVw_HC.constant = 0
//                self.filterView.isHidden = true
//                self.bgButton.isHidden = true
//                self.tag = 0
//            })
//            lblAll.text = "Pending"
//            Status="0"
//            getAddList(satus:Status)
//
////            pageCount=1
////            self.arrAdds = nil
////            if Checkscroll == true {
////                didScrollGetData(page: pageCount, status: Status)
////            }else{
////                getAddList(satus:Status)
////            }
//
//            break
//        case 2:
//            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.filterVw_HC.constant = 0
//                self.filterView.isHidden = true
//                self.bgButton.isHidden = true
//                self.tag = 0
//            })
//            lblAll.text = "Active"
//            Status="1"
//            getAddList(satus:Status)
//
////            pageCount=1
////            self.arrAdds = nil
////            if Checkscroll == true {
////                didScrollGetData(page: pageCount, status: Status)
////            }else{
////                getAddList(satus:Status)
////            }
//            break
//        case 3:
//            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.filterVw_HC.constant = 0
//                self.filterView.isHidden = true
//                self.bgButton.isHidden = true
//                self.tag = 0
//            })
//            lblAll.text = "InActive"
//            Status="2"
//            getAddList(satus:Status)
//
////            pageCount=1
////            self.arrAdds = nil
////            if Checkscroll == true {
////                didScrollGetData(page: pageCount, status: Status)
////            }else{
////                getAddList(satus:Status)
////            }
//            break
//        case 4:
//            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.filterVw_HC.constant = 0
//                self.filterView.isHidden = true
//                self.bgButton.isHidden = true
//                self.tag = 0
//            })
//
//            lblAll.text = "Rejected"
//            Status="3"
//            getAddList(satus:Status)
//
////            pageCount=1
////            self.arrAdds = nil
////            if Checkscroll == true {
////                didScrollGetData(page: pageCount, status: Status)
////            }else{
////                getAddList(satus:Status)
////            }
//            break
//        case 5:
//            lblAll.text = "Mark as sold"
//            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.filterVw_HC.constant = 0
//                self.filterView.isHidden = true
//                self.bgButton.isHidden = true
//                self.tag = 0
//            })
//            Status="4"
//            getAddList(satus:Status)
//
////            pageCount=1
////            self.arrAdds = nil
////            if Checkscroll == true {
////                didScrollGetData(page: pageCount, status: Status)
////            }else{
////                getAddList(satus:Status)
////            }
//            break
//        default:
//            break
//        }
//    }
//
//}



extension MyAddViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if lastContentOffset < scrollView.contentOffset.y {
            Checkscroll=true
            pageCount = pageCount + 1
            if pageCount <= Int(arrAdds?.data?.lastPage ?? "") ?? 0 {
                print(pageCount)
                self.didScrollGetData(page: self.pageCount, status: "")
            }
        }
    }
}

extension MyAddViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAddFilterTableCell", for: indexPath) as! MyAddFilterTableCell
        cell.lbl.text = filterArr[indexPath.row]
        cell.separatorInset = .zero
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                self.tag = 0
            })
            lblAll.text = "All".localized()
            pageCount=1
            self.arrAdds = nil
            if Checkscroll == true {
                didScrollGetData(page: pageCount, status: "")
            }else{
                getAddList(satus:Status)
            }
            // getAddList(satus: "")
            break
        case 1:
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                self.tag = 0
            })
            lblAll.text = "Pending".localized()
            pageCount=1
            self.arrAdds = nil
            if Checkscroll == true {
                didScrollGetData(page: pageCount, status: "0")
            }else{
                getAddList(satus:"0")
            }
            //getAddList(satus: "0")
            break
        case 2:
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                self.tag = 0
            })
            lblAll.text = "Active".localized()
            pageCount=1
            self.arrAdds = nil
            if Checkscroll == true {
                didScrollGetData(page: pageCount, status: "1")
            }else{
                getAddList(satus: "1")
            }
            
            break
        case 3:
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                self.tag = 0
            })
            lblAll.text = "InActive".localized()
            pageCount=1
            self.arrAdds = nil
            if Checkscroll == true {
                didScrollGetData(page: pageCount, status: "2")
            }else{
                getAddList(satus: "2")
            }
            break
        case 4:
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                self.tag = 0
            })
            
            lblAll.text = "Rejected".localized()
            pageCount=1
            self.arrAdds = nil
            if Checkscroll == true {
                didScrollGetData(page: pageCount, status: "3")
            }else{
                getAddList(satus: "3")
            }
            break
        case 5:
            lblAll.text = "Mark as sold".localized()
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.filterVw_HC.constant = 0
                self.filterView.isHidden = true
                self.bgButton.isHidden = true
                self.tag = 0
            })
            pageCount=1
            self.arrAdds = nil
            if Checkscroll == true {
                didScrollGetData(page: pageCount, status: "4")
            }else{
                getAddList(satus: "4")
            }
            break
        default:
            break
        }
    }
    
}

extension MyAddViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return productArray?.data.productList.count ?? 0
        
        return arrAdds?.data?.adsList?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyAddCollectionCell.self), for: indexPath) as! MyAddCollectionCell
        cell.lblIQD.text = "\(arrAdds?.data?.adsList?[indexPath.row].price ?? "") IQD"
        cell.lblComment.text = arrAdds?.data?.adsList?[indexPath.row].totalComment ?? ""
        cell.lblMessage.text = arrAdds?.data?.adsList?[indexPath.row].title ?? ""
        cell.lblEye.text = arrAdds?.data?.adsList?[indexPath.row].totalView ?? ""
        cell.BtnPostRejected.tag=indexPath.row
        cell.BtnPostRejected.addTarget(self, action: #selector(MovePostRejected(sender:)), for: .touchUpInside)
        if arrAdds?.data?.adsList?[indexPath.row].items?.count ?? 0 > 0 {
            if arrAdds?.data?.adsList?[indexPath.row].items?[0].fileType == "0" {
                
                DispatchQueue.global(qos: .userInitiated).async {
                    let url = URL(string:self.arrAdds?.data?.adsList?[indexPath.row].items?[0].url ?? "")
                       if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                           DispatchQueue.main.async {
                                cell.itemImage?.image = thumbnailImage
                           }

                        }
                       }
                       
                
                
                
                
//                let url = URL(string:arrAdds?.data?.adsList?[indexPath.row].items?[0].url ?? "")
//                if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
//                    cell.itemImage?.image = thumbnailImage
//                }
                
            } else{
                cell.itemImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.itemImage.sd_setImage(with: URL(string: arrAdds?.data?.adsList?[indexPath.row].items?[0].url ?? ""), placeholderImage: UIImage(named: ""))
            }
            
        }else{
            
        }
        
        if  arrAdds?.data?.adsList?[indexPath.row].featured ?? "" == "1" {
            cell.lblfeatured.text="Featured".localized()
        }else{
            cell.lblfeatured.isHidden=true
        }
        
        let status = arrAdds?.data?.adsList?[indexPath.row].status
        
        if status == "0" {
            cell.lblRejected.text = "Pending for approval".localized()
        } else if status == "1" {
            //cell.statusVw.isHidden=true
            cell.lblRejected.text = ""
            
        } else if status == "2" {
            cell.lblRejected.text = "Post InActivate".localized()
            
        }  else if status == "3" {
            cell.lblRejected.text = "Post Rejected".localized()
            
        } else if status == "4" {
            cell.lblRejected.text = "Post Mark as sold".localized()
        }
        
        if arrAdds?.data?.adsList?[indexPath.row].status == "2" {
            cell.statusVw.backgroundColor = UIColor.red
        }else if arrAdds?.data?.adsList?[indexPath.row].status == "4"{
            cell.statusVw.backgroundColor = UIColor.lightGray
        }else if arrAdds?.data?.adsList?[indexPath.row].status == "1"{
            cell.statusVw.backgroundColor = UIColor.clear
        }
        else{
            cell.statusVw.backgroundColor = UIColor(red: 180/255, green: 131/255, blue: 43/255, alpha: 1)
        }
        
        
        if arrAdds?.data?.adsList?[indexPath.row].status == "3"{
            cell.btnarrow.isHidden=false
        }else{
            cell.btnarrow.isHidden=true
        }
        
        cell.delegate = self
        return cell
    }
    
}

extension MyAddViewController: MyAddCollectionCellDelegate{
    func didTapMoreButton(cell: MyAddCollectionCell) {
        let indexPath = collectionView.indexPath(for: cell)
        
        productID = arrAdds?.data?.adsList?[indexPath!.row].id ?? ""
        edittitle = arrAdds?.data?.adsList?[indexPath!.row].title ?? ""
        let status = arrAdds?.data?.adsList?[indexPath!.row].status ?? ""
        
        switch status {
        case "0":
            self.pendingStatusActionSheet()
            break
            
        case "1":
            self.ActiveStatusActionSheet(selectedindex: indexPath?.row ?? 0)
            break
            
        case "2":
            self.InActiveStatusActionSheet()
            break
            
        case "3":
            self.pendingStatusActionSheet()
            break
            
        case "4":
            self.markAsSoldStatusActionSheet()
            break
        default:
            break
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
}


extension MyAddViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.bounds.size.width / 2 , height: 210)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
        vc.productId = arrAdds?.data?.adsList?[indexPath.row].id ?? ""
        vc.vctype="profile"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}



extension MyAddViewController {
    func updateStatusApi(status: String){
        let dictParam = ["product_id": productID, "status" : status]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: updateProductStatusUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.removeDictionaryData = resModel
                self.getAddList(satus: "")
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
    
    func repostStatusApi(){
        let dictParam = ["product_id": productID]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: RepostApiUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.getAddList(satus:"")
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
    
    
    func removeApi(){
        let dictParam = ["product_id": productID]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: removeUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.removeDictionaryData = resModel
                self.getAddList(satus: "")
            }else{
                self.collectionView.reloadData()
                
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
    
    func SelectAdd(){
               let dictRegParam = [
                  
                   "product_id":productID
                   ] as [String : Any]
        
               ApiManager.apiShared.sendRequestServerPostWithHeader(url: SelectedAddTypeUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
                   
                   let stCode = ResponseJson["status_code"].int
                   let strMessage = ResponseJson["message"].string
                   if stCode == 200{
                    self.GetCategoryList()
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
    
    
    func EditDetailApi(){
        let dictParam = ["product_id": productID]
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
                    self.SelectAdd()
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
}


extension MyAddViewController{
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
                                    vc.edittext = self.edittitle
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


extension MyAddViewController {
    func getAddList(satus: String){
        pageCount=1
        let dictParam = ["page":pageCount,
                         "per_page":"10",
                         "status": satus] as [String : Any]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetMyProductUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: MyAddsModalApi.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                
                self.arrAdds = resModel
                if self.arrAdds?.data?.adsList?.count ?? 0 == 0 {
                    self.NoAddView.isHidden=false
                }else{
                    self.NoAddView.isHidden=true
                }
                
                let posttxt = "Post's".localized()
                self.itemCount.text = "\(self.arrAdds?.data?.total ?? "") \(posttxt)"
                self.collectionView.reloadData()
            }else{
                self.collectionView.reloadData()
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
    
    func didScrollGetData(page : Int,status:String){
        let dictParam = ["page":page,
                         "per_page":"10",
                         "status": status] as [String : Any]
        
        ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: GetMyProductUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: MyAddsModalApi.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                
                if self.arrAdds == nil{
                    self.arrAdds=resModel
                }else{
                    self.arrAdds?.data?.adsList?.append(contentsOf: resModel.data?.adsList ?? [])
                }
                
                if self.arrAdds?.data?.adsList?.count ?? 0 == 0 {
                    self.NoAddView.isHidden=false
                }else{
                    self.NoAddView.isHidden=true
                }
                
                let posttext="Post's".localized()
                self.itemCount.text = "\(self.arrAdds?.data?.total ?? "") \(posttext)"
                self.collectionView.reloadData()
            }else{
                self.collectionView.reloadData()
                
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

extension MyAddViewController{
    func pendingStatusActionSheet() {
        let ationSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                
                if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
                    let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                    vc.modalPresentationStyle = .custom
                    vc.alertMsg = "The edited post after approval will go live.Do you still want to edit the post".localized()
                    vc.popupDismissBlock = { btnTitle in
                        if btnTitle == "yes" {
                            self.EditDetailApi()
                        }else {
                            print("Save")
                        }
                    }
                    UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                }else{
                    self.EditDetailApi()
                }
                
            }
            
        }
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
            
        }
        ationSheet.addAction(cancelButton)
        ationSheet.addAction(editButton)
        ationSheet.addAction(deleteButton)
        self.present(ationSheet, animated: true, completion: nil)
        
    }
    
    func InActiveStatusActionSheet() {
        let actionSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                if obj.prefs.value(forKey: App_User_Role) as? String == "user" {
                    let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                    vc.modalPresentationStyle = .custom
                    vc.alertMsg = "The edited post after approval will go live.Do you still want to edit the post".localized()
                    vc.popupDismissBlock = { btnTitle in
                        if btnTitle == "yes" {
                            self.EditDetailApi()
                        }else {
                            print("Save")
                        }
                    }
                    UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                }else{
                    self.EditDetailApi()
                }
            }
        }
        
        let markButton = UIAlertAction(title: "Mark as sold".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to sold this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "4")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let activeButton = UIAlertAction(title: "Active".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to Activate this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "1")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
            
        }
        actionSheet.addAction(cancelButton)
        actionSheet.addAction(editButton)
        actionSheet.addAction(markButton)
        actionSheet.addAction(activeButton)
        actionSheet.addAction(deleteButton)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func ActiveStatusActionSheet(selectedindex:Int) {
        let actionSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                if   obj.prefs.value(forKey: App_User_Role) as? String == "user" {
                    let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                    vc.modalPresentationStyle = .custom
                    vc.alertMsg = "The edited post after approval will go live.Do you still want to edit the post".localized()
                    vc.popupDismissBlock = { btnTitle in
                        if btnTitle == "yes" {
                            self.EditDetailApi()
                        }else {
                            print("Save")
                        }
                    }
                    UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                }else{
                    self.EditDetailApi()
                }
            }
        }
        
        let markButton = UIAlertAction(title: "Mark as sold".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to sold this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "4")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let InActiveButton = UIAlertAction(title: "DeActivate".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to Deactivate this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "2")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        let RepostButton = UIAlertAction(title: "Repost".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to Repost this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.repostStatusApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        
        actionSheet.addAction(cancelButton)
        actionSheet.addAction(editButton)
        actionSheet.addAction(markButton)
        actionSheet.addAction(InActiveButton)
        actionSheet.addAction(deleteButton)
        
        let datevalue = arrAdds?.data?.adsList?[selectedindex].repostdate ?? ""
        // let changedate = datevalue?.getDateWithFrom ?? ""
        let DateFormat = DateFormatter()
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let Apidate = DateFormat.date(from: datevalue)
        print(Apidate)
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(dateFormatter.string(from: date))
        let currentdate=dateFormatter.string(from: date)
        let currentDate = dateFormatter.date(from: currentdate)
        print(currentDate)
        
        let diffrenceDate =  currentDate?.OffsetFromDays(date: Apidate ?? Date())
        print(diffrenceDate)
        
        
        if diffrenceDate ?? 0 > 7 {
            actionSheet.addAction(RepostButton)
        }else{
            
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func markAsSoldStatusActionSheet() {
        let ationSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
            
        }
        ationSheet.addAction(cancelButton)
        ationSheet.addAction(deleteButton)
        self.present(ationSheet, animated: true, completion: nil)
        
    }
    
}
