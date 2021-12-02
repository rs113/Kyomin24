//
//  ChatViewController.swift
//  SSNodeJsChat
//
//  Created by Ajit Jain on 24/12/20.
//

import UIKit
import Starscream
import SSViews
import CoreLocation
import Alamofire
//import GooglePlacePicker
import GooglePlaces
import GoogleMaps
import ContactsUI
import AVFoundation
import AVKit
import DKImagePickerController
import Photos 
import QuickLook
import Localize_Swift

enum MessageType: String {
    case text = "TEXT"
    case image = "IMAGE"
    case document = "DOCUMENT"
    case location = "LOCATION"
    case contact = "CONTACT"
    case video = "VIDEO"
    case replay = "REPlAY"
}
enum RecorderState {
    case Pause
    case Play
    case Finish
    case Recording
    case Ready
}


protocol DownloadTableCell {
    func download(progress: Double)
}




class ChatViewController: AppViewController, CNContactViewControllerDelegate, UIGestureRecognizerDelegate {
    
    
    fileprivate static let CHAT_BUNCH_COUNT = 30
    
    @IBOutlet weak var replayTextLabel: UILabel!
    @IBOutlet weak var replayIndicatorWrapper: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeMessage: UITextView!
    
    @IBOutlet weak var recordingTimer: UILabel!
    @IBOutlet weak var attatchmentWrapperView: UIView!
    
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var blockedWrapper: UIView!
    @IBOutlet weak var recordingWrapper: UIView!
    @IBOutlet weak var messageWrapper: UIView!
    @IBOutlet weak var messageComponentWrapper: UIView!
    
    @IBOutlet weak var Btnprofile: UIButton!
    @IBOutlet weak var chatUserProfile: UIImageView!
    @IBOutlet weak var chatUserName: UILabel!
    @IBOutlet weak var chatUserOnlineStatus: UILabel!
    
    //    @IBOutlet weak var commentBoxBottomCons: NSLayoutConstraint!
    //    @IBOutlet weak var sendComponentRightCons: NSLayoutConstraint!
    
    @IBOutlet weak var componentView: UIStackView!
    
    @IBOutlet weak var audioPlayerWrapper: UIView!
    @IBOutlet weak var uploadMediaProgress: UIStackView!
    
    @IBOutlet weak var goToBottomBtn: UIButton!
    
    fileprivate var tableList: [[ChatModel]] = []
    fileprivate var recordingState: RecorderState = .Ready
    
    // 1- Init bottomSheetVC
    
    fileprivate var viewloader: UIView?
    
    
    fileprivate var userLocation: CLLocation?
    
    
    fileprivate let audioRecorder = AGAudioRecorder(withFileName: "AudioPath")
    //fileprivate var objPlayer: AVAudioPlayer?
    
    fileprivate enum TouchState {
        case end
        case wait
    }
    fileprivate var isTextMode = true
    fileprivate var isReadyToCall:TouchState = .end
    fileprivate static var clipboard: ChatModel?
    fileprivate var audioPlayer: SSAudioPlayer?
    
    ///if it is not group
    var individualDetail: UserDetailsModel?
    
    
    fileprivate var isMute: Bool = false
    
    
    ///Chat list
    fileprivate var chatListTmp: [ChatModel] = []
    
    
    
    fileprivate var preview: URL!
    
    // we set a variable to hold the contentOffSet before scroll view scrolls
    var lastContentOffset: CGFloat = 0
    
    
    public static var downloadRequest: [String: DownloadRequest] = [:]
    
    fileprivate var replaySelectedMeta: [String: Any]?
    
    
    
    fileprivate static let replayWrapperHeight: CGFloat = 30
    
    
    
    //MARK:- from previous controller
    var roomId: String = ""
    var isGroup: Bool = false
    var buddyID :String = ""
    var buddyName:String = ""
    var BuddyProfilePicUrl = ""
    var readcount=0
    var Ismessage=false
    
    //MARK:Check Room Available or not
    var isRoomFind = false
    var RoomCretaed:((_ str:String)->Void)?
    var lastMessageID:String = ""
    //
    
    fileprivate func appendMessages(_ documents: [[String: Any]]) {
        
        chatListTmp = documents.map {(document) -> ChatModel in
            let data: [String : Any] = document
            
            let senderId = data["sender_id"] as! String
            
            
            //TODO: handle if user is not in list
            let chatUserDetails: UserDetailsModel = ChatListView.userDetailsList[senderId]!
            
            let element = ChatModel(documentId: "TODO: Document Id", data: data, senderDetail: chatUserDetails, frame: self.view!.frame )
            print("Chat message: \(element.message)")
            
            return element
        }
        
        appendMessageData()
        scrollToBottom(hideBottomButton: true, animated: false)
    }
    
    
    fileprivate func appendMessage(_ document: [String: Any]) {
        
        
        let data: [String : Any] = document
        
        let senderId = data["sender_id"] as! String
        
        
        //TODO: handle if user is not in list
        let chatUserDetails: UserDetailsModel = ChatListView.userDetailsList[senderId]!
        
        let element = ChatModel(documentId: "TODO: Document Id", data: data, senderDetail: chatUserDetails, frame: self.view!.frame )
        print("Chat message: \(element.message)")
        
        chatListTmp.append(element)
        
        
        appendMessageData()
        
        if (senderId ==  UserModel.getSchoolDataModel().user_id){
            scrollToBottom(hideBottomButton: true, animated: true)
        }else{
            //            scrollToOneCell(hideBottomButton: false)
        }
    }
    
    fileprivate func appendMessageData() {
        
        let groupList: [Date : [ChatModel]] = Dictionary.init(grouping: chatListTmp) { (element) -> Date in
            return element.createdDate
        }
        
        let groupedKey: [Date] = groupList.keys.sorted()
        self.tableList.removeAll()
        groupedKey.forEach { (element) in
            self.tableList.append(groupList[element] ?? [])
        }
        
        self.tableView.reloadData()
    }
    
