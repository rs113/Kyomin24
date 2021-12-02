//
//  Helper.swift
//  Recipe
//
//  Created by MacMini on 09/01/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

 struct Helper {
    
    static var safeAreaBottomMargine: CGFloat {
        get {
            if let window = UIApplication.shared.keyWindow {
                if #available(iOS 11.0, *) {
                    return window.safeAreaInsets.bottom
                }
            }
            return 0
        }
    }

    static var safeAreaTopMargine: CGFloat {
        get {
            if let window = UIApplication.shared.keyWindow {
                if #available(iOS 11.0, *){
                    return window.safeAreaInsets.top
                }
            }
            return 0
        }
    }
  
}

