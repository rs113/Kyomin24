//
//  UIViewController+Storyboard.swift
//  CommunitySafetyWatch
//
//  Created by ABC on 4/10/18.
//  Copyright © 2018 ABC. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func instance(_ storyboard: Storyboard = .baseTab) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let identifier = NSStringFromClass(self).components(separatedBy: ".").last!
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getSceneDelegate() -> SceneDelegate {
        return self.view.window?.windowScene?.delegate as! SceneDelegate
    }
    
//    func showHud(_ message: String) {
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.label.text = message
//        hud.isUserInteractionEnabled = false
//    }
//
//    func hideHUD() {
//        MBProgressHUD.hide(for: self.view, animated: true)
//    }
}


enum Storyboard: String {
    
    case main = "Main"
    case baseTab = "BaseTab"
    case homeTab = "HomeTab"
    case newAdTab = "NewAd"
    case myAccountTab = "MyAccount"
    case chatTab = "Chat"
    case moreTab = "More"
    case moreMenu = "MoreMenu"
}