    var lpgr: UILongPressGestureRecognizer!
    
    
    fileprivate func setUpName(){
        if (isGroup){
            
        } else {
            if let tmpIndividualDetail = individualDetail{
                chatUserName.text = tmpIndividualDetail.firstName
                
                
//                if let date = t.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSX"){
//                    createdDate = date.noon
//                    message_on = date.toString(format: "HH:mm:ss")//Utils.dayDifference(from: date)
//                }
//
                
                
                chatUserOnlineStatus.text = tmpIndividualDetail.is_online ? "Online".localized() : tmpIndividualDetail.last_seen.ConvertTimeformatToOther(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSX", NewFormat: "dd-MM-yyyy HH:mm a")
             
                chatUserProfile.sd_setImage(with: URL(string: tmpIndividualDetail.profile_pic), placeholderImage: UIImage(named: ""))
                //            chatUserProfile.sd_setImage(with: tmpIndividualDetail.profile_pic, completed: { (image, error, cache, url) in
                //                //
                //            })
            }
            
        }
        
    }
    fileprivate func blockedByOtherUser() {
        ///Check that other user muted you or not
        
        self.attatchmentWrapperView.isHidden = true
        self.blockedWrapper.isHidden = false
        self.recordingWrapper.isHidden = true
        self.messageComponentWrapper.isHidden = true
        
    }
    
    
    fileprivate func unBlockedByOtherUser() {
        ///Check that other user muted you or not
        
        self.attatchmentWrapperView.isHidden = true
        self.blockedWrapper.isHidden = true
        self.recordingWrapper.isHidden = true
        self.messageComponentWrapper.isHidden = false
        
    }
    
    fileprivate func initViews() {
        //PlacePicker.configure(googleMapsAPIKey: "AIzaSyDttGN_V5875mq-jsXlT49Sp22aj4o1Wik", placesAPIKey: "AIzaSyDttGN_V5875mq-jsXlT49Sp22aj4o1Wik")
        
        //MARK:Setup initial UI
        ///Hide All The Input view so we can show leter base on are we muted or not
        replayIndicatorWrapper.isHidden = true
        attatchmentWrapperView.isHidden = true
        blockedWrapper.isHidden = true
        recordingWrapper.isHidden = true
        messageComponentWrapper.isHidden = false//true
        audioPlayerWrapper.isHidden = true
        
        ///set delegate for audio recorder
        audioRecorder.delegate = self
        
        ///set delegate for Caht TableView
        tableView.delegate = self
        tableView.dataSource = self
        
        ///set configration for message writing
        self.writeMessage.tag = 1
        self.writeMessage.delegate = self
        self.writeMessage.returnKeyType = UIReturnKeyType.send
        //        self.writeMessage.text = placeHolderString
        
        ///Setup loading UI
        viewloader = getActivityIndicator("Loading..." )
        
        
        //        ///Setup loang press Recognizer for table cell
        //        lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        //        lpgr.minimumPressDuration = 0.05
        //
        //        //        lpgr.delaysTouchesBegan = false
        //        lpgr.delegate = self
        //        lpgr.cancelsTouchesInView = false
        //        self.tableView.addGestureRecognizer(lpgr)
        
        
        
        ///Setup Observer for move up when keyboard open
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        
        //Setup Add AudioPlayer
        if let player: SSAudioPlayer = SSAudioPlayer.initialize(with: self.audioPlayerWrapper.bounds) {
            
            player.delegate = self
            audioPlayer = player
            
            self.audioPlayerWrapper.addSubview(player)
            
            //            player.loadVideos(with: [url])
            //            player.playVideo()
            
        }
        
        
        //Set Group Name or user name
        setUpName()
        //        setMuteView()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
//         self.tabBarController?.tabBar.isHidden = true
//                print(roomId)
//                ismessage=true
//                initCollection()
//            goToBottomBtn.isHidden = true
//
//                //        viewloader = getActivityIndicator("Loading...")
//                //        view.addSubview(viewloader!)
//
//
//                SocketManager.shared.registerToScoket(observer: self )
//                if readcount != 0{
//                    SetRead()
//                }
//
//
//
//                //        PlacePicker.configure(googleMapsAPIKey: "AIzaSyAfvqQWoCMn0gkhAhFEPvPSe-YZu4lXJNY", placesAPIKey: "AIzaSyAfvqQWoCMn0gkhAhFEPvPSe-YZu4lXJNY")
//
//                initViews()
//
//
//                if individualDetail == nil {
//                    if roomId == ""{
//                        chatUserName.text = buddyName
//                        chatUserProfile.sd_setImage(with: URL(string: BuddyProfilePicUrl ), placeholderImage: UIImage(named: "ic_placeholder_profile"))
//                        getAllRoom()
//                    }else{
//                        getRoomInfo()
//
//                    }
//
//
//                }else{
//                    getRoomInfo()
//
//                }
//
//
        
        
                
                        //initChatMessageListener()
            //determineMyCurrentLocation()
                
        //        self.navigationController?.isNavigationBarHidden = true
        //        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    fileprivate func allMessage() {
        let json: [String: Any] = ["request": "message",
                                   "type": "allMessage",
                                   "room": roomId]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    
    fileprivate func allBlockList() {
        let json: [String: Any] = ["request": "block_user",
                                   "type": "allBlockUser",
                                   "user":UserModel.getSchoolDataModel().user_id]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    fileprivate func blockOrUnblock(isBlock: Bool) {
        let json: [String: Any] = ["request": "block_user",
                                   "type": "blockUser",
                                   "blockedBy":  UserModel.getSchoolDataModel().user_id,
                                   "blockedTo": individualDetail?.userId,
                                   "isBlock": isBlock,
                                   
                                   
        ]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    
    fileprivate func getRoomInfo() {
        let json: [String: Any] = ["request": "room",
                                   "type": "roomsDetails",
                                   "roomId": roomId
        ]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    fileprivate func getAllRoom() {
        let json: [String: Any] = ["request": "room",
                                   "type": "allRooms",
                                   "userList": [UserModel.getSchoolDataModel().user_id]
            //  "userList": []
        ]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    //MARK:Crete Room
    fileprivate  func CreateRoom(roomsuccess:@escaping ( _ strRes:String) -> Void){
        
        SocketManager.shared.registerToScoket(observer: self)
        let json: [String: Any] = ["type": "createRoom",
                                   "userList": [UserModel.getSchoolDataModel().user_id,  buddyID],
                                   "createBy": UserModel.getSchoolDataModel().user_id,
                                   "request":"room"]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
            
        }
        
        RoomCretaed = { (str) in
            print("Room Create  call back Call")
            roomsuccess("created")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Localize.currentLanguage() == "en" {
        self.btnback.transform=CGAffineTransform(rotationAngle:0)
               
           }else{
           self.btnback.transform=CGAffineTransform(rotationAngle:-CGFloat.pi)
        }
        
        self.tabBarController?.tabBar.isHidden = true
        messageWrapper.layer.cornerRadius = 10
        messageWrapper.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
                print(roomId)
               ismessage=true
                initCollection()
            goToBottomBtn.isHidden = true
        
                //        viewloader = getActivityIndicator("Loading...")
                //        view.addSubview(viewloader!)
        
        
                SocketManager.shared.registerToScoket(observer: self )
                if readcount != 0{
                    SetRead()
                }else if ismessage==true{
                    SetRead()
                }
        
             
        
                //        PlacePicker.configure(googleMapsAPIKey: "AIzaSyAfvqQWoCMn0gkhAhFEPvPSe-YZu4lXJNY", placesAPIKey: "AIzaSyAfvqQWoCMn0gkhAhFEPvPSe-YZu4lXJNY")
        
                initViews()
        
        
                if individualDetail == nil {
                    if roomId == ""{
                        chatUserName.text = buddyName
                        chatUserProfile.sd_setImage(with: URL(string: BuddyProfilePicUrl ), placeholderImage: UIImage(named: "ic_placeholder_profile"))
                        getAllRoom()
                    }else{
                        getRoomInfo()
        
                    }
        
        
                }else{
                    getRoomInfo()
        
                }
        
        
        
        
        
        
        
        
        
    
               
               //
               //        initChatMessageListener()
               //        determineMyCurrentLocation()
               
        
        
        
        
                
                        //initChatMessageListener()
            //determineMyCurrentLocation()
                
        //        self.navigationController?.isNavigationBarHidden = true
        //        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
//        print(roomId)
//        ismessage=true
//        initCollection()
        //goToBottomBtn.isHidden = true
//
//        //        viewloader = getActivityIndicator("Loading...")
//        //        view.addSubview(viewloader!)
//
//
//        SocketManager.shared.registerToScoket(observer: self )
//        if readcount != 0{
//            SetRead()
//        }
//
//        //        PlacePicker.configure(googleMapsAPIKey: "AIzaSyAfvqQWoCMn0gkhAhFEPvPSe-YZu4lXJNY", placesAPIKey: "AIzaSyAfvqQWoCMn0gkhAhFEPvPSe-YZu4lXJNY")
//
//        initViews()
//
//
//        if individualDetail == nil {
//            if roomId == ""{
//                chatUserName.text = buddyName
//                chatUserProfile.sd_setImage(with: URL(string: BuddyProfilePicUrl ), placeholderImage: UIImage(named: "ic_placeholder_profile"))
//                getAllRoom()
//            }else{
//                getRoomInfo()
//
//            }
//
//
//        }else{
//            getRoomInfo()
//
//        }
//
//
//
//
        //
        //        initChatMessageListener()
        //        determineMyCurrentLocation()
        
    }
    
    
    func SetRead(){
        let json: [String: Any] = [
            "request":"room",
            "unread": obj.prefs.value(forKey: APP_USER_ID) ?? "",
            "type":"roomsModify",
            "roomId":roomId,
        ]
        if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
            SocketManager.shared.sendMessageToSocket(message: jsonString as String)
        }
    }
    
    
    
    fileprivate func initCollection() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer?.releaseMemory()
        audioRecorder.releaseMemory()
        SocketManager.shared.unregisterToSocket(observer: self)
        print("ChatViewController:: viewDidDisappear")
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("ChatViewController:: viewWillDisappear")
    }
    deinit {
        
        
        print("deinit Called:: ChatViewController ")
    }
    
    @IBAction func didTapCancelReplay(_ sender: Any) {
        replayIndicatorWrapper.isHidden = true
        replaySelectedMeta = nil
    }
    @IBAction func goToBottom(_ sender: Any) {
        self.scrollToBottom(hideBottomButton: true, animated: true)
        
    }
    @IBAction func goBack(_ sender: Any) {
        ismessage=false
        //onlineStatus=true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOpenMenu(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Action" , message: "", preferredStyle: .actionSheet)
        let editButton = UIAlertAction(title: self.isMute ? "Un-Mute" : "Mute" , style: .default, handler: { (action) -> Void in
            
            ///IF is single user chat then check some other user details and set it
            if !self.isGroup {
                //                if let chatUserDetails = self.otherUser {
                //                    self.isMute = !self.isMute
                //                    self.threadDocReference.updateData([currentUser.uid + ".isMute": self.isMute])
                //                }
                
                self.isMute = !self.isMute
                self.blockOrUnblock(isBlock: self.isMute);
                ///Fix it
                //                self.threadDocReference.updateData([self.currentUser.uid + ".isMute": self.isMute])
            }
        })
        
        //                alertController.addAction(deleteButton)
        alertController.addAction(editButton)
        
        
        let cancelButton = UIAlertAction(title: "Cancel" , style: .cancel, handler: { (action) -> Void in
        })
        
        
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func didTapCamera(_ sender: Any) {
        self.photoLibrary(type: UIImagePickerController.SourceType.camera)
        attatchmentWrapperView.isHidden = true
    }
    
    @IBAction func didTapGallery(_ sender: Any) {
        self.photoLibrary(type: UIImagePickerController.SourceType.photoLibrary)
        attatchmentWrapperView.isHidden = true
    }
    
    @IBAction func didTapLocation(_ sender: Any) {
        
        let messageDictionary = [
            "name": "Military Containment",
            "address": "Jhotwara, Jaipur, Rajasthan 302039",
            "latitude": "26.938283",
            "longitude": "75.773746"
            ] as [String : Any]
        
        
        self.sendMessage(message: "", type: .location, messageContent: messageDictionary)
        
        attatchmentWrapperView.isHidden = true
        // self.pickPlace()
    }
    @IBAction func didTapFile(_ sender: Any) {
        self.selectDocument()
        //        self.sendClipBoardItem()
        attatchmentWrapperView.isHidden = true
    }
    
    @IBAction func didTapShowAudio(_ sender: Any) {
        setAudioMode()
        attatchmentWrapperView.isHidden = true
    }
    
    @IBAction func didTapHideAudio(_ sender: Any) {
        setTextMode()
        attatchmentWrapperView.isHidden = true
    }
    
    @IBAction func didTapContact(_ sender: Any) {
        let vc = PickContactViewController()
        vc.delegateContact = self
        self.navigationController?.pushViewController(vc, animated: true)
        attatchmentWrapperView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view?.frame.origin.y == 20{
            attatchmentWrapperView.isHidden=true
        }
    }
    
    
    
    @IBAction func didTapOpenAttachment(_ sender: Any) {
        attatchmentWrapperView.isHidden = !attatchmentWrapperView.isHidden
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        if isTextMode {
            if(writeMessage.text != ""){
                //                for i in (1...99){
                //                    sendMessage(message: "Message No: \(i)" , type: .text)
                //                }
                if let replay = replaySelectedMeta {
                    sendMessage(message: writeMessage.text!, type: .replay, messageContent: replay)
                    writeMessage.text = ""
                }else{
                    sendMessage(message: writeMessage.text!, type: .text)
                    writeMessage.text = ""
                }
                //            writeMessage.resignFirstResponder()
            }
        }else{
            let url: URL = audioRecorder.fileUrl()
            
            let fileMeta = [
                MediaMetaModel.KEY_FILE_TYPE: MediaType.audioM4A.rawValue,
                MediaMetaModel.KEY_FILE_NAME: url.lastPathComponent,
            ]
            
            self.uploadMedia( file: SSFiles(url: url), messageType: .document, fileMeta: fileMeta)
            setTextMode()
        }
        
    }
    @IBAction func didTapStartRecord(_ sender: Any) {
        if recordingState == RecorderState.Recording {
            audioRecorder.doStopRecording()
        } else {
            audioRecorder.changeFile(withFileName: "\(Date().timeIntervalSince1970)")
            audioRecorder.doRecord()
        }
    }
    @IBAction func didTapSendAudio(_ sender: Any) {
        
        
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
        vc.sellerId = self.individualDetail?.userId ?? ""
        vc.vctype="profile"
        self.show(vc, sender: nil)
    }
    
    
    @IBAction func didTapSendPlay(_ sender: Any) {
        audioRecorder.doPlay()
    }
    
    func showBottomButton()  {
        // goToBottomBtn.isHidden = false
        // bouncView(uiView: goToBottomBtn)
    }
    
}



//MARK:- Private functions
extension ChatViewController {
    fileprivate func setAudioMode() {
        recordingWrapper.isHidden = false
        messageWrapper.isHidden = true
        
        isTextMode = false
    }
    fileprivate func setTextMode() {
        recordingWrapper.isHidden = true
        messageWrapper.isHidden = false
        
        isTextMode = true
    }
    @objc fileprivate func keyboardFrameChangeNotification(notification: Notification) {
        attatchmentWrapperView.isHidden = true
        if let userInfo = notification.userInfo {
            _ = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
            let animationCurveRawValue = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int) ?? Int(UIView.AnimationOptions.curveEaseInOut.rawValue)
            let animationCurve = UIView.AnimationOptions(rawValue: UInt(animationCurveRawValue))
            _ = notification.name == UIResponder.keyboardWillShowNotification
            
            
            ///Fix it
            //            commentBoxBottomCons.constant = isKeyboardShowing ? endFrame?.height ?? 0 : 0
            
            UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    @objc fileprivate func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if (gestureReconizer == lpgr) {
            print("Same")
        }else{
            print("Not Same")
        }
        switch gestureReconizer.state  {
        case .ended:
            print("ended")
            
            if (isReadyToCall == .wait){
                let p: CGPoint = gestureReconizer.location(in: self.tableView)
                if let indexPath: IndexPath = self.tableView.indexPathForRow(at: p) {
                    self.singleTapOnCell(indexPath: indexPath)
                }
            }
            
            isReadyToCall = .end
            
            break
        case .possible:
            print("possible")
            break
        case .began:
            print("began")
            isReadyToCall = .wait
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                if (self.isReadyToCall == .wait){
                    self.isReadyToCall = .end
                    let p: CGPoint = gestureReconizer.location(in: self.tableView)
                    if let indexPath: IndexPath = self.tableView.indexPathForRow(at: p) {
                        self.openMenu(indexPath: indexPath)
                    }
                }
                
            })
            
            break
        case .changed:
            print("changed")
            break
        case .cancelled:
            print("cancelled")
            break
        case .failed:
            print("failed")
            break
        @unknown default:
            print("default")
            break
        }
    }
    
    @objc fileprivate func openOriginMessage(gestureReconizer: UILongPressGestureRecognizer) {
        //TODO:- Show replay message
        print("Show replay message")
    }
    
    
    fileprivate func openMenu(indexPath: IndexPath) {
        let element: ChatModel = self.tableList[indexPath.section][indexPath.row]
        
        let alertController = UIAlertController(title: "Action" , message: "", preferredStyle: .actionSheet)
        let deleteButton = UIAlertAction(title: "Copy Message" , style: .default, handler: { (action) -> Void in
            //            self.removePost(placeId: self.postList[index].id as String)
            if element.message_type == .text {
                let pasteboard = UIPasteboard.general
                pasteboard.string = element.message
                self.showToast(message: "Copied!")
            }else{
                ChatViewController.clipboard = element
                self.showToast(message: "Copied!")
            }
            
        })
        
        let editButton = UIAlertAction(title: "Replay" , style: .default, handler: { (action) -> Void in
            //            let vc = AddPostViewController() //change this to your class name
            //            vc.modalPresentationStyle = .overFullScreen
            //            vc.__postObject = self.postList[index]
            //            self.present(vc, animated: true, completion: nil)
            
            
            var messageForReplay = ""
            
            
            switch element.message_type {
            case .text:
                let upto = element.message.count >= 30 ? 30 : element.message.count
                messageForReplay = String(element.message[0..<upto])
                break
            case .image:
                messageForReplay = "🏞 Image"
                break
            case .document:
                messageForReplay = "📄 Document"
                break
            case .location:
                messageForReplay = "📍 Location"
                break
            case .contact:
                messageForReplay = "📞 Contact"
                break
            case .video:
                messageForReplay = "📹 Video"
                break
            case .replay:
                let upto = element.message.count >= 30 ? 30 : element.message.count
                messageForReplay = String(element.message[0..<upto])
                break
            }
            
            self.replaySelectedMeta = [ReplayModel.KEY_REPLAY_DOC_ID: element.documentId,
                                       ReplayModel.KEY_REPLAY_ORIGIN_TYPE: element.message_type.rawValue,
                                       ReplayModel.KEY_REPLAY_ORIGIN_MESSAGE: messageForReplay]
            
            self.replayIndicatorWrapper.isHidden = false
            self.replayTextLabel.text = messageForReplay
            
        })
        
        alertController.addAction(deleteButton)
        alertController.addAction(editButton)
        
        
        let cancelButton = UIAlertAction(title: "Cancel" , style: .cancel, handler: { (action) -> Void in
        })
        
        
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            if let popOver: UIPopoverPresentationController = alertController.popoverPresentationController {
        //                popOver.sourceView = sender
        //            }
        //        }
    }
    fileprivate func pickPlace() {
        
        var config: PlacePickerConfig = PlacePickerConfig()
        if let location = userLocation {
            config.initialCoordinate = location.coordinate
            config.initialZoom = 16
        }
        config.pickerRenderer = self
        //        = userLocation!
        
        let controller = PlacePicker.placePickerController(config: config)
        controller.delegate = self
        
        
        let navigationController = UINavigationController(rootViewController: controller)
        self.show(navigationController, sender: nil)
    }
    fileprivate func scrollToBottom(hideBottomButton: Bool, animated: Bool ){
         goToBottomBtn.isHidden = hideBottomButton
        DispatchQueue.main.async {
            
            //            tableView.indexPathsForVisibleRows?.first
            
            if self.tableList.count != 0 {
                let indexPath = IndexPath(row: self.tableList[self.tableList.count - 1].count-1, section: self.tableList.count - 1)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
            
        }
        
        
    }
    
    fileprivate func scrollToOneCell(hideBottomButton: Bool){
        //goToBottomBtn.isHidden = hideBottomButton
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
            
            //            tableView.indexPathsForVisibleRows?.first
            
            if self.tableList.count != 0 {
                if var lastIndexPath: IndexPath = self.tableView.indexPathsForVisibleRows?.last {
                    print(lastIndexPath)
                    
                    lastIndexPath.row = lastIndexPath.row + 1
                    self.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
                }
                //                let indexPath = IndexPath(row: self.tableList[self.tableList.count - 1].count-1, section: self.tableList.count - 1)
                
            }
            
        }
    }
    
    fileprivate func sendMessage(message: String,type: MessageType, messageContent: [String: Any] = [:], date: Date = Date()) {
        
        
        if roomId == ""{
            if isRoomFind ==  false{
                self.CreateRoom { (strRes) in
                    print("Room Created")
                    
                    let json: [String: Any] = [
                        
                        "request": Constant.Request.REQUEST_TYPE_MESSAGE,
                        "type": "addMessage",
                        "roomId": self.roomId,
                        "room": self.roomId,
                        "message": message,
                        "message_type": type.rawValue,
                        "sender_id":  UserModel.getSchoolDataModel().user_id,
                        "receiver_id": self.individualDetail?.userId ?? "",
                        
                        "message_content": messageContent
                    ]
                    
                    if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
                        SocketManager.shared.sendMessageToSocket(message: jsonString as String)
                    }
                }
            }else{
                let json: [String: Any] = [
                    "request": Constant.Request.REQUEST_TYPE_MESSAGE,
                    "type": "addMessage",
                    "roomId": self.roomId,
                    "room": self.roomId,
                    "message": message,
                    "message_type": type.rawValue,
                    "sender_id":  UserModel.getSchoolDataModel().user_id,
                    "receiver_id": self.individualDetail?.userId ?? "",
                    "message_content": messageContent
                ]
                if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
                    SocketManager.shared.sendMessageToSocket(message: jsonString as String)
                }
            }
        }else{
            
            let json: [String: Any] = [
                "request": Constant.Request.REQUEST_TYPE_MESSAGE,
                "type": "addMessage",
                "roomId": self.roomId,
                "room": self.roomId,
                "message": message,
                "message_type": type.rawValue,
                "sender_id":  UserModel.getSchoolDataModel().user_id,
                "receiver_id": self.individualDetail?.userId ?? "",
                "message_content": messageContent
            ]
            
            if let jsonString: NSString = JsonOperation.toJsonStringFrom(dictionary: json) {
                SocketManager.shared.sendMessageToSocket(message: jsonString as String)
            }
        }
        
        
    }
    
    fileprivate func sendClipBoardItem(){
        if let element: ChatModel = ChatViewController.clipboard {
            sendMessage(message: element.message, type: element.message_type, messageContent: element.message_content_dict ?? [:])
        }else{
            self.showToast(message: "Clipborad empty!")
        }
        
    }
}
//MARK:- Location Picker
extension ChatViewController: PickerRenderer {
    func configureCancelButton(barButtonItem: UIBarButtonItem) {
        
    }
    
    func configureSearchButton(barButtonItem: UIBarButtonItem) {
        
    }
    
    func configureMapView(mapView: GMSMapView) {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func configureTableView(mapView: UITableView) {
        
    }
}
//MARK:- Location Picker
extension ChatViewController: PlacesPickerDelegate {
    func placePickerControllerDidCancel(controller: PlacePickerController) {
        controller.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func placePickerController(controller: PlacePickerController, didSelectPlace place: GMSPlace) {
        controller.navigationController?.dismiss(animated: true, completion: nil)
        
        _ = [
            "name": place.name ?? "",
            "address": place.formattedAddress ?? "",
            "latitude": String(place.coordinate.latitude),
            "longitude": String(place.coordinate.longitude)
            ] as [String : Any]
        
        
        //        self.sendMessage(message: message, type: .location, messageContent: messageDictionary)
        
    }
}

extension ChatViewController: ContactViewDelegate {
    func selected(contacts: [MyContact]) {
        for contact in contacts {
            
            let messageContent: [String: Any] = contact.toDictionary()
            sendMessage(message: "", type: .contact, messageContent: messageContent)
        }
    }
}

//MARK:- Table Delegate
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let height = scrollView.frame.size.height
    //        let contentYoffset = scrollView.contentOffset.y
    //        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
    //        if distanceFromBottom < height {
    //            goToBottomBtn.isHidden = true
    ////            print(" you reached end of the table")
    //        }
    //    }
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
        
        
        let height = scrollView.frame.size.height
        
        let distanceFromBottom = scrollView.contentSize.height - self.lastContentOffset
        if distanceFromBottom < height {
            //            print(" you reached end of the table")
            
            goToBottomBtn.isHidden = false
        }
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < scrollView.frame.size.height {
            goToBottomBtn.isHidden = true
            //            print(" you reached end of the table")
        } else if contentYoffset == 0 {
            print(" you reached top of the table")
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableList[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableList.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = DateHeaderLabel()
        label.backgroundColor = UIColor.black
        label.font = UIFont.appFont(size: 13)
        if let element: ChatModel = self.tableList[section].first {
            //            label.text = element.createdDate.toString(format: "yyyy-MM-dd")
            
            //   label.text = "\(element.createdDate)"
            let dayHourMinuteSecond: Set<Calendar.Component> = [.year,.month, .day, .hour, .minute, .second]
            let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: element.createdDate, to: Date())
            if difference.day ?? 0>0{
                print(element.createdDate)
                label.text = "\(element.createdDate)".ConvertTimeformatToOther(currentFormat: "yyyy-MM-dd HH:mm:ss +0000", NewFormat: "dd MMM YYYY")
            }else{
                label.text = "Today"
            }
            
        } else{
            label.text = "Title \(section)"
        }
        
        
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        
        containerView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        return containerView
    }
    class DateHeaderLabel: UILabel {
        override var intrinsicContentSize: CGSize {
            let originalSize = super.intrinsicContentSize
            let height = originalSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            
            return CGSize(width: originalSize.width + 20, height: height)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Title \(section)"
    //    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element: ChatModel = self.tableList[indexPath.section][indexPath.row]
        if element.message_type == MessageType.text {
            return element.tableCellHeight
        } else if element.message_type == MessageType.replay {
            return element.tableCellHeight + ChatViewController.replayWrapperHeight
        } else if element.message_type == MessageType.document {
            return 80
        } else if element.message_type == MessageType.location {
            return 80
        } else if element.message_type == MessageType.contact {
            return 80
        } else if element.message_type == MessageType.video {
            return 160
        } else {
            return 160
        }
    }
    
    fileprivate func verifyDownloadProgress(message_content: MediaModel, indexPath: IndexPath, element: ChatModel) {
        if let link: URL = URL(string: message_content.file_url) {
            var documentsURL: URL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            documentsURL.appendPathComponent(link.lastPathComponent)
            print(documentsURL.path)
            if !FileManager().fileExists(atPath: documentsURL.path) {
                
                //                self.tableView.reloadData()
                //                downloadFiles(url: link.absoluteString, indexPath: indexPath, stopDownloading: element.downloadStatus == .downloading)
                if let downloadRequest: DownloadRequest = ChatViewController.downloadRequest[link.absoluteString.toMD5] {
                    self.tableList[indexPath.section][indexPath.row].downloadStatus = .downloading
                    startRenderProgress(downloadRequest, indexPath, link.absoluteString)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element: ChatModel = self.tableList[indexPath.section][indexPath.row]
        if(element.sender_detail.userId == UserModel.getSchoolDataModel().user_id) {
            if(element.message_type == MessageType.text || element.message_type == MessageType.replay ) {
                let identifier = "RightTextTableViewCell"
                var cell: RightTextTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightTextTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightTextTableViewCell
                }
                
                
                
                var extraHeight: CGFloat = 0
                if element.message_type == MessageType.replay {
                    cell.quotWrapperView.isHidden = false
                    
                    let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(openOriginMessage))
                    
                    lpgr.minimumPressDuration = 0.05
                    
                    //        lpgr.delaysTouchesBegan = false
                    lpgr.delegate = self
                    lpgr.cancelsTouchesInView = false
                    
                    
                    //                    tap.numberOfTapsRequired = 1
                    cell.quotWrapperView.addGestureRecognizer(lpgr)
                    
                    
                    extraHeight = ChatViewController.replayWrapperHeight
                }else{
                    cell.quotWrapperView.isHidden = true
                    extraHeight = 0
                }
                
                
                //                cell.quotWrapperView.isHidden = false
                //                extraHeight = ChatViewController.replayWrapperHeight
                
                
                
                
                var messageWrapperWidth: CGFloat = element.tableCellWidth + 10
                if messageWrapperWidth < 100 {
                    messageWrapperWidth = 100
                }
                
                cell.wrapperView.frame = CGRect(x: self.view.frame.width - messageWrapperWidth - 20,
                                                y: 10,
                                                width: messageWrapperWidth,
                                                height: element.tableCellHeight - 45 + extraHeight )
                
                cell.chatMessage.frame = CGRect(x: 5, y: 5 + extraHeight, width: element.tableCellWidth, height: element.tableCellHeight - 55  )
                
                cell.quotWrapperView.frame = CGRect(x: 5, y: 5, width: messageWrapperWidth - 10, height: 30 )
                cell.quotMessage.frame = CGRect(x: 5, y: 0, width: messageWrapperWidth - 15, height: 30 )
                
                
                
                cell.time.frame.origin.x = -10
                cell.time.frame.origin.y = cell.wrapperView.frame.maxY + 5
                cell.time.frame.size.width = self.view.frame.width
                
                //                cell.quotMessage.isHidden = true
                
                cell.selectionStyle = .none
                cell.configData(obj: element)
                
                
                return cell
            }
                
            else if(element.message_type == MessageType.image ){
                let identifier = "RightImageTableViewCell"
                var cell: RightImageTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightImageTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightImageTableViewCell
                }
                cell.selectionStyle = .none
                cell.configData(obj: element)
                return cell
            }else if(element.message_type == MessageType.video ){
                let identifier = "RightVideoTableViewCell"
                var cell: RightVideoTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightVideoTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightVideoTableViewCell
                }
                cell.selectionStyle = .none
                
                let message_content = element.message_content as! MediaModel
                verifyDownloadProgress(message_content: message_content, indexPath: indexPath, element: element)
                cell.configData(obj: element)
                
                return cell
            }else if(element.message_type == MessageType.location ){
                let identifier = "RightLocationTableViewCell"
                var cell: RightLocationTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightLocationTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightLocationTableViewCell
                }
                cell.selectionStyle = .none
                cell.configData(obj: element)
                return cell
            }else if(element.message_type == MessageType.contact ){
                let identifier = "RightContactTableViewCell"
                var cell: RightContactTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightContactTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightContactTableViewCell
                }
                cell.selectionStyle = .none
                cell.configData(obj: element)
                return cell
            }else{
                let identifier = "RightDocTableViewCell"
                var cell: RightDocTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightDocTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightDocTableViewCell
                }
                cell.selectionStyle = .none
                
                let message_content = element.message_content as! MediaModel
                verifyDownloadProgress(message_content: message_content, indexPath: indexPath, element: element)
                cell.configData(obj: element)
                
                return cell
            }
        }else{
            if(element.message_type == MessageType.text  || element.message_type == MessageType.replay){
                let identifier = "LeftTextTableViewCell"
                var cell: LeftTextTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftTextTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: "LeftTextTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftTextTableViewCell
                }
                
                //                if element.tableCellWidth >= (self.view.frame.width - 60){
                //
                //                    //                    tableView.rowHeight = tableData[indexPath.row].tableCellHeight + 40
                //                    self.adjustUITextViewHeight(arg: cell.chatMessage)
                //                    cell.wrapperView.frame = CGRect(x:10, y:10, width:self.view.frame.width - 50, height: element.tableCellHeight - 20 )
                //
                //                    cell.chatMessage.frame = CGRect(x:5, y:5, width:cell.wrapperView.frame.width - 20, height: element.tableCellHeight  )
                //
                //                } else{
                //                    tableView.rowHeight = tableData[indexPath.row].tableCellHeight + 60
                //                    self.adjustUITextViewHeight(arg: cell.chatMessage)
                
                /*cell.wrapperView.frame = CGRect(x: 10, y: 10, width: element.tableCellWidth + 20, height: element.tableCellHeight - 45 )
                 
                 cell.chatMessage.frame = CGRect(x: 5, y: 5, width: element.tableCellWidth, height:  element.tableCellHeight - 55 )
                 
                 //                }
                 cell.time.frame.origin.x = 10
                 cell.time.frame.origin.y = cell.wrapperView.frame.maxY + 5 //cell.wrapperView.frame.height - cell.time.frame.height - 5
                 cell.time.frame.size.width = self.view.frame.width
                 cell.selectionStyle = .none
                 cell.configData(obj: element)*/
                
                
                
                var extraHeight: CGFloat = 0
                if element.message_type == MessageType.replay {
                    cell.quotWrapperView.isHidden = false
                    
                    let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(openOriginMessage))
                    
                    lpgr.minimumPressDuration = 0.05
                    
                    //        lpgr.delaysTouchesBegan = false
                    lpgr.delegate = self
                    lpgr.cancelsTouchesInView = false
                    
                    
                    //                    tap.numberOfTapsRequired = 1
                    cell.quotWrapperView.addGestureRecognizer(lpgr)
                    
                    
                    extraHeight = ChatViewController.replayWrapperHeight
                }else{
                    cell.quotWrapperView.isHidden = true
                    extraHeight = 0
                }
                
                
                var messageWrapperWidth: CGFloat = element.tableCellWidth// + 10
                if messageWrapperWidth < 100 {
                    messageWrapperWidth = 100
                }
                
                cell.wrapperView.frame = CGRect(x: 10, y: 10, width: messageWrapperWidth + 20, height: element.tableCellHeight - 45 + extraHeight)
                
                cell.chatMessage.frame = CGRect(x: 5, y: 5 + extraHeight, width: element.tableCellWidth, height:  element.tableCellHeight - 55 )
                
                
                cell.quotWrapperView.frame = CGRect(x: 5, y: 5, width: messageWrapperWidth - 10, height: 30 )
                cell.quotMessage.frame = CGRect(x: 5, y: 0, width: messageWrapperWidth - 15, height: 30 )
                
                //                }
                cell.time.frame.origin.x = 10
                cell.time.frame.origin.y = cell.wrapperView.frame.maxY + 5 //cell.wrapperView.frame.height - cell.time.frame.height - 5
                cell.time.frame.size.width = self.view.frame.width
                cell.selectionStyle = .none
                cell.configData(obj: element)
                
                return cell
            }else if(element.message_type == MessageType.image ){
                let identifier = "LeftImageTableViewCell"
                var cell: LeftImageTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftImageTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: "LeftImageTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftImageTableViewCell
                }
                cell.selectionStyle = .none
                cell.configData(obj: element)
                return cell
            }else if(element.message_type == MessageType.video ){
                let identifier = "LeftVideoTableViewCell"
                var cell: LeftVideoTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftVideoTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: "LeftVideoTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftVideoTableViewCell
                }
                cell.selectionStyle = .none
                
                let message_content = element.message_content as! MediaModel
                verifyDownloadProgress(message_content: message_content, indexPath: indexPath, element: element)
                cell.configData(obj: element)
                
                return cell
            }else if(element.message_type == MessageType.location ){
                let identifier = "LeftLocationTableViewCell"
                var cell: LeftLocationTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftLocationTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftLocationTableViewCell
                }
                cell.selectionStyle = .none
                cell.configData(obj: element)
                return cell
            }else if(element.message_type == MessageType.contact ){
                let identifier = "LeftContactTableViewCell"
                var cell: LeftContactTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftContactTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftContactTableViewCell
                }
                cell.selectionStyle = .none
                cell.configData(obj: element)
                return cell
            }else{
                let identifier = "LeftDocTableViewCell"
                var cell: LeftDocTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftDocTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftDocTableViewCell
                }
                cell.selectionStyle = .none
                
                let message_content = element.message_content as! MediaModel
                verifyDownloadProgress(message_content: message_content, indexPath: indexPath, element: element)
                cell.configData(obj: element)
                
                return cell
            }
        }
        
        
        //        let identifier = "LeftTextTableViewCell"
        //        var cell: LeftTextTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftTextTableViewCell
        //        if cell == nil {
        //            tableView.register(UINib(nibName: "LeftTextTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        //            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftTextTableViewCell
        //        }
        
        //        if tableData[indexPath.row].tableCellWidth >= (self.view.frame.width - 60){
        //
        //            //                    tableView.rowHeight = tableData[indexPath.row].tableCellHeight + 40
        //            self.adjustUITextViewHeight(arg: cell.chatMessage)
        //            cell.wrapperView.frame = CGRect(x:10, y:10, width:self.view.frame.width - 50, height:tableData[indexPath.row].tableCellHeight - 20 )
        //
        //            cell.chatMessage.frame = CGRect(x:5, y:5, width:cell.wrapperView.frame.width - 20, height:tableData[indexPath.row].tableCellHeight  )
        //
        //        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        singleTapOnCell(indexPath: indexPath)
    }
    
    func singleTapOnCell(indexPath: IndexPath) {
        let element: ChatModel = self.tableList[indexPath.section][indexPath.row]
        
        if(element.message_type.rawValue == MessageType.document.rawValue){
            //                    let vc:DocDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocDetailViewController") as! DocDetailViewController
            //                    vc.docUrlDetail = tableData[indexPath.row].media_url
            //                    self.navigationController?.pushViewController(vc, animated: true)
        }else if(element.message_type.rawValue == MessageType.image.rawValue){
            let doc: MediaModel = element.message_content as! MediaModel
            
            
            let vc = Show_Image_Video_VC.instance(.homeTab) as! Show_Image_Video_VC
            vc.vctype = "images"
            vc.imgFullUrl = doc.file_url
            self.present(vc, animated: true, completion: nil)
            
            //                }else if(tableData[indexPath.row].message_type == MessageType.location.rawValue){
            //                    guard let responseJSON:[String: Any] = SingleChatViewController.convertToDictionary(text: tableData[indexPath.row].message ) else {
            //                        print("invalid json recieved : \( tableData[indexPath.row].message )")
            //                        return
            //                    }
            //
            //                    openMap(lat: responseJSON["latitude"] as! String, long: responseJSON["longitude"] as! String, title: responseJSON["name"] as! String)
        }
        //        if(tableData[indexPath.row].message_type == MessageType.document.rawValue){
        //            let vc:DocDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocDetailViewController") as! DocDetailViewController
        //            vc.docUrlDetail = tableData[indexPath.row].media_url
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }else if(tableData[indexPath.row].message_type == MessageType.image.rawValue){
        //            let vc:ZoomImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ZoomImageViewController") as! ZoomImageViewController
        //            vc.image = tableData[indexPath.row].media_url
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }else if(tableData[indexPath.row].message_type == MessageType.location.rawValue){
        //            guard let responseJSON:[String: Any] = SingleChatViewController.convertToDictionary(text: tableData[indexPath.row].message ) else {
        //                print("invalid json recieved : \( tableData[indexPath.row].message )")
        //                return
        //            }
        //
        //            openMap(lat: responseJSON["latitude"] as! String, long: responseJSON["longitude"] as! String, title: responseJSON["name"] as! String)
        //        }
        
        if(element.message_type == MessageType.document || element.message_type == MessageType.video) {
            let doc: MediaModel = element.message_content as! MediaModel
            
            
            if let link: URL = URL(string: doc.file_url) {
                
                var documentsURL: URL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                
                documentsURL.appendPathComponent(link.lastPathComponent)
                print(documentsURL.path)
                if !FileManager().fileExists(atPath: documentsURL.path) {
                    downloadFiles(url: link.absoluteString, indexPath: indexPath, stopDownloading: element.downloadStatus == .downloading)
                }else{
                    openFile(url: documentsURL, media: doc)
                }
                
            }
            
            
        } else if(element.message_type == MessageType.contact){
            let userContact = (element.message_content as! MyContact)
            
            
            let store = CNContactStore()
            let contact = CNMutableContact()
            
            contact.familyName = userContact.lastName
            contact.middleName = userContact.middleName
            contact.givenName = userContact.firstName
            let homePhone = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: userContact.mobile ))
            contact.phoneNumbers = [homePhone]
            let controller = CNContactViewController(forUnknownContact : contact)
            controller.contactStore = store
            controller.delegate = self
            controller.allowsEditing = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController!.pushViewController(controller, animated: true)
            
            
            
            //                    do {
            //
            //                        let store = CNContactStore()
            //                        let contact = CNMutableContact()
            //                        contact.familyName = userContact.lastName
            //                        contact.middleName = userContact.middleName
            //                        contact.givenName = userContact.firstName
            //                        // Address
            //        //                let address = CNMutablePostalAddress()
            //        //                address.street = "Your Street"
            //        //                address.city = "Your City"
            //        //                address.state = "Your State"
            //        //                address.postalCode = "Your ZIP/Postal Code"
            //        //                address.country = "Your Country"
            //        //                let home = CNLabeledValue<CNPostalAddress>(label:CNLabelHome, value:address)
            //        //                contact.postalAddresses = [home]
            //
            //
            //                        let homePhone = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: userContact.mobile ))
            //                        contact.phoneNumbers = [homePhone]
            //
            //                        // Save
            //                        let saveRequest = CNSaveRequest()
            //                        saveRequest.add(contact, toContainerWithIdentifier: nil)
            //
            //                        try store.execute(saveRequest)
            //                    } catch(let error ) {
            //                        print(error)
            //                    }
        } else if(element.message_type == MessageType.location){
            let locationModel = element.message_content as! LocationModel
            self.openMap(lat: locationModel.latitude as String, long: locationModel.longitude as String, title: locationModel.name)
            
        }
    }
    func adjustUITextViewHeight(arg : UITextView) {
        //        arg.translatesAutoresizingMaskIntoConstraints = true
        //        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    
    
    fileprivate func playAudioFile(url: URL) {
        //        UIView.animate(withDuration: 0.2, delay: 0, animations: {
        //            self.audioPlayerHeightConstrant.constant = 40
        //            self.view.layoutIfNeeded()
        //        }, completion: nil)
        
        self.audioPlayer?.stopVideo()
        
        self.audioPlayerWrapper.isHidden = false
        bouncView(uiView: self.audioPlayerWrapper)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            self.audioPlayer?.loadVideos(with: [url])
            self.audioPlayer?.playVideo()
        }
        
    }
    
    fileprivate func openFile(url: URL, media: MediaModel) {
        
        if (media.file_meta.media_type == .audioM4A ){
            playAudioFile(url: url)
        } else if (media.file_meta.media_type == .videoMP4){
            //            playAudioFile(url: url)
            
            
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
            
            //            let vc = AppStoryboard.Main.viewController(viewControllerClass: VideoPlayViewController.self)
            //            vc.__video = url
            //            self.navigationController?.pushViewController(vc, animated: true)
        } else{
            preview = url
            let previewController = QLPreviewController()
            previewController.dataSource = self
            present(previewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        TODO:- Right logic to determin do we need to scroll again
        //        if indexPath.row + 1 == yourArray.count {
        //            print("do something")
        //        }
    }
}

extension ChatViewController: QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return preview as QLPreviewItem
    }
}

