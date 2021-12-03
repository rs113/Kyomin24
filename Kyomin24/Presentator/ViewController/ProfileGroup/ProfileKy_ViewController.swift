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
    
    struct ReviewDetail {
        var name : String
        var reviewMesssage : String
        var Count : String
        var  userImg : String
        
    }
    
    @IBOutlet weak var AboutImg: UIImageView!
    var AdsArray:[AdsDetail] = []
    var RebviewsArray:[ReviewDetail] = []
    var strPostCount = ""
    var ReviewCountStr = ""
    @IBOutlet weak var CountTile: UILabel!
    @IBOutlet weak var MainTitle: UILabel!
    @IBOutlet weak var ReviewView: UIView!
    @IBOutlet weak var aboutTxt: UITextView!
    @IBOutlet weak var AboutView: UIView!
    @IBOutlet weak var ReviewsImg: UIImageView!
    @IBOutlet weak var listingImg: UIImageView!
    @IBOutlet weak var AboutBtn: UIButton!
    @IBOutlet weak var ReviewsBtn: UIButton!
    @IBOutlet weak var ListingBtn: UIButton!
    @IBOutlet weak var ReviewsTableList: UITableView!
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
        
        ReviewView.isHidden = true
        AboutView.isHidden = true
        ListingListColl.isHidden = false
        
        // Do any additional setup after loading the view.
    }
    @IBAction func postBtnClicked(_ sender: Any) {
        
        let vc = PostReviewViewController.instance(.myAccountTab) as! PostReviewViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
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
                    
                    let uData = UserModel2(userDetail: resdata)
                    UserModel.save(schoolModel: uData)
                    print(uData)
                    ProfileCity.text = resdata["address"]?.string
                    userName.text = resdata["name"]?.string
                    profileTimelbl.text = resdata["time"]?.string
                    aboutTxt.text = resdata["description"]?.string
                     strPostCount = resdata["product_count"]?.string ?? ""
                     ReviewCountStr = resdata["reviews_count"]?.string ?? ""
                    
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
                    for item in ResponseJson["data"]["reviews"].arrayValue{
                        
                        let NameStr = item["user_name"].stringValue
                        let ReviewStr = item["review"].stringValue
                        let CountStr = item["count"].stringValue
                        let UserImg = item["user_iamge"].stringValue
                        
                        self.RebviewsArray.append(ReviewDetail.init(name: NameStr, reviewMesssage: ReviewStr, Count: CountStr, userImg: UserImg))
                    }
                }
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            ListingListColl.reloadData()
            ReviewsTableList.reloadData()

        }) { (Strerr,stCode) in
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
    @IBAction func ListingBtnClicked(_ sender: Any) {
        
        ListingBtn.setTitleColor(UIColor.orange, for: .normal)
        listingImg.backgroundColor  = UIColor.orange
        
        ReviewsBtn.setTitleColor(UIColor.black, for: .normal)
        ReviewsImg.backgroundColor  = UIColor.lightGray
        
        AboutBtn.setTitleColor(UIColor.black, for: .normal)
        AboutImg.backgroundColor  = UIColor.lightGray
        
        ListingListColl.isHidden = false
        ReviewView.isHidden = true
        AboutView.isHidden = true
        CountTile.isHidden = false
        
        CountTile.text = strPostCount
        MainTitle.text = "Published Ads"

        
    }
    
    @IBAction func ReviewsBtnClicked(_ sender: Any) {
        
        ReviewsBtn.setTitleColor(UIColor.orange, for: .normal)
        ReviewsImg.backgroundColor  = UIColor.orange
        
        ListingBtn.setTitleColor(UIColor.black, for: .normal)
        listingImg.backgroundColor  = UIColor.lightGray
        
        AboutBtn.setTitleColor(UIColor.black, for: .normal)
        AboutImg.backgroundColor  = UIColor.lightGray
        
        ListingListColl.isHidden = true
        ReviewView.isHidden = false
        AboutView.isHidden = true
        CountTile.isHidden = false
        
        CountTile.text = ReviewCountStr
        MainTitle.text = "Reviews"


        
    }
    @IBAction func aboutBtnClicked(_ sender: Any) {
        
        AboutBtn.setTitleColor(UIColor.orange, for: .normal)
        AboutImg.backgroundColor  = UIColor.orange
        
        ReviewsBtn.setTitleColor(UIColor.black, for: .normal)
        ReviewsImg.backgroundColor  = UIColor.lightGray
        
        ListingBtn.setTitleColor(UIColor.black, for: .normal)
        listingImg.backgroundColor  = UIColor.lightGray
        
        AboutView.isHidden = false
        ListingListColl.isHidden = true
        ReviewView.isHidden = true
        CountTile.isHidden = true
        MainTitle.text = "About me"

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
        
        
        return CGSize(width:collectionView.frame.size.width/2 + 50, height:212);
        
    }
    
    
}
extension ProfileKy_ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return RebviewsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProfileReviews_TableViewCell? =
            ReviewsTableList?.dequeueReusableCell(withIdentifier: "CELL") as? ProfileReviews_TableViewCell
        
        cell?.ReviewName.text = RebviewsArray[indexPath.row].name
        cell?.ReviewMessage.text = RebviewsArray[indexPath.row].reviewMesssage
        let imageStr = RebviewsArray[indexPath.row].userImg
        
        
        if imageStr != "" {
            
            let url = URL(string: imageStr)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell?.ReviewsImg.image = image
            }
            
        }
        cell?.ReviewsImg.layer.cornerRadius = (cell?.ReviewsImg.frame.size.height)!/2
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


