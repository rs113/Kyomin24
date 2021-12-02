//
//  favoriteViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 01/07/21.
//

import UIKit
import Localize_Swift
protocol FavoriteCellDelegate {
    func didTapLikeButton(cell: FavoriteCollectionCell)
}
class FavoriteCollectionCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblEye: UILabel!
    @IBOutlet weak var lblIQD: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblArebic: UILabel!
       @IBOutlet weak var lblEnglish: UILabel!
       @IBOutlet weak var languageview: UIView!
    var delegate: FavoriteCellDelegate!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didtapLike(_ sender: Any) {
        delegate.didTapLikeButton(cell: self)
    }
    
}

class FavoriteViewController: BaseMoreMenuViewController {

    @IBOutlet weak var lblfavouritehint: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var NoFavouriteLbl: UILabel!
    
    var vctype=""
    var FavData: FavPostModal?
    var LikeArr: CommonModal?
    var productId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tabBarController?.tabBar.isHidden=true
       if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        
        self.getAllFavApi()
        
    }
    
    
    
    func Settext(){
        lblfavouritehint.text="Favourites".localized()
        NoFavouriteLbl.text="You have no favourite on any post.".localized()
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
    
    @IBAction func actionFavorite(_ sender: Any) {
    }
    
    @IBAction func actionComment(_ sender: Any) {
       //commentSelected()
    }
    

}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //"You have not Commented on any post."
        return FavData?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteCollectionCell.self), for: indexPath) as! FavoriteCollectionCell
        
        cell.lblMessage.text = FavData?.data?[indexPath.row].title ?? ""
        cell.lblIQD.text = "\(FavData?.data?[indexPath.row].price ?? "") IQD"
        cell.lblComment.text = FavData?.data?[indexPath.row].totalComment ?? ""
        cell.lblEye.text = FavData?.data?[indexPath.row].totalView ?? ""
        if FavData?.data?[indexPath.row].gallery?.count != 0 {
            if FavData?.data?[indexPath.row].gallery?[0].fileType == "0" {
                 let url = URL(string:FavData?.data?[indexPath.row].gallery?[0].url ?? "")
                 if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                     cell.itemImage?.image = thumbnailImage
                 }
               
               } else{
            cell.itemImage.sd_setImage(with: URL(string:FavData?.data?[indexPath.row].gallery?[0].url ?? ""), placeholderImage: UIImage(named: ""))
             }
            
            
            
            
        }
        
        
        if FavData?.data?[indexPath.row].langReturn?.contains("en") ?? false && FavData?.data?[indexPath.row].langReturn?.contains("ar") ?? false {
             cell.languageview.isHidden=false
        }else if FavData?.data?[indexPath.row].langReturn?.contains("en") ?? false{
             cell.languageview.isHidden=false
             cell.lblArebic.isHidden=true
         }

         else if FavData?.data?[indexPath.row].langReturn?.contains("ar") ?? false{
             cell.languageview.isHidden=false
              cell.lblEnglish.isHidden=true
         }else{
             cell.languageview.isHidden=true
         }
       
        cell.btnLike.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
  
    
    
}

extension FavoriteViewController: FavoriteCellDelegate {
    func didTapLikeButton(cell: FavoriteCollectionCell) {
        let indexPath = collectionView.indexPath(for: cell)
        if (FavData?.data?[indexPath?.row ?? 0].gallery?.count) != 0 {
            productId = FavData?.data?[indexPath!.row].id ?? ""
            self.LikeApi()
        }
        
    
    }
    
    
   
}
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        vc.productId = FavData?.data?[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension FavoriteViewController{
    func getAllFavApi(){
        let dictParam = ["":""]
        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: FavPruductUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: FavPostModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.FavData = resModel
                    if self.FavData?.data?.count ?? 0 > 0 {
                        self.NoFavouriteLbl.isHidden=true
                    }else{
                        self.NoFavouriteLbl.isHidden=false
                    }
                    self.collectionView.reloadData()
                }else{
                    self.collectionView.reloadData()
                    
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
    
    func LikeApi(){
       
        let dictParam = ["post_id": productId]
        print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: FavStatusUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
                if stCode == 200{
                    self.LikeArr = resModel
                    self.getAllFavApi()
                }else{
                    self.collectionView.reloadData()
                    
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
