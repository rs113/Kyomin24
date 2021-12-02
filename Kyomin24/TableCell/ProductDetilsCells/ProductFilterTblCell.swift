//
//  ProductFilterTblCell.swift
//  Mzadi
//
//  Created by Emizen tech on 23/08/21.
//

import UIKit
class ProductFilterCollectionCell: UICollectionViewCell{
    @IBOutlet weak var lbl: UILabel!

}
class ProductFilterTblCell: UITableViewCell {

    @IBOutlet weak var collectionview: UICollectionView!
    var filter = [Filter]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionview.dataSource = self
        collectionview.delegate = self
    }

    func config(data: [Filter]){
        filter = data
        collectionview.reloadData()
        viewPrintFormatter()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension ProductFilterTblCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.filter.count)
    
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductFilterCollectionCell", for: indexPath) as! ProductFilterCollectionCell
        cell.lbl.text = filter[indexPath.row].title ?? ""
            return cell
    }
}

extension ProductFilterTblCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionview.frame.size.width, height: collectionview.frame.size.height)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

            return 8
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
    }
}
