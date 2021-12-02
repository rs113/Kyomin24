//
//  DetailVC.swift
//  Mzadi
//
//  Created by Emizen tech on 17/08/21.
//

//  DetailVC.swift
//  Mzadi
//
//  Created by Emizen tech on 17/08/21.
//

import UIKit
import Localize_Swift
import SDWebImage

class DetailVC: UIViewController {
    @IBOutlet weak var filterCollectionview: UICollectionView!
    @IBOutlet weak var lblcategorytext: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var itemCollectionview: UICollectionView!
    @IBOutlet weak var sortByTableview: UITableView!
    @IBOutlet weak var FilterCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var itemTableview: UITableView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortView_HC: NSLayoutConstraint!
    @IBOutlet weak var itemCount: UILabel!

    @IBOutlet weak var lblcategorynohint: UILabel!
    @IBOutlet weak var lblproducthint: UILabel!
    @IBOutlet weak var lblsorybyhint: UILabel!
    @IBOutlet weak var NoCategoryView: UIView!
    
    @IBOutlet weak var Btntable: UIButton!
    @IBOutlet weak var BtnCollection: UIButton!
    
    var CountBool=false
    var Subcatid:String?
    var Brandname:String?
    var Subcatname:String?
    var MainCatName:String?
    var maincatid:String?
    var listArray: SlideListModal?
    var productArray:ProductListModal?
    var arrfielddata=[FieldData]()
    var catid:String?
    var categoryId:String?
    var ProductProId:String?
    var sortby=""
    var sort_type=""
    var Productid:String?
    var tag = 0
    var selectedValue = 0
    var Searchtext=""
    var ProductCount=""
    
    var Vctype=""

    
    var adtype=0
    var protype=0
    var procondition=0
    var proguaranty=0
    var city=0
    var procamera=0
    var procapicity=0
    var prosim=0
    var promodal=0
    var prokm=""
    var fromPrice=""
    var toPrice=""
    
    var CheckValue=false
    var pageCount = 1
    private var lastContentOffset: CGFloat = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    
    var selctlang = ""
    