extension ChatViewController: SSAudioPlayerDelegate {
    func stopPlayer() {
        self.audioPlayerWrapper.isHidden = true
        //        bouncView(uiView: self.audioPlayerWrapper)
    }
}



//MARK:- image and camera Delegate
extension ChatViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func photoLibrary(type:UIImagePickerController.SourceType) {
        
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = 1
        pickerController.showsCancelButton = true
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            //  print(assets[0].type == .video)
            
            for asset in assets {
                switch asset.type {
                case .video:
                    if let videoAsset: PHAsset = asset.originalAsset {
                        guard (videoAsset.mediaType == .video) else {
                            print("Not a valid video media type")
                            return
                        }
                        
                        PHCachingImageManager().requestAVAsset(forVideo: videoAsset, options: nil) { (asset, audioMix, args) in
                            let asset = asset as! AVURLAsset
                            
                            DispatchQueue.main.async {
                                print(asset.url)
                                if let image = ThumbNail.getThumbnailFromFile(asset.url) {
                                    let file = SSFiles(url: asset.url, thumbImage: image)
                                    let imgsize=image.getSizeIn(.byte)
                                    self.uploadMedia(file: file, messageType: .video, fileMeta: [MediaMetaModel.KEY_FILE_TYPE: MediaType.videoMP4.rawValue,MediaMetaModel.KEY_FILE_SIZE:imgsize,MediaMetaModel.KEY_FILE_THUMB:image])
                                }else{
                                    let file = SSFiles(url: asset.url)
                                    self.uploadMedia(file: file, messageType: .video, fileMeta: [MediaMetaModel.KEY_FILE_TYPE: MediaType.videoMP4.rawValue])
                                }
                                
                            }
                        }
                    }
                    
                    break
                case .photo:
                    _ = asset.fileSize
                    
                    //                    asset.fetchImageData { (imageData, info) in
                    //                        print(imageData)
                    //                    }
                    var callOneTime = true
                    asset.fetchImage(with: PHImageManagerMaximumSize) { (image, info) in
                        
                        if let image = image {
                            if callOneTime{
                                if let thumbimage = ThumbNail.getThumbnailfromImage(imageT: image) {
                                    let imgsize=image.getSizeIn(.byte)
                                    
                                    self.uploadMedia( file: SSFiles(image: image, thumbImage: thumbimage), messageType: .image, fileMeta: [MediaMetaModel.KEY_FILE_TYPE:  MediaType.imageJPG.rawValue,MediaMetaModel.KEY_FILE_SIZE:imgsize,MediaMetaModel.KEY_FILE_THUMB:thumbimage])
                                }else{
                                    let imgsize=image.getSizeIn(.byte)
                                    let thumbimage = ThumbNail.getThumbnailfromImage(imageT: image)
                                    self.uploadMedia( file: SSFiles(image: image, thumbImage: UIImage()), messageType: .image, fileMeta: [MediaMetaModel.KEY_FILE_TYPE: MediaType.imageJPG.rawValue,MediaMetaModel.KEY_FILE_SIZE:imgsize,MediaMetaModel.KEY_FILE_THUMB:thumbimage ?? ""])
                                }
                                callOneTime = false
                            }
                            
                            
                        }
                    }
                    break
                }
            }
        }
        
        self.present(pickerController, animated: true) {}
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        print(info)
        
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            //            waitTextLabel.text = "Please wait file uploading..."
            //            NetworkManager.uploadChatFile( image: pickedImage  ) { (success, res) in
            //                self.waitTextLabel.text = ""
            //                if let response:[String:Any] = res as? [String:Any]{
            //                    let isSuccess:Int = response["code"] as! Int
            //                    if(isSuccess == 200){
            //                        let url = response["url"] as!  String
            //                        self.sendMessage(message: "", type: .image, file: url, command: "upload")
            //                    } else if(isSuccess == 500){
            //                        self.showAlertWithMessage(message: response["message"] as! String)
            //                    }
            //                }else if let response: String  = res as? String {
            //                    self.showAlertWithMessage(message: response)
            //                }
            //            }
        }
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension ChatViewController: UIDocumentPickerDelegate {
    func selectDocument() {
        
        //    kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet
        //    String(kUTTypePDF),String(kUTTypeRTFD),String(kUTTypeText),String(kUTTypeSpreadsheet)
        //    let test = UIDocumentPickerViewController
        
        let importMenu = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
        
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            if let popOver: UIPopoverPresentationController = importMenu.popoverPresentationController {
        //                popOver.sourceView = self.openDocBtn
        //                //            popOver.sourceRect = self.openDocBtn.layer.bounds
        //                //popOver.barButtonItem
        //            }
        //        }
        
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        print("import result : \(url)")
        
        let fileMeta = [
            MediaMetaModel.KEY_FILE_TYPE: MediaType.filePDF.rawValue,
            MediaMetaModel.KEY_FILE_NAME: url.lastPathComponent,
        ]
        
        self.uploadMedia(file: SSFiles(url: url), messageType: .document, fileMeta: fileMeta)
        
        
        
    }
    
    
    //    public func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
    //        documentPicker.delegate = self
    //        present(documentPicker, animated: true, completion: nil)
    //    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        //dismiss(animated: true, completion: nil)
    }
    
}

