//
//  ProductImageTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit
import AVKit
import AVFoundation



class ProductImageCollectionCell: UICollectionViewCell{
@IBOutlet weak var imgproduct: UIImageView!
@IBOutlet weak var PlayButton: UIImageView!
}
class ProductImageTblCell: UITableViewCell {
    
   
    
    @IBOutlet weak var pagecount: CustomImagePageControl!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!

    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    var itemData=[Photo]()
    
    var VC = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
         pagecount.currentPage = 0
        collectionview.dataSource = self
        collectionview.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func config(data: [Photo]) {
        self.itemData = data
        collectionview.reloadData()
        if itemData.count == 1 {
            pagecount.isHidden=true
        }else{
        pagecount.numberOfPages=itemData.count
        }
    }
    
    
     
}

extension ProductImageTblCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData.count 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionCell", for: indexPath) as! ProductImageCollectionCell
        
          if itemData[indexPath.row].fileType == "0" {
            cell.PlayButton.isHidden=false
            DispatchQueue.global(qos: .userInitiated).async {
                let url = URL(string:self.itemData[indexPath.row].url ?? "")
                
                if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                    DispatchQueue.main.async {
                        cell.imgproduct?.image = thumbnailImage
                    }
                    
                }
            }
            
            
//            let url = URL(string:itemData[indexPath.row].url ?? "")
//                       if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
//                           cell.imgproduct?.image = thumbnailImage
//                        }
            
          
          } else{
            cell.PlayButton.isHidden=true
        cell.imgproduct.sd_setImage(with: URL(string:itemData[indexPath.row].url ?? ""), placeholderImage: UIImage(named: ""))
        }
            return cell
    }
}

extension ProductImageTblCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionview.frame.size.width, height:collectionview.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
            return 0
        }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: self.collectionview.contentOffset, size: self.collectionview.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = self.collectionview.indexPathForItem(at: visiblePoint) {
                self.pagecount.currentPage = visibleIndexPath.row

      }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if itemData[indexPath.row].fileType == "0" {
                  
                   
                   DispatchQueue.main.async {
                       let videoURL = URL(string: self.itemData[indexPath.row].url ?? "")

                       let player = AVPlayer(url: videoURL!)
                       let playerViewController = AVPlayerViewController()
                       playerViewController.player = player
                       self.VC.present(playerViewController, animated: true) {
                           playerViewController.player!.play()
                   }

                   }
        }else{
            DispatchQueue.main.async {
    
                                    // first download image from url
            let url = URL(string:self.itemData[indexPath.row].url ?? "")!
                                    // Fetch Image Data
               if let data = try? Data(contentsOf: url) {
        // Create Image and Update Image View
        
                
            let imageInfo  = GSImageInfo(image:UIImage(data: data) ?? UIImage(), imageMode:
                .aspectFit)
                
           let transitionInfo = GSTransitionInfo(fromView: collectionView)
           let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        
                imageViewer.dismissCompletion = {
                              print("dismissCompletion")
                          }
                          self.VC.present(imageViewer, animated: true, completion: nil)
                
            
                }

          
        }
        }
    }
}

