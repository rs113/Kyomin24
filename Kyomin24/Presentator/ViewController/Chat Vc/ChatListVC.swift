//
//  ChatListVC.swift
//  Zeed
//
//  Created by emizen on 12/01/21.
//  Copyright © 2021 emizen. All rights reserved.
//

import UIKit
import Localize_Swift

var onlineStatus=false

class ChatListView: UIViewController {
    
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var lblMainTitle: UILabel!
     @IBOutlet weak var ProductSearchbar: UISearchBar!
    
    fileprivate var tableItems:[ChatRoomModel] = []
    fileprivate var FilteredData:[ChatRoomModel] = []
    
    static var userDetailsList: [String: UserDetailsModel] = [:]
    
    var NoDataView:NoDataScreen?
    var tmpunread=[String:Any]()
    var vctype=""
    var countvalue=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tableItems.count)
        
        
        setTextAccordingLanguage()
        //       SocketManager.shared.connectSocket(notify: true)
        
        tblChat.tableFooterView = UIView()
        NoDataView = tblChat.ShowCustomNoDataView(noDataMsg: "No chat list found".localized())
         self.dismissKeyboard()
        ProductSearchbar.placeholder="Search".localized()
        ProductSearchbar.delegate=self
        ProductSearchbar.backgroundImage = UIImage()
        
        if Localize.currentLanguage() == "en" {
                   self.btnback.transform=CGAffineTransform(rotationAngle:0)
                          
                      }else{
                      self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
                      }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        ProductSearchbar.text=""
    }
    
    
    
    func setTextAccordingLanguage(){
        lblMainTitle.text = "Messages".localized()
        
    }
    //MARK:IBActions
    @IBAction func btnBackAction(_ sender: Any) {
        ProductSearchbar.text=""
        self.tabBarController?.selectedIndex=0
        if vctype == "sidemenu"{
         NotificationCenter.default.post(name: NSNotification.Name("sidemenu"), object: nil, userInfo: nil)
         self.navigationController?.popViewController(animated: true)
         }else{
        NotificationCenter.default.post(name: NSNotification.Name("move"), object: nil, userInfo: nil)
        self.navigationController?.popViewController(animated: true)
         }
        
        
        
//        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  obj.prefs.value(forKey: APP_IS_LOGIN) as? String != "1"{
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 0
            }
            self.showCustomPopupViewAction(altMsg:"Please login first".localized(), alerttitle: "Info!".localized(), alertimg: UIImage(named: "Infoimg") ?? UIImage(), btnText: "CONFIRM".localized(), OkAction: {popup in
                popup.dismiss(animated: true, completion: {
                    self.log_Out_from_App()
                    
                })
            })
        }else{
            self.tabBarController?.tabBar.isHidden = false
            SocketManager.shared.registerToScoket(observer: self )
            let json: [String: Any] = ["request": "room",
                                       "type": "allRooms",
                                       "userList":[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]
                
            ]
            if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
                SocketManager.shared.sendMessageToSocket(message: jsonString as String)
            }
        }
        
    }
    
    
    func dismissKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:self, action:    #selector(ChatListView.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
        @objc private func dismissKeyboardTouchOutside() {
           view.endEditing(true)
        }
    
    
    
    
    
    
}
extension ChatListView:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  tableItems.count == 0 {
            NoDataView?.isHidden = false
        }else{
            NoDataView?.isHidden = true
        }
        return tableItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTblCell", for: indexPath) as! ChatTblCell
        cell.configData(obj: tableItems[indexPath.row])
        print(tableItems.count)
        

        return cell
    }
    
    
    
    
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let leftAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("leftAction tapped")
//            success(true)
//        })
//
//        leftAction.image = UIImage(named: "deleteChat")
//        leftAction.backgroundColor = .red
//
//        return UISwipeActionsConfiguration(actions: [leftAction])
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: ChatViewController = ChatViewController()
        vc.roomId = "\(tableItems[indexPath.row].id)"
        let value:[String:Any] = tableItems[indexPath.row].tmpunread
        if let valuecount = value[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]{
            vc.readcount=valuecount as? Int ?? 0
        }
        
    
        if let individualDetail: UserDetailsModel = ChatListView.userDetailsList[tableItems[indexPath.row].individualUserId] {
            vc.individualDetail = individualDetail
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//     // MARK: - Searchbar delegate
//    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    let newStr = NSString(string: searchBar.text ?? "").replacingCharacters(in: range, with: text)
//
//        if newStr == ProductSearchbar.text {
//
//              FilteredData=tableItems
//                tblChat.reloadData()
//            }else {
//
//               FilteredData=tableItems
//
//        let filter = self.FilteredData.filter({( ChatListView.userDetailsList[$0.individualUserId]?.firstName.localizedCaseInsensitiveContains(newStr)) ?? false })
//
//               self.FilteredData=filter
//               DispatchQueue.main.async {
//               //self.tblChat.reloadData()
//               }
//
//        }
//
//       return true
//
//
//
//    }
//
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//         if searchText == "" {
//
//           FilteredData=tableItems
//             tblChat.reloadData()
//         }else {
//
//            FilteredData=tableItems
//
//     let filter = self.FilteredData.filter({( ChatListView.userDetailsList[$0.individualUserId]?.firstName.localizedCaseInsensitiveContains(searchText)) ?? false })
//
//            self.FilteredData=filter
//            DispatchQueue.main.async {
//            //self.tblChat.reloadData()
//            }
//
//
//
//
//
//
//
//         }
//
//     }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//             FilteredData=tableItems
//             searchBar.text = ""
//             tblChat.reloadData()
//    }
//
    
}
extension ChatListView: SocketObserver {
    func registerFor() -> [ResponseType] {
        return [.allRooms, .roomsModified,. userModified, .createRoom]
    }
    
    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        
        print(data)
        
       
        
