//
//  BaseTabBarViewController.swift
//  Mzadi
//
//  Created by A Care Indore on 22/06/21.
//

import UIKit
import Localize_Swift
import SideMenu

class BaseTabBarViewController: UITabBarController {
    
    private var middleButton = UIButton()
    var tabSelectedIndex: Int  = 0
    var fetchLanguage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.delegate = self
        
        let selectedColor   = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        NotificationCenter.default.addObserver(self, selector: #selector(opensidemenuback), name:NSNotification.Name("sidemenu"), object: nil)
        //  localizeTabBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tabBar.items?[0].title = "Home".localized()
            self.tabBar.items?[1].title = "My Account".localized()
            self.tabBar.items?[2].title = "New Ad".localized()
            self.tabBar.items?[3].title = "Chat".localized()
            self.tabBar.items?[4].title = "More".localized()
        }
    }
    
    
    @objc func opensidemenuback(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.openSideMenu()
        }
        
    }
    
    func setView() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .black
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    func setTabBarCorner() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.tabBar.frame
        rectShape.position = self.tabBar.center
        rectShape.path = UIBezierPath(roundedRect: self.tabBar.bounds , byRoundingCorners: [.bottomLeft , .bottomRight , .topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .black
        self.tabBar.layer.backgroundColor = UIColor.green.cgColor
        self.tabBar.layer.mask = rectShape
    }
    
    //    func localizeTabBar() {
    //
    //        self.tabBarItem.title = "title"
    //        //tabBarController?.tabBar.items![0].title = "Home".localized()
    //        tabBar.items![1].title = "My Account".localized()
    //        tabBar.items![2].title = "New Ad".localized()
    //        tabBar.items![3].title = "Chat".localized()
    //        tabBar.items![3].title = "More".localized()
    //    }
    //
    
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: self.view.bounds.width, y: -70, width: 100, height: 100))
        middleButton.setBackgroundImage(#imageLiteral(resourceName: "circle 1"), for: .normal)
        middleButton.layer.cornerRadius = 35
        middleButton.layer.masksToBounds = true
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        middleButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.tabBar.insertSubview(middleButton, at: 0)
        self.view.layoutIfNeeded()
    }
    
    @objc func test() {
        print("create post")
    }
    
    
}

extension BaseTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let indexOfTab = tabBar.items?.firstIndex(of: item)
        
        UserDefaults.standard.setValue(selectedIndex, forKey: "tab")
        tabSelectedIndex = indexOfTab!
        
        if indexOfTab == 1 {
            //            let vc = (self.viewControllers![tabSelectedIndex] as! UINavigationController).viewControllers.last as! UIViewController
            if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
                self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                    popup.dismiss(animated: true, completion: {
                        self.log_Out_from_App()
                    })
                })
                //                self.alertShow(tr: "Please login first", msgString: "Message")
                
            }else{
                self.selectedIndex=1
                //                let vc = ProfileViewController.instance(.myAccountTab) as! ProfileViewController
                //                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            
        }
        
        else if indexOfTab == 2 {
            if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
                self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                    popup.dismiss(animated: true, completion: {
                        self.log_Out_from_App()
                    })
                })
                
            }else{
                //   self.selectedIndex=2
                
                let vc = SelectAdTypeViewController.instance(.newAdTab) as! SelectAdTypeViewController
                let navc = self.selectedViewController as? UINavigationController
                navc?.pushViewController(vc, animated: true)
                
            }
            
            
            
        }else if indexOfTab == 3 {
            if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
                self.showCustomPopupViewAction(altMsg:"Please login first", alerttitle: "Info!", alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM", OkAction: {popup in
                    popup.dismiss(animated: true, completion: {
                        self.log_Out_from_App()
                    })
                })
                
            }else{
                self.selectedIndex=3
                //                let vc = ChatViewController.instance(.chatTab) as! ChatViewController
                //                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if indexOfTab == 4 {
            
            DispatchQueue.main.async {
                self.openSideMenu()
            }
            
            
            //            let vc = SideMenuViewController.instance(.homeTab) as! SideMenuViewController
            //            let menu = SideMenuNavigationController(rootViewController: vc)
            //            menu.leftSide = true
            //            menu.menuWidth = self.view.frame.width*0.75
            //            menu.statusBarEndAlpha = 0
            //            menu.presentationStyle = .menuSlideIn
            //            menu.presentationStyle.menuStartAlpha = 0
            //
            //            // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
            //            // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
            //            // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
            //            present(menu, animated: true, completion: nil)
            //
            
            
            
            //
            
            
        }else {
            //tabSelectedIndex = selectedIndex
        }
        //        tabSelectedIndex = selectedIndex
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabSelectedIndex == 1 || tabSelectedIndex == 2 || tabSelectedIndex == 3 || tabSelectedIndex == 4{
            return false
        }
        
        return true
    }
}


