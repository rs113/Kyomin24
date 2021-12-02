//
//  ProfileKy_ViewController.swift
//  Kyomin24
//
//  Created by emizen on 12/1/21.
//

import UIKit

class ProfileKy_ViewController: UIViewController {
    
    struct AdsDetail {
        
        var Featured : String
        var id : String
        var price: String
        var location: String
        var title: String
        var condition: String
        var gallery: String
        var totalView: String
    }
    
    var AdsArray:[AdsDetail] = []
    
    @IBOutlet weak var ListingListColl: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet weak var ProfileCity: UILabel!
    @IBOutlet weak var profileTimelbl: UILabel!
    @IBOutlet weak var ProfileStatusImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileApiFunc()
        
        ProfileStatusImg.isHidden = true
        ProfileImg.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    
    func ProfileApiFunc(){
        
        let userId = obj.prefs.string(forKey: APP_USER_ID) ?? ""
        
        let idInt = Int(userId) ?? 0
        print(idInt)
        let dictRegParam = [
            
            "profile_id": 87
            
        ]  as [String : Any]
        
        
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeaderK24(url: ProfileApi, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                if let resdata = ResponseJson["data"].dictionary{
                    //                    let Userid = resdata["id"]?.string
                    //                    let phoneno=resdata["phone_no"]?.string
                    
                    let uData = UserModel2(userDetail: resdata)
                    UserModel.save(schoolModel: uData)
                    
                    
                    print(uData)
                    ProfileCity.text = resdata["address"]?.string
                    userName.text = resdata["name"]?.string
                    profileTimelbl.text = resdata["time"]?.string
                    
                    let verifyStatus = resdata["is_verfied"]?.string
                    let ProfileImgStr = resdata["profile_iamge"]?.string ?? ""
                    
                    
                    if ProfileImgStr != "" {
                        
                        let url = URL(string: ProfileImgStr)
                        let data = try? Data(contentsOf: url!)
                        
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            ProfileImg.image = image
                        }
                        
                    }
                    if verifyStatus == "verified" {
                        
                        ProfileStatusImg.isHidden = false
                    }
                    
                    for item in ResponseJson["data"]["listings"].arrayValue{
                        
                        let featuredStr = item["featured"].stringValue
                        let id = item["id"].stringValue
                        let priceStr = item["price"].stringValue
                        let locationStr = item["location"].stringValue
                        let titleStr = item["title"].stringValue
                        let conditionStr = item["condition"].stringValue
                        let galleryStr = item["gallery"].stringValue
                        let total_viewStr = item["total_view"].stringValue
                        
                        self.AdsArray.append(AdsDetail.init(Featured: featuredStr, id: id, price: priceStr, location: locationStr, title: titleStr, condition: conditionStr, gallery: galleryStr, totalView: total_viewStr))
                        
                        
                    }
                    
                    
                }
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            ListingListColl.reloadData()
            
        }) { (Strerr,stCode) in
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
    
    
}
extension ProfileKy_ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        
        return 1
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return AdsArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! ProfileCollectionViewCell


//
        cell.AddTitle.text = AdsArray[indexPath.row].title
        cell.AddPrice.text = AdsArray[indexPath.row].price
        cell.addStatus.text = AdsArray[indexPath.row].condition
        cell.AddLikeLbl.text = AdsArray[indexPath.row].totalView
        cell.AddLocationLbl.text = AdsArray[indexPath.row].location

        let StrImage = AdsArray[indexPath.row].gallery
        
    
        if StrImage != "" {
            
            let url = URL(string: StrImage)
            let data = try? Data(contentsOf: url!)

            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.AddImage.image = image
            }
            
        }

        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
  
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:collectionView.frame.size.width/2 - 20, height:collectionView.frame.size.height);
        
    }
    
    
}
