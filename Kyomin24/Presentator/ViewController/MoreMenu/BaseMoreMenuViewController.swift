//
//  BaseMoreMenuViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 01/07/21.
//

import UIKit

class BaseMoreMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    

//    func openSideMenu() {
//        SideMenuView.initialize { [weak self] (selection) in
//
//            guard let weakSelf = self else { return }
//            switch selection {
//            case .addAdvertise:
//                let vc = SelectAdTypeViewController.instance(.newAdTab) as! SelectAdTypeViewController
//                weakSelf.navigationController?.setViewControllers([vc], animated: true)
//
//            case .myAdd:
//                let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
//                weakSelf.navigationController?.pushViewController(vc, animated: true)
//
//                //                let myAddVC = MyAddViewController.instance(.moreMenu) as! MyAddViewController
//                //                weakSelf.navigationController?.setViewControllers([myAddVC], animated: true)
//                //
//
//            case .favorite:
//                let favoriteVC = FavoriteViewController.instance(.moreMenu) as! FavoriteViewController
//                //self?.navigationController?.pushViewController(favoriteVC, animated: true)
//                weakSelf.navigationController?.setViewControllers([favoriteVC], animated: true)
//
//
//            case .follow:
//
//                let followVC = FollowViewController.instance(.moreMenu) as! FollowViewController
//                weakSelf.navigationController?.setViewControllers([followVC], animated: true)
//
//            case .block:
//                let followVc = BlockUserViewController.instance(.moreMenu) as! BlockUserViewController
//                weakSelf.navigationController?.setViewControllers([followVc], animated: true)
//
//            case .chat:
//                break
//
//            case .support:
//                break
//
//            case .language:
//                let aboutVC = SelectlanguageView.instance(.newAdTab) as! SelectlanguageView
//                weakSelf.navigationController?.setViewControllers([aboutVC], animated: true)
//
//            case .mode:
//                break
//
//            case .about:
//                let aboutVC = AboutViewController.instance(.moreMenu) as! AboutViewController
//                weakSelf.navigationController?.setViewControllers([aboutVC], animated: true)
//
//            case .share:
//
//                let shareVC = ShareViewController.instance(.moreMenu) as! ShareViewController
//                weakSelf.navigationController?.setViewControllers([shareVC], animated: true)
//
//            case .privacy:
//                let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
//                vc.viewFrom = .privacy
//                weakSelf.navigationController?.setViewControllers([vc], animated: true)
//            case .terms:
//                let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
//                vc.viewFrom = .terms
//                weakSelf.navigationController?.setViewControllers([vc], animated: true)
//
//            default:
//                break
//            }
//        }
//    }
    
}
