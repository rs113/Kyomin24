//
//  ProductDetailViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 13/07/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var consTblHeight: NSLayoutConstraint!
    
    var arrProductDetail = [ProductDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
    }
    
    func setData() {
        arrProductDetail.append(ProductDetail(title: "Category", value: "Vehicle"))
        arrProductDetail.append(ProductDetail(title: "Subcategory", value: "Car"))

        arrProductDetail.append(ProductDetail(title: "Ad Tag", value: "Sale"))

        arrProductDetail.append(ProductDetail(title: "Meterial", value: "Metal"))
        arrProductDetail.append(ProductDetail(title: "Pattern", value: "Smooth"))
        arrProductDetail.append(ProductDetail(title: "Scarcity", value: "Rare"))
        arrProductDetail.append(ProductDetail(title: "Condition", value: "Excellent"))
        arrProductDetail.append(ProductDetail(title: "City", value: "Baghdad"))
        consTblHeight.constant = CGFloat(arrProductDetail.count * 44)
       // tblList.layoutIfNeeded()
    
    }
    
    //MARK: - Action
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: collectionView.bounds.size.width / 1 , height: 500)
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

    }


}

extension ProductDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfoCollectionViewCell", for: indexPath) as! ProductInfoCollectionViewCell
        return cell
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDetailTableViewCell.self), for: indexPath) as! ProductDetailTableViewCell
        //cell.setData(chatDict: arrChat[indexPath.row])
        cell.lblTitle.text = arrProductDetail[indexPath.row].title
        cell.lblValue.text = arrProductDetail[indexPath.row].value
        return cell
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // did select on table row
    }
}


struct ProductDetail {
    var title: String
    var value: String
    
}