extension ChatViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextView) -> Bool {
        //        if(writeMessage.text != placeHolderString){
        //            sendMessage(message: writeMessage.text!, type: .text)
        //            writeMessage.text = placeHolderString
        //            //            writeMessage.resignFirstResponder()
        //        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            ///Fix it
            //            self.sendComponentRightCons.constant =  -(self.componentView.frame.width + 0)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        //        if (textView.text == placeHolderString){
        //            textView.text = ""
        //        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            ///Fix it
            //            self.sendComponentRightCons.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        //        if (textView.text == ""){
        //            textView.text = placeHolderString
        //        }
        
    }
}
//extension SingleChatViewController: GMSPlacePickerViewControllerDelegate{
//    // To receive the results from the place picker 'self' will need to conform to
//    // GMSPlacePickerViewControllerDelegate and implement this code.
//    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        //        print("Place name \(place.name)")
//        //        print("Place address \(place.formattedAddress)")
//        //        print("Place attributions \(place.attributions)")
//        //        print("Place attributions \(place)")
//
//        let messageDictionary = [
//            "name": place.name,
//            "address": place.formattedAddress ?? "",
//            "latitude": String(place.coordinate.latitude),
//            "longitude": String(place.coordinate.longitude)
//            ] as [String : Any]
//
//        let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary)
//        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
//        if let message:String = jsonString as String? {
//            self.sendMessage(message: message, type: .location)
//        }
//
//
//        //        openMap(place: place)
//        //        latitude = place.coordinate.latitude
//        //        longitude = place.coordinate.longitude
//
//    }
//
//    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        print("No place selected")
//    }
//}

