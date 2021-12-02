//
//  CategoryTableViewCell.swift
//  Mzadi
//
//  Created by Emizentech on 11/08/21.
//

import UIKit
import SDWebImage

class CategoryTableViewCell: UITableViewCell{
    
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var lblproductcount: UILabel!
    @IBOutlet weak var lblcategoryname: UILabel!
    @IBOutlet var ServiceButton: [UIButton]!
    @IBOutlet var lblcollection: [UILabel]!
    @IBOutlet var ImgSubCollection: [DesignableImageView]!
    
    var ProData=[SubCat]()
    var ProMain=[BodyDatum]()
    var CategoryId=""
    var ArrProData:HomeBarCategoryModel?
    var nav:UINavigationController?
    var maincategoryname = ""
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if CategoryId != "23"{
            self.CategoryCollectionView.delegate = self
            self.CategoryCollectionView.dataSource = self
        }
         
//
           //CategoryCollectionView.reloadData()
        //collectionHeightConstriant.constant = 260
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @objc func MovetoSubcategory(sender:UIButton){
        print(sender.tag)
        if ProData[sender.tag].typeCount == "0"{
            let vc = DetailVC.instance(.homeTab) as! DetailVC
            vc.Subcatid=ProData[sender.tag].id
            vc.Subcatname=ProData[sender.tag].name
            vc.Brandname="All"
            vc.catid=ProData[sender.tag].id
            if (self.ProData.count ) > 0 {
                for i in 0 ... (self.ProData.count )-1 {
                    if self.ProData[i].parentID == ArrProData?.data?.bodyData?[i].id {
            let catTitle = ArrProData?.data?.bodyData?[i].name
                        vc.MainCatName=catTitle
                                    
            }
                }
                                            
                                
            }
            self.nav?.pushViewController(vc, animated: true)
        }else{
            let vc = SubCategoryDetailViewController.instance(.homeTab) as! SubCategoryDetailViewController
            vc.Subcatid=ProData[sender.tag].id
            vc.Subcatname=ProData[sender.tag].name
            self.nav?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    func SetSize(){
        
        // DispatchQueue.main.async {
        
        
        if CategoryId == "1" {
            let space  = 10 * (self.ProData.count/3)
            self.collectionHeightConstriant.constant = self.ProData.count % 3 == 0 ?  CGFloat((self.ProData.count/3) * 150 + space): CGFloat((self.ProData.count/3+1) * 150 + space)
            
        }else if CategoryId == "7" {
            let space  = 5 * (self.ProData.count/2)
            self.collectionHeightConstriant.constant = self.ProData.count % 2 == 0 ?  CGFloat((self.ProData.count/2) * 150 + space): CGFloat((self.ProData.count/2+1) * 150 + space)
        }else if CategoryId == "16" {
            let space  = 10 * (self.ProData.count/3)
            self.collectionHeightConstriant.constant = self.ProData.count % 3 == 0 ?  CGFloat((self.ProData.count/3) * 150 + space): CGFloat((self.ProData.count/3+1) * 150 + space)
        }else if CategoryId == "12" {
            self.collectionHeightConstriant.constant = self.ProData.count > 2 ? 285 : 145
        }else if CategoryId == "35" {
           
            self.collectionHeightConstriant.constant = self.ProData.count > 2 ? 265 : 145
//        }else if CategoryId == "23"{
//            let space  = 10 * (self.ProData.count/3)
//            self.collectionHeightConstriant.constant = 504
//            //            self.collectionHeightConstriant.constant = self.ProData.count % 3 == 0 ?  CGFloat((self.ProData.count/3) * 100 + space): CGFloat((self.ProData.count/3+1) * 120 + space)
      }
        else if CategoryId == "54" {
            let space  = 10 * (self.ProData.count/2)
            self.collectionHeightConstriant.constant = self.ProData.count % 2 == 0 ?  CGFloat((self.ProData.count/2) * 105 + space): CGFloat((self.ProData.count/2+1) * 105 + space)
        }else if CategoryId == "51"{
            let space  = 10 * (self.ProData.count/2)
            self.collectionHeightConstriant.constant = self.ProData.count % 2 == 0 ?  CGFloat((self.ProData.count/2) * 180 + space): CGFloat((self.ProData.count/2+1) * 180 + space)
        }else if CategoryId == "57"{
            let space  = 10 * (self.ProData.count)
            self.collectionHeightConstriant.constant = self.ProData.count > 0 ? 350 : 170
        }else if CategoryId == "60" {
            self.collectionHeightConstriant.constant = 200
        }
        self.CategoryCollectionView.reloadData()
    }
}



extension CategoryTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! CategoryCollectionViewCell
//        if CategoryId == "23"{
//            cell.CategoryImg.isHidden=true
//            cell.BackviewOthers.isHidden=true
//            cell.Backview.isHidden=false
//            cell.lblcategoryname.isHidden=true
//
//            for i in 0...cell.ImgSubCollection.count-1 {
//                cell.ImgSubCollection[i].sd_imageIndicator = SDWebImageActivityIndicator.gray
//                cell.ImgSubCollection[i].sd_setImage(with: URL(string:ProData[i].image ?? "" ), placeholderImage: UIImage(named: "Noimgplace"))
//                cell.lblcollection[i].text="\(ProData[i].name ?? "")"
//                cell.lblcollection[i].addBlur(0.001)
//                cell.ServiceButton[i].addTarget(self, action: #selector(MovetoSubcategory(sender:)), for:.touchUpInside)
//            }
//
//
//        }else
            if CategoryId == "60" {
//            cell.Backview.isHidden=true
            cell.CategoryImg.isHidden=true
            cell.BackviewOthers.isHidden=false
            cell.lblcategoryname.isHidden=true
            for i in 0...cell.OthersImgCollection.count-1 {
                cell.OthersImgCollection[i].sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.OthersImgCollection[i].sd_setImage(with: URL(string:ProData[i].image ?? "" ), placeholderImage: UIImage(named: "Noimgplace"))
                cell.OtherslabelCollection[i].text="\(ProData[i].name ?? "")"
                cell.OtherslabelCollection[i].addBlur(0.001)
                cell.OthersCategoryButton[i].addTarget(self, action: #selector(MovetoSubcategory(sender:)), for:.touchUpInside)
            }

            
        }
        else{
//            cell.Backview.isHidden=true
            cell.CategoryImg.isHidden=false
            cell.BackviewOthers.isHidden=true
            cell.lblcategoryname.isHidden=false
            cell.categoryview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            // cell.categoryview.layer.shadowOpacity = 1
            cell.CategoryImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.CategoryImg.sd_setImage(with: URL(string:ProData[indexPath.row].image ?? "" ), placeholderImage: UIImage(named: "Noimgplace"))
            cell.lblcategoryname.text="\(ProData[indexPath.row].name ?? "")"
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if CategoryId == "1" {
            return CGSize(width:(collectionView.frame.width/3)-10, height: 150)
        }else if CategoryId == "7"{
            return CGSize(width:(collectionView.frame.width/2)-10, height: 150)
        }else if CategoryId == "12"{
            if indexPath.item < 2{
                return CGSize(width:(collectionView.frame.width/2)-10, height: 125)
            }else
            {
              return CGSize(width:collectionView.frame.width, height: 145)
            }
            
        }else if CategoryId == "35"{
            

            
            if indexPath.item < 1{
                return CGSize(width:collectionView.frame.width, height: 145)
            }else
            {
                return CGSize(width:(collectionView.frame.width/3)-7, height: 100)

            }
        }
            
        else if CategoryId == "16"{
            return CGSize(width:(collectionView.frame.width/3)-10, height: 150)
        }else if CategoryId == "54" {
            return CGSize(width:(collectionView.frame.width/2)-10, height: 105)
        }else if CategoryId == "51"{
            return CGSize(width:(collectionView.frame.width/2)-10, height: 180)
        }else if CategoryId == "57"{
            return CGSize(width:(collectionView.frame.width)-10, height: 170)
        }else if CategoryId == "60" {
            return CGSize(width:collectionView.frame.width, height: 200)
        }else if CategoryId == "23"{
            return CGSize(width:collectionView.frame.width, height: 504)
        }
        else{
            return CGSize(width:(collectionView.frame.width/3)-10, height: 125)
        }
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if CategoryId == "23"{
            
        }else if CategoryId == "60"{
            
        }else{
            if ProData[indexPath.row].typeCount == "0"{
                let vc = DetailVC.instance(.homeTab) as! DetailVC
                vc.Subcatid=ProData[indexPath.row].id
                vc.Subcatname=ProData[indexPath.row].name
                vc.Brandname="All"
                vc.catid=ProData[indexPath.row].id
                if (self.ProData.count ) > 0 {
                    for i in 0 ... (self.ProData.count )-1 {
                        if self.ProData[i].parentID == ArrProData?.data?.bodyData?[i].id {
                let catTitle = ArrProData?.data?.bodyData?[i].name
                            vc.MainCatName=catTitle
                                        
                }
                    }
                                                
                                    
                }
                
                self.nav?.pushViewController(vc, animated: true)
            }else{
                let vc = SubCategoryDetailViewController.instance(.homeTab) as! SubCategoryDetailViewController
                vc.Subcatid=ProData[indexPath.row].id
                vc.Subcatname=ProData[indexPath.row].name
                vc.MainCatid=ProData[indexPath.row].parentID
                self.nav?.pushViewController(vc, animated: true)
            }
        }
    }
    
}



class CategoryTableViewCell1: UITableViewCell{


@IBOutlet weak var lblproductcount: UILabel!
@IBOutlet weak var lblcategoryname: UILabel!
@IBOutlet var ServiceButton: [UIButton]!
@IBOutlet var lblcollection: [UILabel]!
@IBOutlet var ImgSubCollection: [DesignableImageView]!
}
