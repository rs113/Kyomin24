//
//  BaseViewController.swift
//  Cosmos
//
//  Created by Mac on 26/11/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class HomeBaseMenuViewController: UIViewController {
    
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func logout() {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to logout from the application?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
           
                       UserDefaults.standard.removeObject(forKey: "token")
                       UserDefaults.standard.removeObject(forKey: "userid")
                       UserDefaults.standard.removeObject(forKey: "location")
                       UserDefaults.standard.removeObject(forKey: "role")
                       UserDefaults.standard.removeObject(forKey: "username")
                       UserDefaults.standard.removeObject(forKey: "email")
                    if let appDomain = Bundle.main.bundleIdentifier{
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
                    let next = LoginViewController.instance(.main) as! LoginViewController
                       self.navigationController?.setViewControllers([next], animated: true)
                   
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func openLeftSideMenu() {
        
        LeftSideMenuView.initialize { [weak self] (selection) in
            
            guard let weakSelf = self else { return }
            
            switch selection {
            
            case .Vehicle:
                
//            let vc = CategoryDetailViewController.instance(.homeTab) as! CategoryDetailViewController
//                //homeVC.item = 0
//                self?.navigationController?.pushViewController(vc, animated: true)
                break
                
            case .Electronic:
                 break
                
            case .RealState:
                break
                
            case .FamilyNeed:
                break
                
            case .Service:
                break
                
            case .AnimalAndBirds:
                break
                
            case .SportsAndFitness:
                 break
                
            case .Travel:
                 break
                
            case .NumberAndPlates:
                break
                
            case .Others:
                break
                
            default:
                break
            }
        }
    }
    
        
//        func openSideMenu() {
//
//            SideMenuView.initialize { [weak self] (selection) in
//
//                guard let weakSelf = self else { return }
//                switch selection {
//                case .addAdvertise:
//                    let vc = SelectAdTypeViewController.instance(.newAdTab) as! SelectAdTypeViewController
//                    weakSelf.navigationController?.setViewControllers([vc], animated: true)
//
//                case .myAdd:
//                    let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
//                    weakSelf.navigationController?.pushViewController(vc, animated: true)
//
//                    //                let myAddVC = MyAddViewController.instance(.moreMenu) as! MyAddViewController
//                    //                weakSelf.navigationController?.setViewControllers([myAddVC], animated: true)
//                    //
//
//                case .favorite:
//                    let favoriteVC = FavoriteViewController.instance(.moreMenu) as! FavoriteViewController
//                    //self?.navigationController?.pushViewController(favoriteVC, animated: true)
//                    weakSelf.navigationController?.setViewControllers([favoriteVC], animated: true)
//
//
//                case .follow:
//
//                    let followVC = FollowViewController.instance(.moreMenu) as! FollowViewController
//                    weakSelf.navigationController?.setViewControllers([followVC], animated: true)
//
//                case .block:
//                    let followVc = BlockUserViewController.instance(.moreMenu) as! BlockUserViewController
//                    weakSelf.navigationController?.setViewControllers([followVc], animated: true)
//
//                case .chat:
//                    break
//
//                case .support:
//                    break
//
//                case .language:
//                    let aboutVC = SelectlanguageView.instance(.newAdTab) as! SelectlanguageView
//                    weakSelf.navigationController?.setViewControllers([aboutVC], animated: true)
//
//                case .mode:
//                    break
//
//                case .about:
//                    let aboutVC = AboutViewController.instance(.moreMenu) as! AboutViewController
//                    weakSelf.navigationController?.setViewControllers([aboutVC], animated: true)
//
//                case .share:
//
//                    let shareVC = ShareViewController.instance(.moreMenu) as! ShareViewController
//                    weakSelf.navigationController?.setViewControllers([shareVC], animated: true)
//
//                case .privacy:
//                    let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
//                    vc.viewFrom = .privacy
//                    weakSelf.navigationController?.setViewControllers([vc], animated: true)
//                case .terms:
//                    let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
//                    vc.viewFrom = .terms
//                    weakSelf.navigationController?.setViewControllers([vc], animated: true)
//
//                default:
//                    break
//                }
//            }
//        }
//
//

}
