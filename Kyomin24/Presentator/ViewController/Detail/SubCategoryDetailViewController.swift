//
//  CategoryDetailViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 28/06/21.
//

import UIKit
import SDWebImage
import Localize_Swift
import Kingfisher

class SubCategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lblviewallhint: UILabel!
    @IBOutlet weak var lblviewcount: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    @IBOutlet weak var lblsubcategoryname: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrCategory = [ChatModel]()
    
    var ArrSubcategory:SubProductTypeModel?
    
    var Subcatid:String?
    var Subcatname:String?
    var MainCatName:String?
    var MainCatid:String?
    var vctype=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Localize.currentLanguage() == "ar" {
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "SubCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoryCollectionViewCell")
        lblsubcategoryname.text=Subcatname
        if Subcatid == "2" || Subcatid == "3" {
            lblbrand.text="Brands".localized()
        }else{
            lblbrand.text="Type".localized()
        }
        
        GetSubcategory(Subcatid:Subcatid ?? "")
    }
    
    
    //MARK: - Action
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func BtnSearch(_ sender: Any) {
        let vc = SearchSuggestionViewController.instance(.homeTab) as! SearchSuggestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func GetSubcategory(Subcatid:String){
        
        let dictParam = ["sub_cat":Subcatid]
        print(dictParam)
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: SubCatproducType, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SubProductTypeModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrSubcategory = resModel
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

//producttype

extension SubCategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.bounds.size.width / 3 , height: 150)
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
        let vc = DetailVC.instance(.homeTab) as! DetailVC
        if indexPath.row == 0 {
            vc.protype = 0
            vc.CountBool=true
        }else{
            vc.protype = Int(ArrSubcategory?.data?.productType?[indexPath.row].id ?? "") ?? 0
            vc.CountBool=false
        }
        
        vc.Subcatid=Subcatid
        vc.Brandname=ArrSubcategory?.data?.productType?[indexPath.row].title
        vc.Subcatname = ArrSubcategory?.data?.subCategory?.name
        vc.MainCatName=ArrSubcategory?.data?.category?.name
        vc.maincatid=MainCatid
        vc.catid=Subcatid
        vc.categoryId=ArrSubcategory?.data?.category?.id
        vc.ProductCount=ArrSubcategory?.data?.productType?[0].title ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension SubCategoryDetailViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrSubcategory?.data?.productType?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SubCategoryCollectionViewCell.self), for: indexPath) as! SubCategoryCollectionViewCell
        
        if indexPath.row == 0 {
            cell.imgView.isHidden=true
            cell.lbltitle.text="All".localized()
            cell.lblviewall.isHidden=false
            cell.lblviewall.textColor = .lightGray
            if ArrSubcategory?.data?.productType?[0].title?.count ?? 0 > 0 {
                cell.lblviewall.text="\(ArrSubcategory?.data?.productType?[0].title ?? "") \("Ad's".localized())"
            }else{
                cell.lblviewall.text=""
            }
            
        
            cell.imgView.image = nil
            
        }else{
            cell.imgView.isHidden=false
            cell.lblviewall.isHidden=true
            cell.lbltitle.text=ArrSubcategory?.data?.productType?[indexPath.row].title
           // cell.imgView.kf.setImage(with:URL(string: self.ArrSubcategory!.data!.productType![indexPath.row].url! ))
            
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: self.ArrSubcategory?.data?.productType?[indexPath.row].url ?? ""), placeholderImage: UIImage(named: ""))
            
            
            
            
            
            
        }
        return cell
    }
    
    
    
}
