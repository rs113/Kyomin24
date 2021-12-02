//
//  SceneDelegate.swift
//  Mzadi
//
//  Created by MacBook on 07/06/21.
//

import UIKit
import SwiftyJSON
import FacebookCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    
    
    var window: UIWindow?
    var typeof:String?
    var Id:String?
    var Name:String?
    var datadic=[String:Any]()
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        SetRootVc()
        checkInterfaceMod()
        
        guard let _ = (scene as? UIWindowScene) else { return }
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
    
    func SetRootVc(){
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
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    
    
    
    //    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    //      guard let context = URLContexts.first else { return }
    //        print("url: \(context.url.absoluteURL)")
    //        print("scheme: \(context.url.scheme)")
    //        print("host: \(context.url.host)")
    //        print("path: \(context.url.path)")
    //        print("components: \(context.url.pathComponents)")
    //
    //    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let urlToOpen = userActivity.webpageURL else {
            return
        }
        
        handleURL(urlToOpen)
    }
    
    
    
    // convert url string to json data
    func handleURL(_ url: URL) {
        guard url.pathComponents.count >= 3 else { return }
        
        let section = url.pathComponents[1]
        let detail = url.pathComponents[2]
        
        let str = detail
        print("Original: \(str)")
        
        
        let data = Data(base64Encoded:str)
        do{
            let Jsondata = try JSON(data: data ?? Data(), options:.fragmentsAllowed)
            
            //(data: data!, encoding: .utf8)!
            print(Jsondata)
            typeof=Jsondata["type"].string
            Id=Jsondata["id"].string
            datadic=["type":typeof ?? "","id":Id ?? ""]
            
            navigateToItem(sharedata: datadic)
            
        }catch {
            print("fbnfbnb")
        }
        
        
    }
    
    
    func navigateToItem(sharedata:[String:Any]) {
        print(sharedata)
        NotificationCenter.default.post(name:NSNotification.Name("myshare"), object: nil, userInfo:sharedata)
        
    }
    
    
    //        if typeof == "user"{
    //         let vc = MyProfileVC.instance(.myAccountTab) as! MyProfileVC
    //            vc.sellerId=Id ?? ""
    //            vc.vctype="profile"
    //         let NavVC = UINavigationController(rootViewController: vc)
    //             NavVC.isNavigationBarHidden = true
    //            self.window?.rootViewController = vc
    //            self.window?.makeKeyAndVisible()
    //        }else{
    //            let vc = ProductDetailsVC.instance(.homeTab) as! ProductDetailsVC
    //                       vc.productId=Id ?? ""
    //
    //                    let NavVC = UINavigationController(rootViewController: vc)
    //                        NavVC.isNavigationBarHidden = true
    //                       self.window?.rootViewController = vc
    //                       self.window?.makeKeyAndVisible()
    //        }
    //
    
    
    
    
    
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        //        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        //            SocketManager.shared.connectSocket(notify: true)
        //            SocketManager.shared.registerToScoket(observer: self)
        //        }
        print("applicationWillEnterForeground")
        //    let NotiValue=true
        //    let data: [String:Any] = ["NotiValue": NotiValue]
        //    NotificationCenter.default.post(name:NSNotification.Name("myhome"), object: nil, userInfo:data)
        
    }
    
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        //        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        //                   SocketManager.shared.connectSocket(notify: false)
        //                   SocketManager.shared.unregisterToSocket(observer: self)
        //               }
        
        
        //        print("applicationWillEnterBackground")
        //        let NotiValue=true
        //        let data: [String:Any] = ["NotiValue": NotiValue]
        //        NotificationCenter.default.post(name:NSNotification.Name("myhome"), object: nil, userInfo:data)
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}

extension SceneDelegate:SocketObserver{

    func brodcastSocketMessage(to observerWithIdentifire: ResponseType, statusCode: Int, data: [String : Any], message: String) {
        print("")
    }

    func registerFor() -> [ResponseType] {
        return [.loginOrCreate]
    }

    func socketConnection(status: SocketConectionStatus) {
        print(status)
        if status == .connected{
           print("connected")
        }
    }
}