    var sortByArray = ["Title A to Z".localized(),"Title Z to A".localized(),"Price Low to High".localized(),"Price High to Low".localized()]
    var filtercolor = ["#3A86FF",
        "#1597BB",
       "#49C235",
        "#8338EC",
        "#F2096E",
        "#2009f2",
       "#f2a009",
        "#da042a"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.Vctype=="true" || self.Vctype=="false" || self.Vctype == "right"{
            lblcategorytext.text = "Search data".localized()
        }else if self.Vctype=="banner"{
            lblcategorytext.text = "Banner(List)".localized()
        }
        else{
            lblcategorytext.text = "\(Subcatname ?? "")(\(Brandname ?? ""))"
        }
        
        Settext()
        
        obj.prefs.set(Subcatid, forKey: AppSubCatId)
        obj.prefs.set(categoryId, forKey: Appcatid)
        
        
        if Localize.currentLanguage() == "en" {
            self.btnback.transform=CGAffineTransform(rotationAngle:0)
        }else{
            self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
            
        }
        
        DispatchQueue.main.async {
            if self.Vctype == "true" || self.Vctype=="Subcat" || self.Vctype=="right" {
                self.FilterCollectionHeightConstraint.constant=0
            }else{
                self.FilterCollectionHeightConstraint.constant=40
            }
        }
        
        print(Subcatname)
        itemCollectionview.isHidden = true
        itemTableview.isHidden = false
        sortView.isHidden = true
        sortView_HC.constant = 0
        self.getProductList()
        self.getFilterData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("Detail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtMethod(notification:)), name: Notification.Name("DetailText"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapCategory(notification:)), name: Notification.Name("CatID"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapResetFilter(notification:)), name: Notification.Name("ResetFilter"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapDismisVC(notification:)), name: Notification.Name("CheckValue"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapSearch(notification:)), name: Notification.Name("Search"), object: nil)
        
        
        Btntable.tintColor = .black
        BtnCollection.tintColor = .lightGray
        
        //        itemCount.text = "\(productArray?.data.total ?? "") Product"
        // Do any additional setup after loading the view.
    }
    
//    @objc func methodOfReceivedNotification(notification: Notification) {
//        let vc = AddTagListViewController.instance(.newAdTab) as! AddTagListViewController
////        vc.dic = (notification.userInfo!["dic"]!) as! [FieldData]
////        vc.selectedString = (notification.userInfo!["Value"]!) as! String
//        self.show(vc, sender: nil)
//    }
    
    func Settext(){
        lblsorybyhint.text="Sort By".localized()
        lblproducthint.text="Product List".localized()
        lblcategorynohint.text="This Category has no posted ads now.".localized()
    }
    
    
    @objc func didTapDismisVC(notification: Notification) {
        CheckValue = (notification.userInfo!["check"] as? Bool ?? false)
         MainCatName = (notification.userInfo!["CatName"] as? String ?? "")
    }
    @objc func didTapSearch(notification: Notification) {
        CheckValue = (notification.userInfo!["check"] as? Bool ?? false)
         MainCatName = (notification.userInfo!["CatName"] as? String ?? "")
    }
       
    @objc func didTapCategory(notification: Notification) {
        categoryId = (notification.userInfo!["CatID"] as? String ?? "")
        Subcatid=""
        self.getProductList()
        itemTableview.reloadData()
        itemCollectionview.reloadData()
    }
    
    @objc func didTapResetFilter(notification: Notification) {
        
        adtype=0
        protype=0
        procondition=0
        proguaranty=0
        city=0
        promodal=0
        prokm=""
        fromPrice=""
        toPrice=""
        
        procamera=0
        procapicity=0
        prosim=0
        Subcatid = obj.prefs.value(forKey: AppSubCatId) as? String
        categoryId = obj.prefs.value(forKey: Appcatid) as? String
        getProductList()
        
    }
    
    
     @objc func methodOfReceivedNotification(notification: Notification) {
        
        promodal = (notification.userInfo!["promodal"] as? Int ?? 0)
        adtype = (notification.userInfo!["adtype"] as? Int ?? 0)
        protype = (notification.userInfo!["protype"] as? Int ?? 0)
        procondition = (notification.userInfo!["procondition"] as? Int ?? 0)
        proguaranty = (notification.userInfo!["proguaranty"] as? Int ?? 0)
        city = (notification.userInfo!["city"] as? Int ?? 0)
        categoryId = (notification.userInfo!["catId"] as? String ?? "")
        Subcatid = (notification.userInfo!["subCatId"] as? String ?? "")
        prosim = (notification.userInfo!["prosim"] as? Int ?? 0)
        procamera = (notification.userInfo!["procamera"] as? Int ?? 0)
        procapicity = (notification.userInfo!["procapicity"] as? Int ?? 0)
        self.getProductList()
        
    }
    
    @objc func txtMethod(notification: Notification) {
       
        prokm = (notification.userInfo!["prokm"] as? String ?? "")
        fromPrice = (notification.userInfo!["from"] as? String ?? "")
        toPrice = (notification.userInfo!["to"] as? String ?? "")
        self.getProductList()

    }
    
    
    
    @IBAction func Btnsearch(_ sender: Any) {
       
        let vc = SearchSuggestionViewController.instance(.homeTab) as! SearchSuggestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func BtnMapAction(_ sender: Any) {
      
        let vc = MapViewController.instance(.homeTab) as! MapViewController
        vc.Subcatid=Subcatid
        vc.categoryId=categoryId
        vc.ProductProId=ProductProId
        vc.Searchtext=""
        vc.adtype=adtype
        vc.protype=protype
        vc.procondition=procondition
        vc.proguaranty=proguaranty
        vc.city=city
        vc.procamera=procamera
        vc.procapicity=procapicity
        vc.prosim=prosim
        vc.promodal=promodal
        vc.prokm=prokm
        vc.fromPrice=fromPrice
        vc.toPrice=toPrice

        self.show(vc, sender: nil)
    }
    
    
    @IBAction func didTapSortButton(_ sender: UIButton) {
      
        if  tag == 0 {
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.sortView_HC.constant = 140
                self.sortView.isHidden = false
                self.tag = 1
            })
        } else {
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.sortView_HC.constant = 0
                self.sortView.isHidden = true
                self.tag = 0
            })
        }
    }
    
    @IBAction func didTapTableFormateButton(_ sender: Any) {
        selectedValue = 0
        itemTableview.isHidden = false
        itemCollectionview.isHidden = true
        Btntable.tintColor = .black
        BtnCollection.tintColor = .lightGray
        NoCategoryView.isHidden=true
    }
    
    @IBAction func didTapCollectionFormateButton(_ sender: Any) {
        selectedValue = 1
        itemTableview.isHidden = true
        itemCollectionview.isHidden = false
         NoCategoryView.isHidden=true
        Btntable.tintColor = .lightGray
        BtnCollection.tintColor = .black
    }
    
    @IBAction func didTapFilterButton(_ sender: Any) {
       
        let vc = DetailFilterMenuVC.instance(.homeTab) as! DetailFilterMenuVC
        vc.Subcatid = Subcatid
        vc.Subcatname = Subcatname
        vc.MainCatName=MainCatName
        vc.CategoryId=maincatid
        vc.SelectedValue=CheckValue
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .flipHorizontal
    
        vc.SubCategoryCallBack = { (SelectedSubCatId: String) in
            self.Subcatid = SelectedSubCatId
            self.getProductList()
            self.itemTableview.reloadData()
            self.itemCollectionview.reloadData()
        }
        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func SelectAddLanguage(Sender:UIButton){
      
        let cell = itemTableview.cellForRow(at: IndexPath(row: Sender.tag, section: 0)) as! ItemTableCell
        
        if Sender.titleLabel?.text == "English"{
           selctlang="en"
        }else if Sender.titleLabel?.text == "عربي"{
         selctlang="ar"
        }else if Sender.titleLabel?.text == "كوردى".localized(){
           selctlang="ku"
        }else if selctlang == "" {
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
         vc.productId = productArray?.data.productList[Sender.tag].id ?? ""
         vc.vctype="Detail"
         self.navigationController?.pushViewController(vc, animated: true)
        }
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
        vc.productId = productArray?.data.productList[Sender.tag].id ?? ""
        vc.vctype="Detail"
//        let arraystr = (productArray?.data.productList[Sender.tag].langReturn[Sender.tag])
//        print(arraystr)
        vc.langadd=selctlang
        self.navigationController?.pushViewController(vc, animated: true)
                   
    }
}

