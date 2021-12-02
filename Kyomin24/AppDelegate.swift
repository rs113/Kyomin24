//
//  AppDelegate.swift
//  Mzadi
//
//  Created by MacBook on 07/06/21.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps
import Firebase
import FirebaseMessaging
import UserNotifications
import Localize_Swift
import FacebookCore

let appDelegate = UIApplication.shared.delegate as! AppDelegate
var canHaveNewNoti = false
var SavedPayLoad:[String:Any]?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let selectLanguage = SelectLanguage.none
    let gcmMessageIDKey="gcm.message_id"
    var  Firebasetoken=""
    var window: UIWindow?
    var center = UNUserNotificationCenter.current()
    var Payload=[String:Any]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // for language change at runtime
        IQKeyboardManager.shared.enable = true
        checkInterfaceMod()
        setRootVc()
        GMSPlacesClient.provideAPIKey("AIzaSyCv1E0nUu88UcCXq_3h1Iv0R_voN5MBpp0")
        GMSServices.provideAPIKey("AIzaSyCv1E0nUu88UcCXq_3h1Iv0R_voN5MBpp0")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            SocketManager.shared.connectSocket(notify: true)
            SocketManager.shared.registerToScoket(observer: self)
           
        }
        
        
        if Localize.currentLanguage() == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else if Localize.currentLanguage() == "ku"{
             UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        
        firebaseAppConfigureation()
        Messaging.messaging().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setrootToredirectPageAppComefromKill), name:NSNotification.Name("ManageNotificationFromKill"), object: nil)
//
        
        return true
    }
    
    
    func application(
           _ app: UIApplication,
           open url: URL,
           options: [UIApplication.OpenURLOptionsKey : Any] = [:]
       ) -> Bool {

           ApplicationDelegate.shared.application(
               app,
               open: url,
               sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
               annotation: options[UIApplication.OpenURLOptionsKey.annotation]
           )

       }
    
    
    func setRootVc(){
        
        if obj.prefs.value(forKey: APP_IS_LOGIN) as? String == "1"{
            let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
            let NavVC = UINavigationController(rootViewController: vc)
            NavVC.isNavigationBarHidden = true
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
        }else{
            
            let vc = SelectlanguageViewController.instance(.main) as! SelectlanguageViewController
             let NavVC = UINavigationController(rootViewController: vc)
             NavVC.isNavigationBarHidden = true
               self.window?.rootViewController = NavVC
               self.window?.makeKeyAndVisible()
        }
        
    }
    
    func checkInterfaceMod() {
        if Defaults.getBoolValue(forKey: ConstantApp.IS_DARK_MODE_UNABLE) {
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }            }
        } else {
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }          }
        }
        
        
    }
    func firebaseAppConfigureation(){
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            let center = UNUserNotificationCenter.current()
            // For iOS 10 display notification (sent via APNS)
            center.delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            center.requestAuthorization(options: authOptions) { (br, er) in
                
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
    
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        //    UIApplication.shared.applicationIconBadgeNumber = 0
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        
        // call on
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        let Apsdata = userInfo["aps"] as? [String:Any]
        
        
        let PayLoaddata = userInfo["for"] as? String
        
        print(PayLoaddata)
       // msg notification
        
        let MsgPayload = userInfo["payload"] as? String

        let MessagePayload = convertToDictionary(text: MsgPayload ?? "")
        print(MessagePayload)

        let msgPayvalue = MessagePayload?["payload"]

        let msgRoomid = MessagePayload?["id"]
        
        let Forid = userInfo["for_id"] as? String
        
        let msgstr = "\(msgPayvalue ?? "")"
        
      //  let Payload:[String:Any]=["forvalue":msgPayvalue ?? "","forid":msgRoomid ?? ""]
        
        
      //  setrootmsg(payload: Payload)
//        if msgstr == "17"{
//         let Payload:[String:Any]=["forvalue":msgPayvalue ?? "","forid":msgRoomid ?? ""]
//        }else{
//        let Payload:[String:Any]=["forvalue":PayLoaddata ?? "","forid":Forid ?? ""]
//        }
        
       
        if msgstr == "17"{
            
        }else{
            let NotiValue=true
            let data: [String:Any] = ["NotiValue": NotiValue]
            NotificationCenter.default.post(name:NSNotification.Name("myhome"), object: nil, userInfo:data)
            
        }
        
        
//        let NotiValue=true
//        let data: [String:Any] = ["NotiValue": NotiValue]
//        NotificationCenter.default.post(name:NSNotification.Name("myhome"), object: nil, userInfo:data)
//
        // let PayLoad = convertToDictionary(text: PayLoaddata ?? "")
        
       // setroot(payload: Payload)
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([[.alert, .sound , .badge]])
    }
    
   
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
       
        
        
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        let Apsdata = userInfo["aps"] as? [String:Any]
        
        
        
        let PayLoaddata = userInfo["for"] as? String
        
        print(PayLoaddata)
        
        let Forid = userInfo["for_id"] as? String
        
        
        
        let MsgPayload = userInfo["payload"] as? String
        
        let MessagePayload = convertToDictionary(text: MsgPayload ?? "")
        print(MessagePayload)
        
        let msgPayvalue = MessagePayload?["payload"]
        
        let msgRoomid = MessagePayload?["id"]
        
        
        let msgstr = "\(msgPayvalue ?? "")"
        
        
        if msgstr == "17"{
            Payload=["forvalue":msgPayvalue ?? "","forid":msgRoomid ?? ""]
        }else{
            Payload=["forvalue":PayLoaddata ?? "","forid":Forid ?? ""]
            let NotiValue=true
            let data: [String:Any] = ["NotiValue": NotiValue]
            NotificationCenter.default.post(name:NSNotification.Name("myhome"), object: nil, userInfo:data)
            
        }

        setroot(payload: Payload)
        
        print(userInfo)
        
        completionHandler()
    }
   
       func RegisterUseronSocketServer(){
        
        let messageDictionary = [
               "request": "login",
               "userId": obj.prefs.value(forKey: APP_USER_ID) as? String ?? "",
               "type": "loginOrCreate",
               "fcm_token":obj.prefs.value(forKey: APP_FCM_TOKEN) ?? "",
               "userName":obj.prefs.value(forKey: APP_MOBILE_NUM) ?? "",
               "firstName":obj.prefs.value(forKey: APP_USER_NAME) ?? "",
               "password": "12345678",
               "profile_pic":obj.prefs.value(forKey: App_User_Img) ?? "",
               "lastSeen":Date().currentTimeMillis()
               
               ] as [String : Any]
           
           let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary)
           let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
           if let message:String = jsonString as String?{
               SocketManager.shared.sendMessageToSocket(message: message)
               
           }
           
       }
       
       
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func setrootmsg(payload:[String:Any]){
        print(payload)
        let payloadid = "\(payload["forvalue"] ?? "")"
        print(payloadid)
        
        if obj.prefs.value(forKey: APP_IS_LOGIN) as? String == "1"{
            
    NotificationCenter.default.post(name:NSNotification.Name("myadd"), object: nil, userInfo:payload)
        
        }
        
    }
    

    func setroot(payload:[String:Any]){
        print(payload)
        let payloadid = "\(payload["forvalue"] ?? "")"
        print(payloadid)
        canHaveNewNoti = true
        SavedPayLoad = payload
        if obj.prefs.value(forKey: APP_IS_LOGIN) as? String == "1"{
//            if payloadid == "0" {
//                NotificationCenter.default.post(name:NSNotification.Name("myadd"), object: nil, userInfo:payload)
//            }else if payloadid == "2"{
//                NotificationCenter.default.post(name:NSNotification.Name("myadd"), object: nil, userInfo:payload)
//            }else if payloadid == "17"{
//              NotificationCenter.default.post(name:NSNotification.Name("myadd"), object: nil, userInfo:payload)
//            }
//            else{
//                NotificationCenter.default.post(name:NSNotification.Name("myadd"), object: nil, userInfo:payload)
//            }
//
    NotificationCenter.default.post(name:NSNotification.Name("myadd"), object: nil, userInfo:payload)
        }
        
    }
    
    
