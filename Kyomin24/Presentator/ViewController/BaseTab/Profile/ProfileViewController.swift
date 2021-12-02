//
//  ProfileViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 01/07/21.
//

import UIKit
import SDWebImage
import Localize_Swift


protocol MyProductCollectionCellDelegate {
    func didTapMoreButton(cell: MyproductCollectionViewCell)
}

class MyproductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var productimg: UIImageView!
    @IBOutlet weak var productprice: UILabel!
    
    @IBOutlet weak var lblcomment: UILabel!
    
    @IBOutlet weak var lblfeatured: UILabel!
    @IBOutlet weak var btnmore: UIButton!
    @IBOutlet weak var lblview: UILabel!
    
    
    var delegate : MyProductCollectionCellDelegate!
    
    
    @IBAction func didtapMore(_ sender: Any) {
        delegate.didTapMoreButton(cell: self)
    }
    
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lblyoudonthave: UILabel!
    
    @IBOutlet weak var btnmyadd: UIButton!
    
    @IBOutlet weak var lblprofiletext: UILabel!
    @IBOutlet weak var backview: CornerBGView!
    @IBOutlet weak var Addview: UIView!
    

    @IBOutlet weak var btnback: UIButton!
    
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    var ArrUserProfile:GetProfileModel?
    
    var ArrMyProductData:MyProductModalApi?
    
    var productID = ""
    var edittitle = ""
    var removeDictionaryData : CommonModal?
    var catListArray: GetCategoryListModel?
    var editProId1 = ""
    var editProId2 = ""
    var editArray=[GetCategory]()
    var arrEdit:EditDetailModal?
    var shareurl=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //  tabbar.items?[1].title = "Number 0"
