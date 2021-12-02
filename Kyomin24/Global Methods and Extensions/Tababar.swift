//
//  Tababar.swift
//  Mzadi
//
//  Created by Emizentech on 18/08/21.
//
import UIKit


class TabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
         var sizeThatFits = super.sizeThatFits(size)
         sizeThatFits.height = 80
         
         return sizeThatFits
     }
}

//import UIKit
//
//class CustomTabBar : UITabBar {
//    @IBInspectable var height: CGFloat = 0.0
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        if height > 0.0 {
//            sizeThatFits.height = height
//        }
//        return sizeThatFits
//    }
//}
