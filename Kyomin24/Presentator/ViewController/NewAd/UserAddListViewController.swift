//
//  UserAddListViewController.swift
//  Mzadi
//
//  Created by Emizentech on 10/09/21.
//

import UIKit
import SDWebImage
import Localize_Swift

class UserAddListViewController: UIViewController {

    @IBOutlet weak var Lbladdpost: UILabel!
    @IBOutlet weak var Btnback: UIButton!
    @IBOutlet weak var ListCollectionView: UICollectionView!
    
     var ArrList: SellerModal?
     var SellerId=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyProfileData()
        ListCollectionView.delegate=self
        if Localize.currentLanguage() == "en" {
                   self.Btnback.transform=CGAffineTransform(rotationAngle:0)
                          
                      }else{
                      self.Btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
                      }
               
    
    }
    

    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension UserAddListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return ArrList?.data?.product?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddListCollectionCell.self), for: indexPath) as! AddListCollectionCell
        cell.lblIQD.text = "\(ArrList?.data?.product?[indexPath.row].price ?? "") IQD"
        cell.lblComment.text = ArrList?.data?.product?[indexPath.row].totalComment ?? ""
        cell.lblMessage.text = ArrList?.data?.product?[indexPath.row].title ?? ""
        cell.lblEye.text = ArrList?.data?.product?[indexPath.row].totalView ?? ""
        if ArrList?.data?.product?[indexPath.row].gallery?.count ?? 0 > 0 {
            if ArrList?.data?.product?[indexPath.row].gallery?[0].fileType == "0" {
                 let url = URL(string:ArrList?.data?.product?[indexPath.row].gallery?[0].url ?? "")
                 if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                     cell.itemImage?.image = thumbnailImage
                 }

               } else{
            cell.itemImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.itemImage.sd_setImage(with: URL(string: ArrList?.data?.product?[indexPath.row].gallery?[0].url ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
             }

        }else{

        }
        
        if ArrList?.data?.product?[indexPath.row].featured ?? "" == "1"{
            cell.lblfeatured.text="Featured".localized()
        }else{
            cell.lblfeatured.isHidden=true
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
        vc.productId = ArrList?.data?.product?[indexPath.row].id ?? ""
        vc.vctype="profile"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    

}

extension UserAddListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
}

extension UserAddListViewController {
    func getMyProfileData(){
        let dictParam = ["seller_id":"\(SellerId)"]


        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: SellerUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SellerModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                print(ResponseJson)
                if stCode == 200{
                    self.ArrList = resModel
                    let Posttext="Post Ad's List".localized()
                self.Lbladdpost.text = "\(self.ArrList?.data?.name ?? "") \(Posttext)(\(self.ArrList?.data?.totalPost ?? ""))"
                    self.ListCollectionView.reloadData()
                }else{
                    self.ListCollectionView.reloadData()
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

