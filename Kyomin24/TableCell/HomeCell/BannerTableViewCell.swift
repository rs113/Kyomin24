//
//  BannerTableViewCell.swift
//  Mzadi
//
//  Created by Emizentech on 11/08/21.
//

import UIKit
import SDWebImage

class BannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Curveimg: UIImageView!
    @IBOutlet weak var Backview: CornerBGView!
    @IBOutlet weak var BannercollectHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var BannerCollectionView: UICollectionView!
    
    var adData = Array<AdBanner>()
    var nav:UINavigationController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BannerCollectionView.delegate = self
        BannerCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func Setdata(){
        
        //DispatchQueue.main.async {
            
            let space  = 10 * (self.adData.count-1)
            self.BannercollectHeightConstraint.constant = CGFloat(self.adData.count * 130 + space)
            self.BannerCollectionView.reloadData()
      // }
    }
    
    
}

extension BannerTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannercell", for: indexPath) as! BannerCollectionViewCell
        
        
        if adData[indexPath.row].url?.data?.id ?? ""  == "38" {
            cell.Bannerimgtopconstraint.constant = 25
        }else{
            cell.Bannerimgtopconstraint.constant = 0
        }
        cell.bannerimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.bannerimg.sd_setImage(with: URL(string: adData[indexPath.row].banner ?? ""), placeholderImage: UIImage(named: ""))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height: 130)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if adData[indexPath.row].url?.urlType == "0" {
         if let url = URL(string: adData[indexPath.row].url?.url ?? "") {
            UIApplication.shared.open(url)
        }
        }else {
            if adData[indexPath.row].url?.interType == "0"{
                let vc = DetailVC.instance(.homeTab) as! DetailVC
                vc.Subcatid = adData[indexPath.row].url?.data?.id ?? ""
                vc.catid=adData[indexPath.row].url?.data?.id ?? ""
                vc.Vctype="banner"
                vc.Subcatname = "Choose Sub Category"
                vc.MainCatName = "Choose Category"
                self.nav?.pushViewController(vc, animated: true)
            }else{
                let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
                vc.productId = adData[indexPath.row].url?.data?.id ?? ""
                self.nav?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
}
