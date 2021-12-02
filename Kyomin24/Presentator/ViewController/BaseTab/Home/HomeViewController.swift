//
//  HomeViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 22/06/21.
//

import UIKit
import SDWebImage

class HomeViewController: HomeBaseMenuViewController {

    //MARK: Outlets
    @IBOutlet var collectionViewHeader: UICollectionView!
    @IBOutlet var collectionViewVehicle: UICollectionView!
    
    var ArrHomeData:HomeBarCategoryModel?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GetHome()
    }
    
    // MARK:- Action
    @IBAction func menuAction(_ sender: Any) {
        openLeftSideMenu()
    }
    
    
    @IBAction func btnnotification(_ sender: Any) {
        let vc = NotificationViewController.instance(.homeTab) as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnsearch(_ sender: Any) {
//     if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
//            self.showCustomPopupView(altMsg:"Please login first", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage(), OkAction: {
//                self.dismiss(animated: true, completion: nil)
//                self.log_Out_from_App()
//            })
//
//        }else{
    }
    
    func GetHome(){
               
               let dictParam = ["":""]
               ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: HomeUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: HomeBarCategoryModel.self, success: { (ResponseJson, resModel, st) in
                   let stCode = ResponseJson["status_code"].int
                   let strMessage = ResponseJson["message"].string
                   if stCode == 200{
                       self.ArrHomeData = resModel
                       self.collectionViewHeader.reloadData()
                   }else{
                       self.collectionViewHeader.reloadData()
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

    

// MARK:-  UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
     
        return 1
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewHeader {
            return ArrHomeData?.data?.bodyData?.count ?? 0
        }else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath as IndexPath) as! HomeHeaderCollectionViewCell
            cell.lblnamecat.text=ArrHomeData?.data?.bodyData?[indexPath.row].name
            cell.carimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.carimg.sd_setImage(with: URL(string: ArrHomeData?.data?.bodyData?[indexPath.row].icon ?? ""), placeholderImage: UIImage(named: ""))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVehicleCollectionViewCell", for: indexPath as IndexPath) as! HomeVehicleCollectionViewCell
            return cell
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: SCREEN_WIDTH/3.08, height: 180)
//        // return CGSize(width: 130, height: 170)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewVehicle {
//            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//            let width:CGFloat = (collectionView.frame.size.width - space) / 3.0
//            let height:CGFloat = (collectionView.frame.size.height - space) / 2.0
//            return CGSize(width: width, height: height)
            let size = CGSize(width: collectionViewVehicle.bounds.size.width / 3 , height: 180)
            return size

        } else {
//            let padding: CGFloat =  5
//            let collectionViewSize = collectionView.frame.size.width - padding
                return CGSize(width:110, height:110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // if collectionView == collectionViewVehicle {
            
            let vc = CategoryDetailViewController.instance(.homeTab) as! CategoryDetailViewController
            vc.catid=ArrHomeData?.data?.bodyData?[indexPath.row].id
            vc.catname=ArrHomeData?.data?.bodyData?[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
            
//        }else {
//            
//        }
        
    }
}