//    @objc func setrootToredirectPageAppComefromKill(noti:NSNotification){
//
////             let userInfo = noti.userInfo as? [String:Any]
////
////
////              let MsgPayload = userInfo?["payload"] as? String
////
////               let MessagePayload = convertToDictionary(text: MsgPayload ?? "")
////               print(MessagePayload)
////
////               let msgPayvalue = MessagePayload?["payload"]
////
////               let msgRoomid = MessagePayload?["id"]
////
////
////               let msgstr = "\(msgPayvalue ?? "")"
////
////
////
////            if msgstr == "17"{
////                NotificationCenter.default.post(name: NSNotification.Name("ManageNotification"), object: nil, userInfo:userInfo)
////            }
////
////
////
//
//        let payload = noti.userInfo as? [String:Any]
//                   print(payload)
//                   let payloadid = "\(payload?["id"] ?? "")"
//                       print(payloadid)
//
//                   if payloadid == "17"{
//                       NotificationCenter.default.post(name: NSNotification.Name("ManageNotification"), object: nil, userInfo:payload)
//                   }
//
//
//
//
//                   }
//
//
//

           }


extension AppDelegate:SocketObserver{

    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        print("")
    }

    func registerFor() -> [ResponseType] {
        return [.loginOrCreate]
    }

    func socketConnection(status: SocketConectionStatus) {
        print(status)
        if status == .connected{
            if obj.prefs.value(forKey: APP_IS_LOGIN) as? String == "1"{
                self.RegisterUseronSocketServer()
                
                
                
            }
            print("connected")
        }
    }
}


// cloud messsaging delegate
extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken ?? "")")
        Firebasetoken=fcmToken ?? ""
        print("Firebasetoken:\(Firebasetoken)")
        
        UserDefaults.standard.set(Firebasetoken, forKey: "fcmToken")
        obj.prefs.set(fcmToken, forKey: APP_FCM_TOKEN)
        let dataDict:[String: Any] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}