extension BaseTabBarViewController {
    
     func openSideMenu() {
        
        SideMenuView.initialize { [weak self] (selection) in
            
            guard let weakSelf = self else { return }
            switch selection {
            case .addAdvertise:
                let vc = SelectAdTypeViewController.instance(.newAdTab) as! SelectAdTypeViewController
                  vc.vctype="sidemenu"
                 let navc = self?.selectedViewController as? UINavigationController
                               navc?.pushViewController(vc, animated: true)
            
            case .myAdd:
                let vc = MyAddViewController.instance(.moreMenu) as! MyAddViewController
                vc.vctype="sidemenu"
                let navc = self?.selectedViewController as? UINavigationController
                    navc?.pushViewController(vc, animated: true)
                
                
            case .favorite:
                let favoriteVC = FavoriteViewController.instance(.moreMenu) as! FavoriteViewController
                favoriteVC.vctype="sidemenu"
                 let navc = self?.selectedViewController as? UINavigationController
                  navc?.pushViewController(favoriteVC, animated: true)
                
                
            case .follow:
                let followVC = FollowViewController.instance(.moreMenu) as! FollowViewController
                followVC.vctype="sidemenu"
                 let navc = self?.selectedViewController as? UINavigationController
                    navc?.pushViewController(followVC, animated: true)
                
//            case .purchase:
//            let followVC = PurchasePlanViewController.instance(.myAccountTab) as! PurchasePlanViewController
//            followVC.vctype="sidemenu"
//             let navc = self?.selectedViewController as? UINavigationController
//                navc?.pushViewController(followVC, animated: true)
//
            case .myplan:
            let followVC = AllPlanViewController.instance(.myAccountTab) as! AllPlanViewController
             followVC.vctype="sidemenu"
             let navc = self?.selectedViewController as? UINavigationController
                navc?.pushViewController(followVC, animated: true)
            case .block:
                  break
//                let followVc = BlockUserViewController.instance(.moreMenu) as! BlockUserViewController
//
//                 let navc = self?.selectedViewController as? UINavigationController
//                               navc?.pushViewController(followVc, animated: true)
                
            case .chat:
               let vc = ChatListView.instance(.chatTab) as! ChatListView
                vc.vctype="sidemenu"
                let navc = self?.selectedViewController as? UINavigationController
                    navc?.pushViewController(vc, animated: true)
                
                
            case .language:
                 DispatchQueue.main.async {
            let aboutVC = SelectlanguageView.instance(.newAdTab) as! SelectlanguageView
            aboutVC.vctype="sidemenu"
            let navc = self?.selectedViewController as? UINavigationController
               navc?.pushViewController(aboutVC, animated: true)
                }
            case .mode:
                break
                
            case .about:
            let aboutVC = AboutViewController.instance(.moreMenu) as! AboutViewController
            aboutVC.vctype="sidemenu"
            let navc = self?.selectedViewController as? UINavigationController
                navc?.pushViewController(aboutVC, animated: true)
                
            case .contact :
                let aboutVC = ContactUsViewController.instance(.moreMenu) as! ContactUsViewController
                aboutVC.vctype="sidemenu"
                let navc = self?.selectedViewController as? UINavigationController
                              navc?.pushViewController(aboutVC, animated: true)
            case .share:
                
                let shareVC = ShareViewController.instance(.moreMenu) as! ShareViewController
                shareVC.vctype="sidemenu"
                let navc = self?.selectedViewController as? UINavigationController
                               navc?.pushViewController(shareVC, animated: true)
                
            case .privacy:
                let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
                vc.viewFrom = .privacy
                vc.vctype="sidemenu"
                let navc = self?.selectedViewController as? UINavigationController
                navc?.pushViewController(vc, animated: true)
            case .terms:
                let vc = TermsViewController.instance(.moreMenu) as! TermsViewController
                vc.viewFrom = .terms
                vc.vctype="sidemenu"
                let navc = self?.selectedViewController as? UINavigationController
                navc?.pushViewController(vc, animated: true)
                //weakSelf.navigationController?.setViewControllers([vc], animated: true)
                
            default:
                break
            }
        }
    }
    
}