//        self.title = "item"
//        tabBarItem.title = "fhfkjhf"
//        self.view.layoutIfNeeded()
        Addview.isHidden=true
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
           
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        
        
        Settext()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden=false
        GetMyProfile()
        GetMyProduct()
        
    }
    
    //    @objc func Changebordercolor(){
    //           if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE){
    //               backview.borderColor = App_main_dark
    //               backview.borderWidth = 0
    //                      }else{
    //               backview.borderWidth = 0.5
    //               backview.borderColor = Applightcolor
    //           }
    //
    //       }
    //
    
    
    func Settext(){
        lblyoudonthave.text="you don’t have any active ads start publishing your ads now.".localized()
        lblprofiletext.text="Profile".localized()
       
        btnmyadd.setTitle("My Ads".localized(), for: .normal)
        
        
    }
    
    
    @IBAction func btnshare(_ sender: Any) {
        
        let headerJWT = ["type":"user",
                             "id":obj.prefs.value(forKey:APP_USER_ID) as? String ?? "",
            "name":obj.prefs.value(forKey: APP_USER_NAME) as? String ?? ""] as [String:Any]
            
            do {
                let headerJWTData: Data = try! JSONSerialization.data(withJSONObject:headerJWT,options: JSONSerialization.WritingOptions.prettyPrinted)
                let headerJWTBase64 = headerJWTData.base64EncodedString()
                shareurl = headerJWTBase64
                print(headerJWTBase64)
                
        }
            
    
        //         // Setting description
       // let firstActivityItem = "Description you want.."
        
        // Setting url
        let baseurl = "https://mzadi.ezxdemo.com/shu"
        let sharingUrl = baseurl + "/" + shareurl
        let secondActivityItem : NSURL = NSURL(string:sharingUrl)!
        
        // If you want to use an image
       // let image : UIImage = UIImage(named:obj.prefs.value(forKey: App_User_Img) as! String) ?? UIImage()
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    // MARK: - Action
    @IBAction func actionEdit(_ sender: Any) {
        let vc = EditProfileViewController.instance(.myAccountTab) as! EditProfileViewController
        vc.name=self.ArrUserProfile?.data?.name ?? ""
        vc.mobileno=self.ArrUserProfile?.data?.phoneNo ?? ""
        vc.type=self.ArrUserProfile?.data?.role?[0].name ?? ""
        vc.email=self.ArrUserProfile?.data?.email ?? ""
        vc.userimg=self.ArrUserProfile?.data?.profileImage ?? ""
        vc.about=self.ArrUserProfile?.data?.about ?? ""
        vc.address=self.ArrUserProfile?.data?.address ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnarrow(_ sender: Any) {
        
        let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAddaction(_ sender: Any) {
        let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnback(_ sender: Any) {
        
        self.tabBarController?.selectedIndex=0
        ////        let homeVC = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
        ////        self.navigationController?.setViewControllers([homeVC], animated: true)
        //
        ////        let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
        ////        UIApplication.currentViewController()?.navigationController?.setViewControllers([vc], animated: true)
        //        NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
        //        self.navigationController?.popViewController(animated: true)
        //      // self.navigationController?.popViewController(animated: true)
    }
    
    func GetMyProfile(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: UserMyProfileUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: GetProfileModel.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.ArrUserProfile = resModel
                
            }else{
                
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
    
    
    func GetMyProduct(){
        
        let dictParam = ["page":"",
                         "per_page":"4",
                         "status":"1"]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetMyProductUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: MyProductModalApi.self, success: { (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(ResponseJson)
            if stCode == 200{
                self.ArrMyProductData = resModel
                if self.ArrMyProductData?.data.productList.count ?? 0 > 0 {
                    self.Addview.isHidden=true
                }else{
                    self.Addview.isHidden=false
                }
                self.collectionViewCategory.reloadData()
            }else{
                self.collectionViewCategory.reloadData()
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



extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ArrMyProductData?.data.productList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyproductCollectionViewCell.self), for: indexPath) as! MyproductCollectionViewCell
        cell.lblview.text=ArrMyProductData?.data.productList[indexPath.row].totalView
        cell.lblcomment.text=ArrMyProductData?.data.productList[indexPath.row].totalComment
        cell.productprice.text="\(ArrMyProductData?.data.productList[indexPath.row].price ?? "") IQD"
        
        if ArrMyProductData?.data.productList[indexPath.row].featured ?? "" == "1"{
            cell.lblfeatured.text = "Featured".localized()
        }else{
            cell.lblfeatured.isHidden=true
        }
        
        
        if ArrMyProductData?.data.productList[indexPath.row].gallery.count ?? 0 > 0 {
            if ArrMyProductData?.data.productList[indexPath.row].gallery[0].fileType == "0" {
                
                
                DispatchQueue.global(qos: .userInitiated).async {
                    let url = URL(string:self.ArrMyProductData?.data.productList[indexPath.row].gallery[0].url ?? "")
                    
                    if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                        DispatchQueue.main.async {
                            cell.productimg?.image = thumbnailImage
                        }
                        
                    }
                }
                
                
                
                
                
                //                let url = URL(string:ArrMyProductData?.data.productList[indexPath.row].gallery[0].url ?? "")
                //
                //
                //                if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                //                    cell.productimg?.image = thumbnailImage
                //                }
                
            } else{
                cell.productimg.sd_setImage(with: URL(string:ArrMyProductData?.data.productList[indexPath.row].gallery[0].url ?? ""), placeholderImage: UIImage(named: ""))
            }
        }
        
        
        //        cell.productimg.sd_setImage(with: URL(string:ArrMyProductData?.data.productList[indexPath.row].gallery[0].url ?? ""), placeholderImage: UIImage(named: ""))
        cell.productname.text=ArrMyProductData?.data.productList[indexPath.row].title
        
        let status = ArrMyProductData?.data.productList[indexPath.row].status
        
        cell.delegate = self
        
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionViewCategory.bounds.size.width / 2 , height: 210)
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
        vc.productId = ArrMyProductData?.data.productList[indexPath.row].id ?? ""
        vc.vctype="profile"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyAccountCollectionReusableView", for: indexPath) as? MyAccountCollectionReusableView else {
                    fatalError("Invalid view type")
            }
            headerView.lblname.text=self.ArrUserProfile?.data?.name ?? ""
            headerView.userimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            headerView.userimg.sd_setImage(with: URL(string:self.ArrUserProfile?.data?.profileImage ?? ""), placeholderImage: UIImage(named: "Noimgplace"))
            headerView.lbldescription.text=self.ArrUserProfile?.data?.about ?? ""
            headerView.lblpublishads.text="Published ads".localized()
            headerView.btnedit.setTitle("Edit Profile".localized(), for: .normal)
            let posttext="Post's".localized()
            headerView.lblpost.text="\(ArrMyProductData?.data.total ?? "") \(posttext)"
            if ArrMyProductData?.data.productList.count ?? 0 > 0 {
                headerView.btnarrow.isHidden=false
                headerView.lblpost.isHidden=false
            }else{
                headerView.btnarrow.isHidden=true
                headerView.lblpost.isHidden=true
            }
            return headerView
        default:
            assert(false, "Invalid element type")
        }
        return UICollectionReusableView()
    }
    
}


extension ProfileViewController{
    func pendingStatusActionSheet() {
        let ationSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                
                if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
                    let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                    vc.modalPresentationStyle = .custom
                    vc.alertMsg = "The edited post after approval will go live.Do you still want to edit the post".localized()
                    vc.popupDismissBlock = { btnTitle in
                        if btnTitle == "yes" {
                            self.EditDetailApi()
                        }else {
                            print("Save")
                        }
                    }
                    UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                }else{
                    self.EditDetailApi()
                }
            }
        }
        
        
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
            
        }
        ationSheet.addAction(cancelButton)
        ationSheet.addAction(editButton)
        ationSheet.addAction(deleteButton)
        self.present(ationSheet, animated: true, completion: nil)
        
    }
    
    func InActiveStatusActionSheet() {
        let actionSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
                    
                    let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                    vc.modalPresentationStyle = .custom
                    vc.alertMsg = "The edited post after approval will go live.Do you still want to edit the post".localized()
                    vc.popupDismissBlock = { btnTitle in
                        if btnTitle == "yes" {
                            self.EditDetailApi()
                        }else {
                            print("Save")
                        }
                    }
                    UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                }else{
                    self.EditDetailApi()
                }
            }
            
        }
        
        let markButton = UIAlertAction(title: "Mark as sold".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to sold this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "4")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let activeButton = UIAlertAction(title: "Active".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to Activate this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "1")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
            
        }
        actionSheet.addAction(cancelButton)
        actionSheet.addAction(editButton)
        actionSheet.addAction(markButton)
        actionSheet.addAction(activeButton)
        actionSheet.addAction(deleteButton)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func ActiveStatusActionSheet(selectedindex:Int) {
        
        let actionSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                if  obj.prefs.value(forKey: App_User_Role) as? String == "user"{
                    let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                    vc.modalPresentationStyle = .custom
                    vc.alertMsg = "The edited post after approval will go live.Do you still want to edit the post".localized()
                    vc.popupDismissBlock = { btnTitle in
                        if btnTitle == "yes" {
                            self.EditDetailApi()
                        }else {
                            print("Save")
                        }
                    }
                    UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
                }else{
                    self.EditDetailApi()
                }
                
            }
            
        }
        
        let markButton = UIAlertAction(title: "Mark as sold".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to sold this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "4")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let InActiveButton = UIAlertAction(title: "Deactivate".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to Deactivate this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.updateStatusApi(status: "2")
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        
        
        
        let RepostButton = UIAlertAction(title: "Repost".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to Repost this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.repostStatusApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(cancelButton)
        actionSheet.addAction(editButton)
        actionSheet.addAction(markButton)
        actionSheet.addAction(InActiveButton)
        actionSheet.addAction(deleteButton)
        
        
        
        let datevalue = ArrMyProductData?.data.productList[selectedindex].repostdate ?? ""
        // let changedate = datevalue?.getDateWithFrom ?? ""
        let DateFormat = DateFormatter()
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let Apidate = DateFormat.date(from: datevalue)
        print(Apidate)
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(dateFormatter.string(from: date))
        let currentdate=dateFormatter.string(from: date)
        let currentDate = dateFormatter.date(from: currentdate)
        print(currentDate)
        
        let diffrenceDate =  currentDate?.OffsetFromDays(date: Apidate ?? Date())
        print(diffrenceDate)
        
        
        
        if diffrenceDate ?? 0 > 7 {
            actionSheet.addAction(RepostButton)
        }else{
            
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func markAsSoldStatusActionSheet() {
        let ationSheet: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel) { _ in }
        let deleteButton = UIAlertAction(title: "Delete".localized(), style: .default)
        { _ in
            DispatchQueue.main.async {
                let vc = CustomPopupAlertViewController.instance(.moreMenu) as! CustomPopupAlertViewController
                vc.modalPresentationStyle = .custom
                vc.alertMsg = "Do you want to delete this Ad".localized()
                vc.popupDismissBlock = { btnTitle in
                    if btnTitle == "yes" {
                        self.removeApi()
                    }else {
                        print("Rajesh")
                    }
                }
                UIApplication.currentViewController()?.present(vc, animated: true, completion: nil)
            }
            
        }
        ationSheet.addAction(cancelButton)
        ationSheet.addAction(deleteButton)
        self.present(ationSheet, animated: true, completion: nil)
        
    }
    
}
extension ProfileViewController {
    func updateStatusApi(status: String){
        let dictParam = ["product_id": productID, "status" : status]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: updateProductStatusUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.removeDictionaryData = resModel
                self.GetMyProduct()
            }else{
                self.collectionViewCategory.reloadData()
                
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
    
    
    
    
    func repostStatusApi(){
        let dictParam = ["product_id": productID]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: RepostApiUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.GetMyProduct()
            }else{
                
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
    
    func removeApi(){
        let dictParam = ["product_id": productID]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: removeUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: CommonModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.removeDictionaryData = resModel
                self.GetMyProduct()
            }else{
                self.collectionViewCategory.reloadData()
                
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
    
    
    func SelectAddTypeApi(){
               let dictRegParam = [
                  
                   "product_id":productID
                   ] as [String : Any]
        
               ApiManager.apiShared.sendRequestServerPostWithHeader(url: SelectedAddTypeUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
                   
                   let stCode = ResponseJson["status_code"].int
                   let strMessage = ResponseJson["message"].string
                   if stCode == 200{
                    self.GetCategoryList()
                   }else{
                        self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                                      self.dismiss(animated: true, completion: nil)
                        })
                   }


                   
               }) { (Strerr,stCode) in
                    self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                                  self.dismiss(animated: true, completion: nil)
                              })
               }
                           

    }
    
    func EditDetailApi(){
        let dictParam = ["product_id": productID]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: editproducturl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: EditDetailModal.self, success: { [self] (ResponseJson, resModel, st) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(ResponseJson)
            if stCode == 200{
                self.arrEdit = resModel
                self.editArray = resModel.data?.getCategory ?? []
                print(self.editArray)
                if self.editArray.count != 0 {
                    self.editProId1 = self.editArray[0].categoryID ?? ""
                    self.editProId2 = self.editArray[1].categoryID ?? ""
                    self.SelectAddTypeApi()
                    //self.GetCategoryList()
                }
                
            }else{
                
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


extension ProfileViewController{
    func GetCategoryList(){
        
        let dictParam = ["":""]
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetCategoryListurl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: GetCategoryListModel.self, success: { [self] (ResponseJson, resModel, st) in
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                self.catListArray = resModel
                if (self.catListArray?.data?.count ?? 0) > 0 {
                    for i in 0 ... (self.catListArray?.data?.count ?? 0)-1 {
                        if self.editProId1 == self.catListArray?.data?[i].id {
                            let catTitle = self.catListArray?.data?[i].title ?? ""
                            
                            
                            for j in 0 ... (self.catListArray?.data?[i].subcategory?.count ?? 0)-1 {
                                if self.editProId2 == self.catListArray?.data?[i].subcategory?[j].id {
                                    let vc = AddMoreDetailViewController.instance(.newAdTab) as! AddMoreDetailViewController
                                    vc.CategoryId = self.editProId1
                                    vc.Subcatid = self.editProId2
                                    vc.Subcatname = self.catListArray?.data?[i].subcategory?[j].title ?? ""
                                    vc.edittext=self.edittitle
                                    vc.selectCategory = catTitle
                                    vc.editArray = self.arrEdit
                                    vc.boolValue = true
                                    self.show(vc, sender: nil)
                                    //                                        let subCatTitle =
                                    //                                        print(catListArray?.data?[i].subcategory?[j].id)
                                }
                            }
                            
                        }
                    }
                }
            }else{
                
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

extension ProfileViewController: MyProductCollectionCellDelegate{
    
    func didTapMoreButton(cell: MyproductCollectionViewCell) {
        let indexPath = collectionViewCategory.indexPath(for: cell)
        
        productID = ArrMyProductData?.data.productList[indexPath!.row].id ?? ""
        edittitle = ArrMyProductData?.data.productList[indexPath!.row].title ?? ""
        let status = ArrMyProductData?.data.productList[indexPath!.row].status ?? ""
        
        switch status {
        case "0":
            self.pendingStatusActionSheet()
            break
            
        case "1":
            self.ActiveStatusActionSheet(selectedindex: indexPath?.row ?? 0)
            break
            
        case "2":
            self.InActiveStatusActionSheet()
            break
            
        case "3":
            self.pendingStatusActionSheet()
            break
            
        case "4":
            self.markAsSoldStatusActionSheet()
            break
        default:
            break
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
}