extension DetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == sortByTableview {
            return self.sortByArray.count
        } else {
            return productArray?.data.productList.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == sortByTableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortbyTableCell", for: indexPath) as! SortbyTableCell
            cell.lbl.text = sortByArray[indexPath.row]
            
            cell.separatorInset = .zero
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableCell
            
            if productArray?.data.productList[indexPath.row].langReturn.contains("en") ?? false && productArray?.data.productList[indexPath.row].langReturn.contains("ar") ?? false {
                cell.languageview.isHidden=false
                cell.Btnenglish.setTitle("English", for: .normal)
                cell.Btnarabic.setTitle("عربي", for: .normal)
            }else if productArray?.data.productList[indexPath.row].langReturn.contains("en") ?? false{
                cell.languageview.isHidden=false
                cell.Btnenglish.setTitle("English", for: .normal)
                cell.Btnarabic.isHidden=true
            }
            
            else if productArray?.data.productList[indexPath.row].langReturn.contains("ar") ?? false{
                cell.languageview.isHidden=false
                cell.Btnarabic.setTitle("عربي", for: .normal)
                cell.Btnenglish.isHidden=true
            } else if productArray?.data.productList[indexPath.row].langReturn.contains("ku") ?? false{
                cell.languageview.isHidden=false
                cell.Btnarabic.isHidden=true
                cell.Btnenglish.isHidden=false
                cell.Btnenglish.setTitle("كوردى", for: .normal)
                
            }else{
                cell.languageview.isHidden=true
            }
            
            
            
            cell.Btnarabic.tag=indexPath.row
            cell.Btnenglish.tag=indexPath.row
            cell.Btnarabic.addTarget(self, action: #selector(SelectAddLanguage(Sender:)), for: .touchUpInside)
            cell.Btnenglish.addTarget(self, action: #selector(SelectAddLanguage(Sender:)), for: .touchUpInside)
            
            
            
            if productArray?.data.productList[indexPath.row].featured == "1" {
                cell.lblfeatured.text="Featured".localized()
            }else{
                cell.lblfeatured.isHidden=true
            }
            cell.lblIQD.text = "\(productArray?.data.productList[indexPath.row].price ?? "") IQD"
            cell.lblEye.text = productArray?.data.productList[indexPath.row].totalview ?? ""
            cell.lblComment.text = productArray?.data.productList[indexPath.row].totalComment ?? ""
            cell.lblMessage.text = productArray?.data.productList[indexPath.row].title ?? ""
            if productArray?.data.productList[indexPath.row].gallery.count ?? 0 > 0 {
                if productArray?.data.productList[indexPath.row].gallery[0].fileType == "0"{
                    let url = URL(string:productArray?.data.productList[indexPath.row].gallery[0].url ?? "")
                    if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                        cell.itemImage?.image = thumbnailImage
                    }
                }else{
                    cell.itemImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.itemImage.sd_setImage(with: URL(string: productArray?.data.productList[indexPath.row].gallery[0].url ?? ""), placeholderImage: UIImage(named: ""))
                }
            }
            
            
            
            //             if self.productArray?.data.productList[indexPath.row].gallery.count ?? 0 > 0{
            //
            //                            if productArray?.data.productList[indexPath.row].gallery[0].fileType == "0" {
            //                let url = URL(string:productArray?.data.productList[indexPath.row].gallery[0].url ?? "")
            //                    if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
            //                                         cell.itemImage?.image = thumbnailImage
            //                                     }else{
            //
            //                                }
            //                        }
            //            //            cell.lbl.text = arry[indexPath.row]
            //
            //                    }
            
            
            return cell
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
           // print("this is the last cell")
            
            
            self.itemTableview.tableFooterView = spinner
            self.itemTableview.tableFooterView?.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.spinner.isHidden = true
                self.itemTableview.tableFooterView?.isHidden = true
                
            }
            
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sortByTableview {
            return 35
        } else {
            return 120
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView == sortByTableview {
        if indexPath.row == 0 {
           sort_type="asc"
           sortby="title"
           sortView.isHidden=true
           self.tag = 0
        }else if indexPath.row == 1 {
            sort_type="desc"
            sortby="title"
            sortView.isHidden=true
            self.tag = 0
        }else if indexPath.row == 2 {
            sort_type="asc"
            sortby="price"
            sortView.isHidden=true
            self.tag = 0
        }else  if indexPath.row == 3{
            sort_type="desc"
            sortby="price"
            sortView.isHidden=true
            self.tag = 0
        }
        getProductList()
         }else{
        //if productArray?.data.productList[indexPath.row].id ?? "" == 
            if productArray?.data.productList[indexPath.row].langReturn == [] {
           let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
            vc.productId = productArray?.data.productList[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        

    }
    
}



extension DetailVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       lastContentOffset = scrollView.contentOffset.y
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if lastContentOffset < scrollView.contentOffset.y {
            pageCount = pageCount + 1
            if pageCount <= Int(productArray?.data.lastPage ?? "") ?? 0 {
                print(pageCount)
                    self.didScrollGetData(page: self.pageCount)
            }
        }
    }
}




extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionview {
        
            return arrfielddata.count
        
        } else {
            return productArray?.data.productList.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionview {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterColletionviewCell", for: indexPath) as! FilterColletionviewCell
            cell.lbl.text=arrfielddata[indexPath.row].title
            cell.lbl.backgroundColor = UIColor(hex: filtercolor[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionviewCell", for: indexPath) as! ItemCollectionviewCell
            cell.lbladdavailablehint.text="This Ad is Available in".localized()
            
            if productArray?.data.productList[indexPath.row].langReturn.contains("en") ?? false && productArray?.data.productList[indexPath.row].langReturn.contains("ar") ?? false {
                cell.languageview.isHidden=false
                cell.btnenglish.setTitle("English", for: .normal)
                cell.btnarabic.setTitle("عربي", for: .normal)
                
            }else if productArray?.data.productList[indexPath.row].langReturn.contains("en") ?? false{
                cell.languageview.isHidden=false
                cell.btnenglish.setTitle("English", for: .normal)
                cell.btnarabic.isHidden=true
            }
            else if productArray?.data.productList[indexPath.row].langReturn.contains("ar") ?? false{
                cell.languageview.isHidden=false
                cell.btnarabic.setTitle("عربي", for: .normal)
                 cell.btnenglish.isHidden=true
            } else if productArray?.data.productList[indexPath.row].langReturn.contains("ku") ?? false{
                           cell.languageview.isHidden=false
                            cell.btnarabic.isHidden=true
                             cell.btnenglish.isHidden=false
                cell.btnenglish.setTitle("Kurdish".localized(), for: .normal)
               
            }else{
                cell.languageview.isHidden=true
            }
            
            
            if productArray?.data.productList[indexPath.row].featured == "1" {
                cell.lblfeatured.text="Featured".localized()
            }else{
                cell.lblfeatured.isHidden=true
            }
            cell.lblIQD.text = "\(productArray?.data.productList[indexPath.row].price ?? "") IQD"
            cell.lblComment.text = productArray?.data.productList[indexPath.row].totalComment
            cell.lblMessage.text = productArray?.data.productList[indexPath.row].title
            
            
            
        
             
        if productArray?.data.productList[indexPath.row].gallery.count ?? 0 > 0 {
                if productArray?.data.productList[indexPath.row].gallery[0].fileType == "0"{
            let url = URL(string:productArray?.data.productList[indexPath.row].gallery[0].url ?? "")
                if let thumbnailImage = ThumbNail.getThumbnailFromFile(url!) {
                        cell.itemImage?.image = thumbnailImage
                    }
                }else{
                     cell.itemImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.itemImage.sd_setImage(with: URL(string: productArray?.data.productList[indexPath.row].gallery[0].url ?? ""), placeholderImage: UIImage(named: ""))
                }
            }
            
            
            
//            cell.lblEye.text = productArray?.data.productList[indexPath.row].totalView ?? ""

                
        
        return cell
    }
         }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionview {
            adtype=arrfielddata[indexPath.row].id
            getProductList()
        }else{
        let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
            vc.productId = productArray?.data.productList[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionview {
            return CGSize(width: (filterCollectionview.frame.width/2.8), height: filterCollectionview.frame.size.height)
        } else {
            let cellwidth = itemCollectionview.frame.width/2
            return CGSize(width: cellwidth - 5, height: cellwidth + 20)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == filterCollectionview {
            return 0
        } else {
            return 8
        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//         let lastSectionIndex = collectionView.numberOfSections - 1
//               let lastRowIndex = collectionView.numberOfItems(inSection: lastSectionIndex)-1
//
//               if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//                  // print("this is the last cell")
//
//
//                   self.itemCollectionview.footeview = spinner
//                   self.itemTableview.tableFooterView?.isHidden = false
//
//                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                       self.spinner.isHidden = true
//                       self.itemTableview.tableFooterView?.isHidden = true
//
//                   }
//
//        }
//    }
//
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == filterCollectionview{
            return 0
        } else {
            return 8
        }
    }
}


extension DetailVC{
    func getProductList(){
         let dictParam =        ["ad_type":adtype,
                                "pro_type":protype,
                                "pro_model": promodal,
                                "pro_condition":procondition,
                                "pro_guaranty":proguaranty,
                                "pro_km":prokm,
                                "city":city,
                                "pro_sim":prosim,
                                "pro_capacity":procapicity,
                                "pro_camera":procamera,
                                "location":"",
                                "lat":"",
                                "long":"",
                                "price_from":fromPrice,
                                "price_to": toPrice,
                                "page":pageCount,
                                "subcategory": Subcatid ?? "",
                                "category": categoryId ?? "",
                                "per_page":"10",
                                "sort":sortby,
                                "sort_type":sort_type,
                                "search_keyword":Searchtext,
                                "product_id":ProductProId ?? ""] as [String : Any]
               print(dictParam)
        ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: ProductListUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: ProductListModal.self, success: { [self] (ResponseJson, resModel, st) in
                let stCode = ResponseJson["status_code"].int
                let strMessage = ResponseJson["message"].string
            print(ResponseJson)
                if stCode == 200{
                    self.productArray = resModel
//                    if self.CountBool == true {
//                        self.itemCount.text = "\(self.ProductCount) Product"
//                    }else{
//                    self.itemCount.text = "\(self.productArray?.data.productList.count ?? 0) Product"
//                    }
                    let text = "Product".localized()
                    self.itemCount.text = "\(self.productArray?.data.total ?? "") \(text)"
                    if self.productArray?.data.productList.count == 0 {
                        self.itemCollectionview.isHidden=true
                        self.itemTableview.isHidden=true
                        self.NoCategoryView.isHidden=false
                    }else{
                        
                        if self.selectedValue == 0 {
                            self.itemCollectionview.isHidden=true
                            
                            self.itemTableview.isHidden=false
                        }else{
                            self.itemCollectionview.isHidden=false
                          
                            self.itemTableview.isHidden=true
                        }
                       
                        self.NoCategoryView.isHidden=true
                    self.itemCollectionview.reloadData()
                    self.itemTableview.reloadData()
                      //  self.itemCount.text = "\(self.ProductCount) Product"
                    }
                }else{
                    self.itemTableview.reloadData()
                    self.itemCollectionview.reloadData()
                    
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
    
        func getFilterData(){
            let dictParam = ["sub_cat":catid ?? ""]
    

            print(dictParam)
                ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: GetOptionList, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: SlideListModal.self, success: { (ResponseJson, resModel, st) in
                    let stCode = ResponseJson["status_code"].int
                    let strMessage = ResponseJson["message"].string
                    print(ResponseJson)
                    if stCode == 200{
                        self.listArray = resModel
                        
                        for i in 0...(self.listArray?.data?.count ?? 1)-1 {
                            if self.listArray?.data?[i].fieldName == "ad_type"{
                                self.arrfielddata=self.listArray?.data?[i].dataItams ?? [FieldData]()
                                
                            }
                        }
                        
                        self.filterCollectionview.reloadData()
                    }else{
                        self.filterCollectionview.reloadData()
                        
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
    
     func didScrollGetData(page : Int){
            let dictParam = ["ad_type":adtype,
            "pro_type":protype,
            "pro_model": promodal,
            "pro_condition":procondition,
            "pro_guaranty":proguaranty,
            "pro_km":prokm,
            "city":city,
            "pro_sim":prosim,
            "pro_capacity":procapicity,
            "pro_camera":procamera,
            "location":"",
            "lat":"",
            "long":"",
            "price_from":fromPrice,
            "price_to": toPrice,
            "page":page,
            "subcategory": Subcatid ?? "",
            "category": categoryId ?? "",
            "per_page":"10",
            "sort":sortby,
            "sort_type":sort_type,
            "search_keyword":Searchtext,
            "product_id":ProductProId ?? ""] as [String : Any]

            
            ApiManager.apiShared.sendNewRequestServerPostWithHeaderModel(url: ProductListUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: ProductListModal.self, success: { [self] (ResponseJson, resModel, st) in
                    let stCode = ResponseJson["status_code"].int
                    let strMessage = ResponseJson["message"].string
                    if stCode == 200{
                self.productArray?.data.productList.append(contentsOf: resModel.data.productList)
                        let text  = "Product".localized()
                self.itemCount.text = "\(self.productArray?.data.total ?? "") \(text)"
                        self.itemCollectionview.reloadData()
                        self.itemTableview.reloadData()
                    }else{
                        self.itemTableview.reloadData()
                        self.itemCollectionview.reloadData()
                        
                       self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                        })
                    }
                }) { (stError) in
    //                self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
    //                    self.dismiss(animated: true, completion: nil)
    //                }
                }
            }
    
    }


