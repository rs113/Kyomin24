//
//  SlideMenuView.swift
//  BoltCustomer
//
//  Created by Darshan Mothreja on 2/1/18.
//  Copyright © 2018 Darshan Mothreja. All rights reserved.
//

import UIKit
import Alamofire

enum LeftMenuType {
    case Vehicle
    case Electronic
    case RealState
    case FamilyNeed
    case Service
    case AnimalAndBirds
    case SportsAndFitness
    case Travel
    case NumberAndPlates
    case Others
    case none
}

class LeftSideMenuView: UIView {
    
    //MARK: Properties
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    var callBack: ((LeftMenuType) -> ())!
    var menuList: [MenuSection]!
    
    struct MenuSection {
        var list: [MenuDetail]!
    }
    
    struct MenuDetail {
        var text: String!
        var img: String!
        var type: LeftMenuType!
    }
    
    static var selectIndex : LeftMenuType?
    
    
   
    static func initialize(callBack: @escaping ((LeftMenuType) -> ())) {
        
        let sideView = LeftSideMenuView().loadNib() as! LeftSideMenuView
        sideView.frame = UIScreen.main.bounds
        sideView.configureTableItems()
        sideView.callBack = callBack
        UIApplication.currentViewController()?.view.addSubview(sideView)
        
        sideView.showSideMenu(true)
    }
    
    func configureTableItems() {
        
        menuList = [MenuSection(list: [MenuDetail(text: "Vehicles",img: "quartz_deactive", type: .Vehicle),
                                       MenuDetail(text: "Electronics", img: "quartz_deactive", type: .Electronic),
                                       MenuDetail(text: "Real State", img: "quartz_deactive", type: .RealState),
                                       MenuDetail(text: "Family Needs", img: "inventory_d", type: .FamilyNeed),
                                       MenuDetail(text: "Service", img: "new-arrival-deactive", type: .Service),
                                       MenuDetail(text: "Animal & Brids", img: "offers_deactive", type: .AnimalAndBirds),
                                       MenuDetail(text: "Sport & Fitness", img: "key", type: .SportsAndFitness),
                                       MenuDetail(text: "Travel & Tips", img: "logout", type: .Travel), MenuDetail(text: "Number & Plates", img: "logout", type: .NumberAndPlates),
                                       MenuDetail(text: "Others", img: "logout", type: .Others)])]
        
        tblView.register(UINib(nibName: "LftSideMenuCell", bundle: nil), forCellReuseIdentifier: "LftSideMenuCell")
            
    }
    
    // MARK: Side Menu Animation
    func showSideMenu(_ isShow: Bool) {
        
        self.leftView.frame.origin.x = isShow ? -self.leftView.frame.size.width : 0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8.0, options: .curveEaseIn, animations: ({
            
            self.leftView.frame.origin.x = isShow ? 0 : -self.leftView.frame.size.width
            self.alpha = isShow ? 1 : 0
        }), completion: { completed in
            if !isShow {
                self.removeFromSuperview()
            }
        })
    }
    
    
    
    
    
   
    //MARK: Button Actions
    @IBAction func btnBack_Action(_ sender: Any) {
        self.showSideMenu(false)
    }
    
    //MARK: Tap Gestures
    @IBAction func tapGestureRightView(_ sender: Any) {
        self.showSideMenu(false)
    }
    
}

extension LeftSideMenuView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LftSideMenuCell", for: indexPath) as! LftSideMenuCell
       // cell.lblText.text = ArrMenuProfile?.data?[indexPath.row].title
        cell.lblText.text=menuList[indexPath.section].list[indexPath.row].text
//        if menuList[indexPath.section].list.count == 1 {
//
//            cell.bgView.backgroundColor = UIColor.red
//            cell.lblText.textColor = UIColor.white
//            cell.selectionStyle = .none
//
//        } else if menuList[indexPath.section].list.count < 1 {
//            cell.bgView.backgroundColor = UIColor.white
//            cell.lblText.textColor = UIColor.darkGray
//            cell.selectionStyle = .gray
//        }
        
      // cell.bgView.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
       // cell.imgList.image = UIImage(named: "")
        //cell.lblText.textColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0)

        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (callBack != nil) {
            self.showSideMenu(false)
            LeftSideMenuView.selectIndex = menuList[indexPath.section].list[indexPath.row].type
            callBack(menuList[indexPath.section].list[indexPath.row].type)
        }
    }
    
    
    
    
    
}