        if (observerWithIdentifire == .allRooms){
            if let data = data["data"] as? [String: Any]{
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                
                tmpUserList.forEach { (element) in
                    ChatListView.userDetailsList[element.userId] = element
                }
                
                
                
                tableItems = ChatRoomModel.giveList(list: data["roomList"] as? [[String: Any]] ?? [] )
                FilteredData = ChatRoomModel.giveList(list: data["roomList"] as? [[String: Any]] ?? [] )
                 
                countvalue = 0
                
                for i in 0..<(tableItems.count){
                    
                    let value:[String:Any] = tableItems[i].tmpunread
                    if let valuecount = value[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]{
                        countvalue += valuecount as? Int ?? 0
                    }
                    
                }
                
                if countvalue != 0 {
                    tabBarController?.tabBar.addBadge(index: 3)
                }else{
                    tabBarController?.tabBar.removeBadge(index: 3)
                }
                
                
            }
            tblChat.reloadData()
        } else if (observerWithIdentifire == .roomsModified){
            if let data = data["data"] as? [String: Any] {
                //                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                //
                //                tmpUserList.forEach { (element) in
                //                    RoomListViewController.userDetailsList[element.userId] = element
                //                }
                //
                //
                
                
                let updatedRoom = ChatRoomModel(disc: data)
                
                tableItems = tableItems.map { (element) -> ChatRoomModel in
                    var elementX = element
                    if (element.id == updatedRoom.id){
                        elementX = updatedRoom
                    }
                    
                    return elementX
                    
                }
                
                
                countvalue = 0
                
                for i in 0 ... (tableItems.count)-1{
                    let value:[String:Any] = tableItems[i].tmpunread
                    if let valuecount = value[obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""]{
                        countvalue += valuecount as? Int ?? 0
                    }
                    
                }
                
                if countvalue != 0 {
                    tabBarController?.tabBar.addBadge(index: 3)
                }else{
                    tabBarController?.tabBar.removeBadge(index: 3)
                }
                
                

                
                tblChat.reloadData()
                
                
            }
        } else if (observerWithIdentifire == .createRoom){
            if let data = data["data"] as? [String: Any] {
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                
                tmpUserList.forEach { (element) in
                    ChatListView.userDetailsList[element.userId] = element
                }
                if let newRoom = data["newRoom"] as? [String: Any] {
                    let updatedRoom = ChatRoomModel(disc: newRoom)
                    tableItems.append(updatedRoom)
                    FilteredData.append(updatedRoom)
                }
                
                
                
                //                tableItems = tableItems.map { (element) -> ChatRoomModel in
                //                    var elementX = element
                //                    if (element.id == updatedRoom.id){
                //                        elementX = updatedRoom
                //                    }
                //
                //                    return elementX
                //
                //                }
                
                
                tblChat.reloadData()
                
                
            }
        } else if observerWithIdentifire == .userModified {
            print("ChatViewController", observerWithIdentifire, message)
            if (statusCode == 200){
                if let data: [String : Any] = data["data"] as? [String: Any] {
                    let updatedUserInfo = UserDetailsModel.giveObj(cdic: data)
                    ChatListView.userDetailsList[updatedUserInfo.userId] = updatedUserInfo
                    tblChat.reloadData()
                }
            }
        }
    }
    
    func socketConnection(status: SocketConectionStatus) {
        print("websocket connected!!")
    }
    
    
    
}


//MARK: - UITableViewDataSource And Delegate
extension ChatListView:UISearchBarDelegate {


    // MARK: - Searchbar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {

          FilteredData=tableItems
            tblChat.reloadData()
        }else {

           //FilteredData=tableItems


    let filter = self.FilteredData.filter({( ChatListView.userDetailsList[$0.individualUserId]?.firstName.localizedCaseInsensitiveContains(searchText)) ?? false })

             self.FilteredData=filter
            DispatchQueue.main.async {
                self.tblChat.reloadData()
            }
        }

    }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            FilteredData=tableItems
            searchBar.text = ""
            tblChat.reloadData()
        }





    }


