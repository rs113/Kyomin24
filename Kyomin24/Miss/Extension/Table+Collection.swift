//
//  Table+Collection.swift
//  Mzadi
//
//  Created by MacBook on 07/06/21.
//

import Foundation
import UIKit

//MARK:- UITableView Extension
extension UITableView {
    func reloadDataInMain() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func displayBackgroundText(text: String, fontStyle: String = "HelveticaNeue", fontSize: CGFloat = 16.0) {
        let lbl = UILabel();
        
        if let headerView = self.tableHeaderView {
            lbl.frame = CGRect(x: 0, y: headerView.bounds.size.height, width: self.bounds.size.width - 34, height: self.bounds.size.height - headerView.bounds.size.height)
        } else {
            lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        }
        lbl.text = text;
        lbl.textColor = UIColor(red: 59/255, green: 79/255, blue: 91/255, alpha: 1)
        lbl.numberOfLines = 0;
        //lbl.sizeToFit()
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:fontSize);
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    func removeBackgroundText() {
        self.backgroundView = nil
    }
}

//MARK:- UICollectionView Extension
extension UICollectionView {
    func reloadDataInMain() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
  
    func displayBackgroundText(text: String, fontStyle: String = "Helvetica", fontSize: CGFloat = 16.0) {
        let lbl = UILabel();
        lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        lbl.text = text;
        lbl.textColor =  UIColor.red
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:fontSize);
            
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    
    func removeBackgroundText() {
        self.backgroundView = nil
    }
        
    
}
