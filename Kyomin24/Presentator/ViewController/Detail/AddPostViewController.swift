//
//  AddPostViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 01/07/21.
//

import UIKit
import Localize_Swift
import SDWebImage

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var lblkurdishhint: UILabel!
    @IBOutlet weak var lbldetailarabichint: UILabel!
    @IBOutlet weak var lbldetailinenghint: UILabel!
    @IBOutlet weak var lblpricehint: UILabel!
    @IBOutlet weak var lbladdphotohint: UILabel!
    @IBOutlet weak var Lblpricetopconstarint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    @IBOutlet weak var collectionViewPost_HC: NSLayoutConstraint!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtEngName: UITextField!
    @IBOutlet weak var txtEngDes: UITextView!
    @IBOutlet weak var txtArName: UITextField!
    @IBOutlet weak var txtArDes: UITextView!
    @IBOutlet weak var txtKurName: UITextField!
    @IBOutlet weak var txtKurDes: UITextView!
    
    @IBOutlet weak var BtnPost: DesignableButton!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var arbicView: UIView!
    @IBOutlet weak var kurdishView: UIView!
    
    @IBOutlet weak var englishView_HC: NSLayoutConstraint!
    @IBOutlet weak var arbicView_HC: NSLayoutConstraint!
    @IBOutlet weak var kurdishView_HC: NSLayoutConstraint!
    
    var langEng = ""
    var langKur = ""
    var langAr = ""
    
    
    var idsArray = [Int]()
    var feildsArray = [String]()
    var lat = Double()
    var long = Double()
    var location=""
    
    var adtypeid=0
    var protypeid=0
    var proconditionid=0
    var proguarantyid=0
    var cityid=0
    var promodal=0
    var procamera=0
    var procapicity=0
    var prosim=0
    var categoryid=""
    var subcategoryid=""
    var prokm=""
    
    var proquality=0
    var progear=0
    var pronoroom=""
    
    var profurnishing=0
    var proarea=""
    var progender=0
    var prounite=0
    var promaterial=0
    
    var price=""
    var entitle=""
    var endescription=""
    var artitle=""
    var ardescription=""
    var kutitle=""
    var kudescription=""
    var productid=""
    
    
    
    var img = UIImageView()
    var imageArr = [[String:Any]]()
    var selectedStoryType = ""
    var count = 0
    var imgCount = 0
    
    var ArrUplaodFile:FileUploadModal?
    var UpdateImage=UIImage()
    
    var ArrSendData=[[String:Any]]()
    
    
    var ArrGallery=[GetGallery]()
    
    
    var ArrAddPost:AddPostModal?
    
    var boolValue=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(idsArray)
        print(ArrSendData)
        if Localize.currentLanguage() == "ar" {
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }
        tabBarController?.tabBar.isHidden=true
       // collectionViewPost_HC.constant = 80
        Lblpricetopconstarint.constant=20
         collectionViewPost.isHidden=true
        collectionViewPost.delegate = self
    
        txtEngDes.placeholder = "Description".localized()
        txtArDes.placeholder = "Description".localized()
        txtKurDes.placeholder = "Description".localized()
        Settext()
        
        
        if boolValue == true{
            BtnPost.setTitle("Edit".localized(), for: .normal)
            lanData()
            self.setData()
        } else{
            BtnPost.setTitle("Post".localized(), for: .normal)
        LangEng()
        LangAr()
        LangKur()
        }
       //  SetCollectionHeight()
    }
    
    func lanData(){
        englishView.isHidden = false
        englishView_HC.constant = 230
        arbicView.isHidden = false
        arbicView_HC.constant = 230
        kurdishView.isHidden = false
        kurdishView_HC.constant = 230
    }
    
    
    func setData(){
           txtPrice.text = price
           txtArDes.text = ardescription
           txtArName.text = artitle
           txtEngDes.text = endescription
           txtEngName.text = entitle
           txtKurDes.text = kudescription
           txtKurName.text = kutitle
        if(boolValue == true)
        {
        langEng="Eng"
        langAr="Ar"
        langKur="Kur"
        }
       }
    
    
    func Settext(){
        lbladdphotohint.text="Add photos and video (Step 6)".localized()
        lblpricehint.text="Price".localized()
        lbldetailinenghint.text="Details in English".localized()
        txtPrice.placeholder="Enter Price".localized()
        txtEngName.placeholder="Name".localized()
        txtArName.placeholder="Name".localized()
        txtKurDes.placeholder="Name".localized()
        lblkurdishhint.text="Details in Kurdish".localized()
        lbldetailarabichint.text="Details in Arabic".localized()
        
        
    }
    
    func LangEng(){
        if langEng != "" {
            englishView.isHidden = false
            englishView_HC.constant = 230
        } else {
            englishView.isHidden = true
            englishView_HC.constant = 0
        }
    }
    
    func LangAr() {
        if langAr != ""{
            arbicView.isHidden = false
            arbicView_HC.constant = 230
        } else {
            arbicView.isHidden = true
            arbicView_HC.constant = 0
        }
    }
    
    func LangKur() {
        if langKur != ""{
            kurdishView.isHidden = false
            kurdishView_HC.constant = 230
        } else {
            kurdishView.isHidden = true
            kurdishView_HC.constant = 0
        }
    }
    
    // MARK: - Navigation
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func AddImageButton(_ sender: Any) {
        ChooseStoryAction()
        
        
        
    }
    
    @IBAction func didTapAddPost(_ sender: Any) {
        let (iscondition,alertmsg) = CheckValidation()
        if iscondition {
            if boolValue == true{
               EditPostApi()
            }else{
               AddPostApi()
            }
        }
        else{
            self.showCustomPopupView(altMsg:alertmsg, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
        
        
        
    }
    
    
    
    func CheckValidation()->(Bool,String){
        var Iscondition=true
        var AlertMsg=""
        
      
        if imageArr.count  == 0 && ArrGallery.count == 0 {
            //                self.showCustomPopupView(altMsg: "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            //                    self.dismiss(animated: true, completion: nil)
            //                    return
            //                }
            AlertMsg="Please upload atleast one image or video".localized()
            Iscondition=false
            return (Iscondition,AlertMsg)
        }
        if txtPrice.text?.count == 0{
            //                self.showCustomPopupView(altMsg: "Please Enter Price", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
            //                    self.dismiss(animated: true, completion: nil)
            //                    return
            //                }
            AlertMsg="Please Enter Price".localized()
            Iscondition=false
            return (Iscondition,AlertMsg)
        }
        
        if(langEng != "" && boolValue == false )
        {
            if txtEngName.text?.count == 0{
                //                    self.showCustomPopupView(altMsg: "Please Enter Name In English", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                //                        self.dismiss(animated: true, completion: nil)
                //                        return
                //                    }
                
                AlertMsg="Please Enter Name In English".localized()
                Iscondition=false
                return (Iscondition,AlertMsg)
            }
            if txtEngDes.text.count == 0 {
                //                    self.showCustomPopupView(altMsg: "Please Enter Description In English ", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                //                        self.dismiss(animated: true, completion: nil)
                //                        return
                //                    }
                
                AlertMsg="Please Enter Description In English".localized()
                Iscondition=false
                return (Iscondition,AlertMsg)
            }
        }
        if(langKur != ""  && boolValue == false )
        {
            if txtKurName.text?.count == 0{
                //                    self.showCustomPopupView(altMsg: "Please Enter Name In Kurdish", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                //                        self.dismiss(animated: true, completion: nil)
                //                        return
                //                    }
                AlertMsg="Please Enter Name In Kurdish".localized()
                Iscondition=false
                return (Iscondition,AlertMsg)
            }
            if txtKurDes.text.count == 0 {
                //                    self.showCustomPopupView(altMsg: "Please Enter Description In Kurdish", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                //                        self.dismiss(animated: true, completion: nil)
                //                        return
                //                    }
                AlertMsg="Please Enter Description In Kurdish".localized()
                Iscondition=false
                return (Iscondition,AlertMsg)
            }
            
        }
        if(langAr != ""  && boolValue == false )
        {
            if txtArName.text?.count == 0{
                //                    self.showCustomPopupView(altMsg: "Please Enter Name In Arabic", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                //                        self.dismiss(animated: true, completion: nil)
                //                        return
                //                    }
                
                AlertMsg="Please Enter Name In Arabic".localized()
                Iscondition=false
                return (Iscondition,AlertMsg)
            }
            if txtArDes.text.count == 0{
                //                    self.showCustomPopupView(altMsg: "Please Enter Description In Arabic", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                //                        self.dismiss(animated: true, completion: nil)
                //                        return
                //                    }
                
                
                AlertMsg="Please Enter Description In Arabic".localized()
                Iscondition=false
                return (Iscondition,AlertMsg)
            }
            
            
        }
        
        if((txtEngName.text?.count == 0 && txtKurName.text?.count == 0 && txtArName.text?.count == 0) && boolValue == true)
        {
            AlertMsg="Please Fill Atleast One Title And Description".localized()
            Iscondition=false
            return (Iscondition,AlertMsg)
        }
        if((txtEngDes.text?.count == 0 && txtArDes.text?.count == 0 && txtKurDes.text?.count == 0) && boolValue == true)
               {
                   AlertMsg="Please Fill Atleast One Title And Description".localized()
                   Iscondition=false
                   return (Iscondition,AlertMsg)
               }
        
        return (Iscondition,AlertMsg)
    }
    
    
    func ImageAndVideoUplaodApi(){
        
        self.showLoader()
        let param = ["":""]
        
        ApiManager.apiShared.RequestMultiPartPOSTURLwithImageVideo(url: ImageUploadUrl, VCType: self, arrImageVideo: imageArr, params: param as [String : AnyObject], imageKey: "file", thumbNailKey: "thumbnail", responseObject: FileUploadModal.self, success: { (resData, resModel, st) in
            self.hideLoader()
            
            
            let stCode = resData["status_code"].int
            let strMessage = resData["message"].string
            if stCode == 200{
                self.ArrUplaodFile=resModel
                //self.SetCollectionHeight()
                let datadic = ["file_type":self.ArrUplaodFile?.data.fileType ?? 0,"id":self.ArrUplaodFile?.data.id ?? 0] as [String : Any]
                print(datadic)
                self.ArrSendData.append((datadic as [String : Any]))
                print(self.ArrSendData)
                 self.collectionViewPost.reloadData()
                
            
            }
            
        }) { (strEr) in
            self.hideLoader()
            self.showCustomPopupView(altMsg: strEr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    
    func ImageDeleteApi(ImageId:Int){
       let dictRegParam = [
            
            "id":ImageId
            
        ]  as [String : Any]
    
    
        print(dictRegParam)
           
        ApiManager.apiShared.sendRequestServerPostWithHeader(url: ImageDeleteUrl, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
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
    
    
    func AddPostApi(){
        let Catsubid = categoryid + "," + subcategoryid
        print(Catsubid)
    
        let dictParam = ["file_list": self.ArrSendData,
                         "ad_type":adtypeid,
                         "pro_type":protypeid,
                         "pro_condition":proconditionid,
                         "pro_guaranty":proguarantyid,
                         "pro_km":prokm,
                         "pro_model":promodal,
                         "pro_sim":prosim,
                         "pro_gender":progender,
                         "pro_gear":progear,
                         "pro_material":promaterial,
                         "pro_no_room":pronoroom,
                         "pro_unite":prounite,
                         "pro_area":proarea,
                         "pro_capacity":procapicity,
                         "pro_furnishing":profurnishing,
                         "pro_camera":procamera,
                         "pro_quality":proquality,
                         "city":cityid,
                         "location":location,
                         "lat":lat,
                         "long":long,
                         "price":txtPrice.text ?? "",
                         "ku_title":txtKurName.text ?? "",
                         "ku_description":txtKurDes.text ?? "",
                         "en_title":txtEngName.text ?? "",
                         "en_description":txtEngDes.text ?? "",
                         "ar_title":txtArName.text ?? "",
                         "ar_description":txtArDes.text ?? "",
                         "catSubID":Catsubid,
                         "is_vip":obj.prefs.value(forKey: App_User_Addtype) as? Int ?? 0] as [String : Any]
        print(dictParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: AddPostUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: AddPostModal.self, success: { [self] (ResponseJson, resModel, st) in
            print(ResponseJson)
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(strMessage)
            if stCode == 200{
                self.ArrAddPost = resModel
                let vc = PostAdSuccessViewController.instance(.newAdTab) as! PostAdSuccessViewController
                vc.productidL=self.ArrAddPost?.data.productID
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
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
    
    
    
    func EditPostApi(){
        let Catsubid = categoryid + "," + subcategoryid
        print(Catsubid)
        
        
        
        
        
        
        let dictParam = ["file_list": self.ArrSendData,
                         "product_id":productid,
                         "ad_type":adtypeid,
                         "pro_type":protypeid,
                         "pro_condition":proconditionid,
                         "pro_guaranty":proguarantyid,
                         "pro_km":prokm,
                         "pro_model":promodal,
                         "pro_sim":prosim,
                         "pro_gender":progender,
                         "pro_gear":progear,
                         "pro_material":promaterial,
                         "pro_no_room":pronoroom,
                         "pro_unite":prounite,
                         "pro_area":proarea,
                         "pro_capacity":procapicity,
                         "pro_furnishing":profurnishing,
                         "pro_camera":procamera,
                         "pro_quality":proquality,
                         "city":cityid,
                         "location":location,
                         "lat":lat,
                         "long":long,
                         "price":txtPrice.text ?? "",
                         "ku_title":txtKurName.text ?? "",
                         "ku_description":txtKurDes.text ?? "",
                         "en_title":txtEngName.text ?? "",
                         "en_description":txtEngDes.text ?? "",
                         "ar_title":txtArName.text ?? "",
                         "ar_description":txtArDes.text ?? "",
                         "catSubID":Catsubid] as [String : Any]
        
        
        print(dictParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: EditProductUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: AddPostModal.self, success: { [self] (ResponseJson, resModel, st) in
            print(ResponseJson)
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            print(strMessage)
            if stCode == 200{
                self.ArrAddPost = resModel
                let vc = PostAdSuccessViewController.instance(.newAdTab) as! PostAdSuccessViewController
                vc.productidL=self.ArrAddPost?.data.productID
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
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
    
    
    
    func SetCollectionHeight(){
        DispatchQueue.main.async {
            if self.ArrGallery.count == 0 && self.imageArr.count == 0 {
                self.collectionViewPost_HC.constant = 0
            }else{
                self.collectionViewPost_HC.constant = 80
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    
    
    
}


extension AddPostViewController{
    func ChooseStoryAction(){
        let alertController  = UIAlertController(title:"Select option".localized(),message:"",preferredStyle:UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Image".localized(), style: UIAlertAction.Style.default, handler:
        {Void in
            self.imgCount=self.ArrGallery.count + self.imageArr.count
            if self.imgCount>9 {
            
            DispatchQueue.main.async {
                self.showCustomPopupView(altMsg: "Only 10 attachments required in One Ads(1 Video allowed)".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                    return
                })
            }
            }else{
            obj.imagePick(objVC: self)
            }
            obj.callback = { img,ImgUrl in
                self.selectedStoryType = "0"
                self.UpdateImage=img as! UIImage
                
                
                let imgT = ThumbNail.getThumbnailfromImage(imageT: img as? UIImage ?? UIImage())
                let di = ["type":"image","img":img,"videoUrl":NSURL(),"imgThumb":imgT ?? UIImage()]
               // self.imgCount += 1
//                if self.imgCount>9 {
//
//                    DispatchQueue.main.async {
//                        self.showCustomPopupView(altMsg: "Only 10 attachments required in One Ads(1 Video allowed)".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
//                            self.dismiss(animated: true, completion: nil)
//                            return
//                        })
//                    }
//
//                }else{
                     //self.SetCollectionHeight()
                   
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.imageArr.append(di)
                        self.ImageAndVideoUplaodApi()
                    }
                    
                    
                    
                //}
            }
        })
        
        alertController.addAction(cameraAction)
        let GalleryAction = UIAlertAction(title: "Video".localized(), style: UIAlertAction.Style.default, handler:
        { Void in
            obj.VideoPick(objVC: self)
            obj.callback = { videoUrl,vidUrl in
                
                
                let imgThumb = ThumbNail.getThumbnailFromFile(vidUrl as? URL ?? URL(string: "")!)
                self.selectedStoryType = "1"
                
                let di = ["type":"video","img":imgThumb ?? UIImage(),"videoUrl":videoUrl] as [String : Any]
                self.count += 1
                if self.count>1 {
                    DispatchQueue.main.async {
                        
                        self.showCustomPopupView(altMsg: "Only One Video required in One 'Ads".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                            self.dismiss(animated: true, completion: nil)
                            return
                        })
                        
                    }
                    
                }else{
                    self.collectionViewPost.reloadData()
                    self.imageArr.append(di)
                    self.ImageAndVideoUplaodApi()
                    self.collectionViewPost.reloadData()
                }
                
            }
            
        })
        alertController.addAction(GalleryAction)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        // imagePicker.showsCameraControls = false
    }
}



extension AddPostViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if boolValue == true {
            if self.ArrGallery.count == 0 && self.imageArr.count == 0 {
               self.Lblpricetopconstarint.constant = 20
                collectionViewPost.isHidden=true
            }else{
                
               self.Lblpricetopconstarint.constant = 110
                collectionViewPost.isHidden=false
                self.view.layoutIfNeeded()
            }
            return ArrGallery.count + imageArr.count
        }else{
        if self.imageArr.count == 0{
            self.Lblpricetopconstarint.constant = 20
            collectionViewPost.isHidden=true
        }else{
            self.Lblpricetopconstarint.constant = 110
            collectionViewPost.isHidden=false
        }
          return  imageArr.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPostCollectionViewCell", for: indexPath) as! AddPostCollectionViewCell
        
        if boolValue == true {
            if ArrGallery.count > indexPath.row {
                if ArrGallery[indexPath.row].fileType == "0" {
                 let url = URL(string:ArrGallery[0].url ?? "")
                 if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                     cell.img.image = thumbnailImage
                 }
               
               } else{
                    cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.img.sd_setImage(with: URL(string:ArrGallery[indexPath.row].url ?? ""), placeholderImage: UIImage(named: ""))
             }
            }else{
                let count = imageArr.count+ArrGallery.count-indexPath.row-1
                let d = imageArr[count]["img"]
                if let image = d {
                    cell.img?.image = image as? UIImage
                }
            }
        }else{
        let d = imageArr[indexPath.row]["img"]
        if let image = d {
            cell.img?.image = image as? UIImage
        }
        }
        
        cell.btnCancel.tag = indexPath.row
        cell.btnCancel.addTarget(self, action: #selector(removeProductPhotoAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func removeProductPhotoAction(sender:UIButton){
        if sender.tag < ArrGallery.count {
            ArrGallery.remove(at: sender.tag)
            ImageDeleteApi(ImageId: ArrSendData[sender.tag]["id"]as! Int)
            ArrSendData.remove(at: sender.tag)
            collectionViewPost.reloadData()
           
        }else{
            imageArr.remove(at: sender.tag)
            ImageDeleteApi(ImageId: ArrSendData[sender.tag]["id"]as! Int)
            ArrSendData.remove(at: sender.tag)
            collectionViewPost.reloadData()
        }
        
    }
}

extension AddPostViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/3.2) - 10, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


