//
//  CategoryDetailViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 28/06/21.
//

import UIKit
import SDWebImage
import Localize_Swift

class CategoryDetailViewController: UIViewController {
    @IBOutlet weak var tblheight: NSLayoutConstraint!
    
    @IBOutlet weak var bannertbl: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblcategoryname: UILabel!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    var arrImg = ["", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    var catid:String?
    var catname:String?
    var ArrSubcatData:SubcategoryCategoryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(catid)
        lblcategoryname.text=catname
       GetSubcategory(Subcatid: catid ?? "")
        
        if Localize.currentLanguage() == "en" {
        self.btnBack.transform=CGAffineTransform(rotationAngle:0)
               
           }else{
           self.btnBack.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
           }
        
        if ArrSubcatData?.data?.banner?.count ?? 0 > 0 {
            tblheight.constant = 160
        }else{
            tblheight.constant = 0
        }
        
    }
    
    @IBAction func btnSearch(_ sender: Any) {
     let vc = SearchSuggestionViewController.instance(.homeTab) as! SearchSuggestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - Action
    @IBAction func backAction(_ sender: Any) {
      
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func GetSubcategory(Subcatid:String){
            
            let dictParam = ["cat":Subcatid]
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: SubcategoryUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SubcategoryCategoryModel.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.ArrSubcatData = resModel
                    self.collectionViewCategory.reloadData()
                }else{
                    self.collectionViewCategory.reloadData()
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


extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrSubcatData?.data?.subCategory?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryDetailCollectionViewCell.self), for: indexPath) as! CategoryDetailCollectionViewCell
        cell.lblName.text=" \(ArrSubcatData?.data?.subCategory?[indexPath.row].title ?? "")"
        cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgView.sd_setImage(with: URL(string: ArrSubcatData?.data?.subCategory?[indexPath.row].url ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
        
        
//        if indexPath.row == 0 {
//            cell.imgView.image = #imageLiteral(resourceName: "CARS 1")
//            cell.lblName.text = "Cars"
//        }else if indexPath.row == 1 {
//            cell.imgView.image = #imageLiteral(resourceName: "motorcycle  1")
//            cell.lblName.text = "Motorcycle"
//        }else if indexPath.row == 2 {
//            cell.imgView.image = #imageLiteral(resourceName: "spare partes-Guide 1")
//            cell.lblName.text = ""
//        }else if indexPath.row == 3 {
//            cell.imgView.image = #imageLiteral(resourceName: "heavy equipment 1")
//            cell.lblName.text = "Heavy Equipment"
//        }else if indexPath.row == 4 {
//            cell.imgView.image = #imageLiteral(resourceName: "Offshore-Guide 1")
//            cell.lblName.text = "Offshore Tools"
//        }else {
//            cell.imgView.image = #imageLiteral(resourceName: "equipment tools 1")
//            cell.lblName.text = "Equipment & Tools"
//        }
        return cell
    }
}

extension CategoryDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrSubcatData?.data?.banner?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!BannerDetailCell
        cell.bannerimg.sd_setImage(with: URL(string: ArrSubcatData?.data?.banner?[indexPath.row].banner ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
        return cell
    }
    
    
}

extension CategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    let size = CGSize(width: collectionViewCategory.bounds.size.width / 3 , height: 150)
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
        if ArrSubcatData?.data?.subCategory?[indexPath.row].typeCount == "0"{
        let vc = DetailVC.instance(.homeTab) as! DetailVC
        vc.Subcatid=ArrSubcatData?.data?.subCategory?[indexPath.row].id
        vc.Subcatname=ArrSubcatData?.data?.subCategory?[indexPath.row].title
        vc.Brandname="All"
        vc.MainCatName=catname
        vc.Vctype="Subcat"
        vc.catid=ArrSubcatData?.data?.subCategory?[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        
        }else{
        
        let vc = SubCategoryDetailViewController.instance(.homeTab) as! SubCategoryDetailViewController
        vc.Subcatid=ArrSubcatData?.data?.subCategory?[indexPath.row].id
        vc.Subcatname=ArrSubcatData?.data?.subCategory?[indexPath.row].title
        vc.MainCatName=catname
        self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryDetailCollectionReusableView", for: indexPath) as? CategoryDetailCollectionReusableView else {
                        fatalError("Invalid view type")
                  
                }
           
//            if ArrSubcatData?.data?.banner?.count ?? 0 > 0 {
//
//            headerView.bannerimag.sd_imageIndicator = SDWebImageActivityIndicator.gray
//
//            headerView.bannerimag.sd_setImage(with: URL(string: ArrSubcatData?.data?.banner?[indexPath.row].banner ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
//            }else{
//                headerView.bannertbl.isHidden=true
//
//               // headerView.bannerimag.isHidden=true
////                headerView.bannerimag.image=UIImage(named: "Noimgplace")
//             }
                
                headerView.lblcatname.text=ArrSubcatData?.data?.category?.name
                let text = "Product".localized()
                headerView.lbltotalproduct.text="\(ArrSubcatData?.data?.category?.total ?? "") \(text)"
               // headerView.imgView.image = #imageLiteral(resourceName: "img")
                return headerView
            default:
                assert(false, "Invalid element type")
            }
        return UICollectionReusableView()

        }
    
    
}