//extension ChatViewController: PlacesPickerDelegate {
//    func placePickerControllerDidCancel(controller: PlacePickerController) {
//        controller.navigationController?.dismiss(animated: true, completion: nil)
//    }
//
//    func placePickerController(controller: PlacePickerController, didSelectPlace place: GMSPlace) {
//        controller.navigationController?.dismiss(animated: true, completion: nil)
//
//        let messageDictionary = [
//            "name": place.name ?? "",
//            "address": place.formattedAddress ?? "",
//            "latitude": String(place.coordinate.latitude),
//            "longitude": String(place.coordinate.longitude)
//            ] as [String : Any]
//
//        let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary)
//        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
//        if let message:String = jsonString as String? {
//            self.sendMessage(message: message, type: .location)
//        }
//    }
//}

extension ChatViewController: CLLocationManagerDelegate {
    
    func determineMyCurrentLocation() {
        let locationManager: CLLocationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        //        print("user latitude = \(userLocation?.coordinate.latitude)")
        //        print("user longitude = \(userLocation?.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

//extension ChatViewController: PickerRenderer {
//    func configureCancelButton(barButtonItem: UIBarButtonItem) {
//
//    }
//
//    func configureSearchButton(barButtonItem: UIBarButtonItem) {
//
//    }
//
//    func configureMapView(mapView: GMSMapView) {
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//    }
//
//    func configureTableView(mapView: UITableView) {
//
//    }
//}

extension ChatViewController: AGAudioRecorderDelegate {
    func agAudioRecorder(_ recorder: AGAudioRecorder, withStates state: AGAudioRecorderState) {
        
        switch state {
        case .Ready:
            //            playBtn.isEnabled = false
            //            sendBtn.isEnabled = false
            recordingState = .Ready
            break
        case .Pause:
            recordingState = .Pause
            break
        case .Play:
            //            playBtn.setTitle("Stop", for: UIControl.State.normal)
            recordingState = .Play
            break
        case .Finish:
            recordBtn.setTitle("Record", for: UIControl.State.normal)
            recordingState = .Finish
            //            playBtn.isEnabled = true
            //            sendBtn.isEnabled = true
            break
        case .Failed(_):
            break
        case .Recording:
            recordBtn.setTitle("Stop", for: UIControl.State.normal)
            recordingState = .Recording
            break
        case .error(_):
            break
        }
    }
    
    func agAudioRecorder(_ recorder: AGAudioRecorder, currentTime timeInterval: TimeInterval, formattedString: String) {
        recordingTimer.text = formattedString
    }
}
extension ChatViewController  {
    fileprivate func startRenderProgress(_ downloadRequest: DownloadRequest, _ indexPath: IndexPath, _ url: String) {
        downloadRequest.downloadProgress(closure: { (progress) in
            if let cell: DownloadTableCell = self.tableView.cellForRow(at: indexPath) as? DownloadTableCell {
                //                        cell.downloadProgress =
                
                cell.download(progress: progress.fractionCompleted)
            }
            
            print(progress)
        }).response(completionHandler: { (DefaultDownloadResponse) in
            print(DefaultDownloadResponse)
            if DefaultDownloadResponse.error == nil{
                DispatchQueue.main.async {
                    self.tableList[indexPath.section][indexPath.row].downloadStatus = .downloaded
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.tableList[indexPath.section][indexPath.row].downloadStatus = .pending
                    self.tableView.reloadData()
                }
            }
            ChatViewController.downloadRequest.removeValue(forKey: url.toMD5)
            
        })
    }
    
    fileprivate func downloadFiles(url: String, indexPath: IndexPath, stopDownloading: Bool = false) {
        //        let stopDownloading: Bool = self.tableList[indexPath.section][indexPath.row].downloadStatus == .downloading
        self.tableList[indexPath.section][indexPath.row].downloadStatus = .downloading
        self.tableView.reloadData()
        if let downloadRequest: DownloadRequest = ChatViewController.downloadRequest[url.toMD5]{
            
            if stopDownloading {
                downloadRequest.cancel()
                ChatViewController.downloadRequest.removeValue(forKey: url.toMD5)
                
                self.tableList[indexPath.section][indexPath.row].downloadStatus = .pending
                self.tableView.reloadData()
            }else{
                startRenderProgress(downloadRequest, indexPath, url)
                
            }
            
        } else{
            let destination: DownloadRequest.Destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            let downloadRequest = AF.download(url, method: .get, to: destination)
            ChatViewController.downloadRequest[url.toMD5] = downloadRequest
            
            startRenderProgress(downloadRequest, indexPath, url)
        }
        
    }
    
    func uploadMedia(file: SSFiles, messageType: MessageType, fileMeta: [String: Any]) {
        let parma = ["room_id": self.roomId]
        if let statusview: UploadStatusView = UploadStatusView.initialize(with: CGRect(x: 0, y: 0, width: self.uploadMediaProgress.frame.width, height: 50)) {
            
            statusview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                statusview.heightAnchor.constraint(equalToConstant: 50),
            ])
            
            //    self.uploadMediaProgress.addSubview(statusview)
            self.uploadMediaProgress.insertArrangedSubview(statusview, at: 0)
            statusview.delegate = self
            statusview.uploadChatFile( file: file, parameters: parma, messageType: messageType, fileMeta: fileMeta, date: Date() )
            
        }
    }
}
extension ChatViewController: UploadStatusDelegate {
    func fileUploaded(response: NetworkResponseState, uploadStatusView: UploadStatusView, messageType: MessageType, fileMeta: [String : Any], date: Date) {
        //                self.viewloader?.removeFromSuperview()
        
        switch response {
        case .failed( _ ):
            //self.showToast(message: errorMessage)
            break
        case .success(let response ):
            let isSuccess:Int = response["status_code"] as? Int ?? 500
            if(isSuccess == 200){
                if let dataDict = response["data"] as? [String:Any]{
                    if let url: URL = (dataDict["url"] as? String ?? "").getMediaUrl {
                        
                        var metaX = fileMeta
                        let thumbString = dataDict["thumbnail"] as? String ?? ""
                        
                        if thumbString != "", let thumbnailUrl = thumbString.getMediaUrl {
                            metaX[MediaMetaModel.KEY_FILE_THUMB] = thumbnailUrl.absoluteString
                        }
                        
                        
                        
                        
                        let messageContent: [String: Any] = ["url": url.absoluteString, "file_type": fileMeta["file_type"] ?? "","file_name":"9208.bin","file_size":fileMeta["file_size"] ?? ""]
                        self.sendMessage(message: "", type: messageType, messageContent: messageContent, date: date)
                    }
                }
                
            } else if(isSuccess == 500) {
                self.showToast(message: response["message"] as! String)
            }
            break
        }
        
        uploadStatusView.removeFromSuperview()
    }
}




