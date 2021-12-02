//
//  MyProfileItemTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 30/08/21.
//

import UIKit
import SDWebImage

class MyProfileItemCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblfeatured: UILabel!
}
class MyProfileItemTblCell: UITableViewCell {

    var array = [SellerProduct]()
    var VC = UIViewController()
    
    @IBOutlet weak var noaddview: UIView!
    @IBOutlet weak var colletionview: UICollectionView!
    @IBOutlet weak var colletionview_HC: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colletionview.dataSource = self
        colletionview.delegate = self
         self.Coll_Height()
    }
    

    

    func  config( data: [SellerProduct]) {
        self.array = data
         colletionview.reloadData()
         self.Coll_Height()
        print(data)
    }
    func Coll_Height(){
        let height = colletionview.collectionViewLayout.collectionViewContentSize.height
        self.colletionview_HC.constant = height
        self.colletionview.reloadData()
        self.colletionview.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension MyProfileItemTblCell: UICollectionViewDataSource ,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if array.count>4 {
            return 4
        } else {
           return array.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileItemCollectionCell", for: indexPath) as! MyProfileItemCollectionCell
        if array[indexPath.row].gallery?.count ?? 0>0 {
            if array[indexPath.row].gallery?[0].fileType == "0" {
                        let url = URL(string:array[indexPath.row].gallery?[0].url ?? "")
                        if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                            cell.img?.image = thumbnailImage
            }
                      
        } else{
                cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.img.sd_setImage(with: URL(string:array[indexPath.row].gallery?[0].url ?? ""), placeholderImage: UIImage(named: ""))
                    }
            
        }else{
            
        }
        
        if array[indexPath.row].featured ?? "" == "1"{
            cell.lblfeatured.text = "Featured".localized()
        }else{
            cell.lblfeatured.isHidden=true
        }
        
        
        cell.lblTitle.text = array[indexPath.row].title ?? ""
        cell.lblPrice.text = "\(array[indexPath.row].price ?? "") IQD"
        cell.lblComment.text = array[indexPath.row].totalComment ?? ""
        cell.lblView.text = array[indexPath.row].totalView ?? ""
       
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
        vc.productId = array[indexPath.row].id ?? ""
        vc.vctype="profile"
        self.VC.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

extension MyProfileItemTblCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: colletionview.bounds.size.width / 2 , height: 210)
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