// MARK: - WebSocketDelegate
extension ChatViewController: SocketObserver {
    func registerFor() -> [ResponseType] {
        return [.message,
                .userModified,
                .allBlockUser,
                .blockUserModified,
                .roomsDetails,
                .allRooms,
                .createRoom
        ]
    }
    
    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        
        print("ChatViewController:: observerWithIdentifire", message)
        if observerWithIdentifire == .message {
            if (statusCode == 200){
                if let data: [[String : Any]] = data["data"] as? [[String: Any]] {
                    appendMessages(data)
                }
            } else if (statusCode == 201){
                
                if let data: [String : Any] = data["data"] as? [String: Any] {
                    if let tmpRoomId = data["roomId"] as? String, tmpRoomId == roomId {
                        let msgId = data["_id"] as? String
                        if msgId == lastMessageID{
                            print("duplicate message")
                        }else{
                            lastMessageID = msgId ?? ""
                            appendMessage(data)
                        }
                        
                    } else {
                        print("ChatViewController:: String Mesage is not form this Room")
                    }
                    
                }
                
                
            }
            
        } else if observerWithIdentifire == .userModified {
            print("ChatViewController", observerWithIdentifire, message)
            if (statusCode == 200){
                if let data: [String : Any] = data["data"] as? [String: Any] {
                    
                    let updatedUserInfo = UserDetailsModel.giveObj(cdic: data)
                    
                    ChatListView.userDetailsList[updatedUserInfo.userId] = updatedUserInfo
                    if (individualDetail?.userId == updatedUserInfo.userId){
                        individualDetail = updatedUserInfo
                        setUpName()
                    }
                }
            }
        } else if observerWithIdentifire == .blockUserModified {
            print("ChatViewController", observerWithIdentifire, message)
            if (statusCode == 200){
                if !isGroup {
                    if let data: [String : Any] = data["data"] as? [String: Any] {
                        let blockItem = BlockUserModel(cdic: data)
                        
                        if blockItem.blockedTo ==  UserModel.getSchoolDataModel().user_id &&
                            blockItem.blockedBy == individualDetail?.userId && blockItem.isBlock {
                            blockedByOtherUser();
                            
                        }
                        
                        if blockItem.blockedTo ==  UserModel.getSchoolDataModel().user_id &&
                            blockItem.blockedBy == individualDetail?.userId && !blockItem.isBlock {
                            unBlockedByOtherUser();
                            
                        }
                        
                        if blockItem.blockedTo == individualDetail?.userId &&
                            blockItem.blockedBy ==  UserModel.getSchoolDataModel().user_id && blockItem.isBlock {
                            isMute = true;
                            
                        }
                    }
                }
            }
        } else if observerWithIdentifire == .allBlockUser {
            print("ChatViewController", observerWithIdentifire, message)
            if (statusCode == 200){
                if !isGroup {
                    if let data: [[String : Any]] = data["data"] as? [[String: Any]] {
                        let blockUserList = BlockUserModel.giveList(list: data)
                        for blockItem in blockUserList {
                            if blockItem.blockedTo ==  UserModel.getSchoolDataModel().user_id &&
                                blockItem.blockedBy == individualDetail?.userId && blockItem.isBlock {
                                blockedByOtherUser();
                                break;
                            }
                            
                            if blockItem.blockedTo ==  UserModel.getSchoolDataModel().user_id &&
                                blockItem.blockedBy == individualDetail?.userId && !blockItem.isBlock {
                                unBlockedByOtherUser();
                                break;
                            }
                            
                            if blockItem.blockedTo == individualDetail?.userId &&
                                blockItem.blockedBy ==  UserModel.getSchoolDataModel().user_id && blockItem.isBlock {
                                isMute = true;
                                break;
                            }
                            
                        }
                        
                    }
                }
            }
        } else if observerWithIdentifire == .roomsDetails {
            print("ChatViewController", observerWithIdentifire, message)
            if (statusCode == 200){
                if let data: [String : Any] = data["data"] as? [String: Any] {
                    
                    
                    let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                    
                    tmpUserList.forEach { (element) in
                        ChatListView.userDetailsList[element.userId] = element
                    }
                    
                    
                    let roomList = ChatRoomModel.giveList(list: data["roomList"] as? [[String: Any]] ?? [])
                    if (roomList.count > 0 ){
                        individualDetail = ChatListView.userDetailsList[roomList[0].individualUserId]
                    }
                    
                    self.allMessage()
                    setUpName()
                    ///TODO:-
                    
                }
                
            }
        }else if (observerWithIdentifire == .allRooms){
            if let data = data["data"] as? [String: Any] {
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                print(tmpUserList)
                tmpUserList.forEach { (element) in
                    if element.userId == buddyID{
                        self.isRoomFind = true
                        
                    }
                    
                }
                
                print(ChatListView.userDetailsList)
                
                
                let allRms = ChatRoomModel.giveList(list: data["roomList"] as? [[String: Any]] ?? [] )
                for allroom in allRms{
                    if allroom.individualUserId == buddyID{
                        self.roomId = allroom.id
                        self.getRoomInfo()
                        
                    }
                }
                
            }
            
            
        } else if (observerWithIdentifire == .createRoom){
            if let data = data["data"] as? [String: Any] {
                let tmpUserList = UserDetailsModel.giveList(list: data["userList"] as? [[String: Any]] ?? [])
                //                var userDetailsList: [String: UserDetailsModel] = [:]
                tmpUserList.forEach { (element) in
                    ChatListView.userDetailsList[element.userId] = element
                }
                print(tmpUserList)
                print(ChatListView.userDetailsList)
                if let newRoom = data["newRoom"] as? [String: Any] {
                    let updatedRoom = ChatRoomModel(disc: newRoom)
                    
                    
                    
                    let Uid = obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""
                    if let individualDetail: UserDetailsModel = ChatListView.userDetailsList[buddyID] {
                        self.individualDetail = individualDetail
                        if roomId == ""{
                            self.roomId = updatedRoom.id
                            RoomCretaed!("created")
                        }else{
                            print("Room Already Created")
                        }
                        
                    }else{
                        //                                self.showCustomPopupView(altMsg: "Vendor detail not found", alerttitle: "", alertimg: UIImage(named:"Errorimg") ?? UIImage ()) {
                        //                                    self.dismiss(animated: true, completion: nil)
                        //                                }
                    }
                    
                    
                    
                }
                
                
            
                
                
            }
        }
        
    }
    
    
    func socketConnection(status: SocketConectionStatus) {
        print("websocket connected!!")
    }
}
