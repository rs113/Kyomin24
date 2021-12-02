

import UIKit
import NVActivityIndicatorView
import AVKit
import MobileCoreServices




 let obj                            = Methods()



//let appDelegate                    = UIApplication.shared.delegate as! AppDelegate
let SCREEN_WIDTH                   = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT                  = UIScreen.main.bounds.size.height
let APP_packet_ID  = "packet"







var img_indicator:UIImageView!
var viewindicator =  UIView()
var indicator:NVActivityIndicatorView?

enum valid_States{
    case valid
    case inValid(String)
}
extension NSDate {
    
    // MARK: - Dates comparison
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedSame
    }
}
enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 2), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -2), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .lightGray, opacity: Float, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowOffset  = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius  = radius
    }
    func addViewBorder(color: UIColor, borderWidth: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.borderWidth   = borderWidth
       self.layer.borderColor    = color.cgColor
    }
    
 
       
        func topCorners(cornerRadius: Double) {
            self.layer.cornerRadius = CGFloat(cornerRadius)
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        func bottomCorners(cornerRadius: Double) {
            self.layer.cornerRadius = CGFloat(cornerRadius)
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    
}


// for app update 
extension Bundle {

    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    var bundleId: String {
        return bundleIdentifier!
    }

    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }

}

extension UIViewController{
    func alertShow(tr:String,msgString:String){
            
            let alertController = UIAlertController(title: tr, message: msgString as String?, preferredStyle: .alert)
            let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
              
            }
            
            alertController.addAction(noAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    
    // alert action
    func Alertwithaction(message: String, title: String,action_ok_tapped:@escaping (String) -> Void ) {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"OK", style: .default) { (arr) in
            action_ok_tapped("OK")
        }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
    }
    
        func alertShowWithPopBAck(tr:String,msgString:String){
            
            let alertController = UIAlertController(title: tr, message: msgString as String?, preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(noAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    //    func show_noConnection_popUp(objVc:UIViewController) -> Void {
    //        let mystory = UIStoryboard(name: "Main", bundle: nil)
    //        let vc = mystory.instantiateViewController(withIdentifier:"No_Internet_Connection_VC" ) as! No_Internet_Connection_VC
    //        vc.modalPresentationStyle = .overCurrentContext
    //
    //        objVc.present(vc, animated: false, completion: nil)
    //    }
        
        func alertShowWithAction(tr:String,msgString:String,action_ok_tapped:@escaping (String) -> Void){
            
            let alertController = UIAlertController(title: tr, message: msgString as String?, preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                action_ok_tapped("ok")
            }
    //        let cancel_rmv = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
    //
    //        }
            
            alertController.addAction(noAction)
          //  alertController.addAction(cancel_rmv)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        func alertShowWithAction_cancel(tr:String,msgString:String,action_ok_tapped:@escaping (String) -> Void){
            
            let alertController = UIAlertController(title: tr, message: msgString as String?, preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                action_ok_tapped("ok")
            }
                    let cancel_rmv = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
                    }
            
            alertController.addAction(noAction)
            alertController.addAction(cancel_rmv)
            
            self.present(alertController, animated: true, completion: nil)
        }
    
    
    // alert action
    func Alertwithactionok(message: String, title: String,action_ok_tapped:@escaping (String) -> Void ) {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"Ok", style: .default) { (arr) in
            action_ok_tapped("Ok")
        }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
    }
        
        
        func showToast(message : String,objvc:UIViewController) {
            
            let toastLabel = UILabel(frame: CGRect(x: 10, y: objvc.view.frame.size.height-120, width: SCREEN_WIDTH-20, height: 60))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
            toastLabel.numberOfLines = 0
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            objvc.view.addSubview(toastLabel)
            UIView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    
    func showToastLong(message : String,objvc:UIViewController) {
        
        let toastLabel = UILabel(frame: CGRect(x: 10, y: objvc.view.frame.size.height-120, width: SCREEN_WIDTH-20, height: 80))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        objvc.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
 
         func showLoader() {
            
                    DispatchQueue.main.async
                        {
                            viewindicator.removeFromSuperview()
                            viewindicator = UIView()
                            viewindicator.backgroundColor    = UIColor.lightGray.withAlphaComponent(0.4)

                            let viewSmaillBack = UIView(frame: CGRect(x: SCREEN_WIDTH/2-60,y:SCREEN_HEIGHT/2-60,width:120,height:120))
                            viewSmaillBack.backgroundColor = .white
                            viewSmaillBack.layer.cornerRadius = 10
                            viewSmaillBack.clipsToBounds = true
                            viewSmaillBack.layer.borderColor = UIColor.lightGray.cgColor
                            viewSmaillBack.layer.borderWidth = 0.5
                            if let bnd = self.view.window?.bounds{
                              viewindicator.frame = (self.view.window?.bounds)!
                            }else{
                                
                            }
                            
                            indicator  = NVActivityIndicatorView(frame:CGRect(x: 30,y:30,width:60,height:60),type: .ballClipRotatePulse,color: App_main_clor ,padding:5)
                            indicator?.startAnimating()
                          //  img_indicator = UIImageView(frame:CGRect(x: 20,y:20,width:80,height:80))
                            //img_indicator.image = UIImage.gif(name: "loading-stivale")
                            
                          //  img_indicator.startAnimating()
                            
                            viewSmaillBack.addSubview(indicator ?? UIView())
                            viewindicator.addSubview(viewSmaillBack)
                            self.view.window?.addSubview(viewindicator)
                    }
//                 var config : SwiftLoader.Config = SwiftLoader.Config()
//                 config.size = 50
//                 config.backgroundColor = UIColor.white
//                 config.titleTextColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
//                 config.spinnerLineWidth = 2.0
//                 config.foregroundColor = UIColor.clear
//                 config.foregroundAlpha = 0.1
//                 config.spinnerColor = UIColor(red: 86.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0)
//
//                 SwiftLoader.setConfig(config: config)
//                 SwiftLoader.show(animated: true)
         }
             
       func hideLoader(){
        DispatchQueue.main.async {
            if indicator != nil{
                indicator?.stopAnimating()
                indicator?.removeFromSuperview()
                
            }
            
            viewindicator.removeFromSuperview()
        }

           //SwiftLoader.hide()
      }
    
    //Show LOcation Enable popip
    
    func showGpsPopup(){
//        let vc = second.instantiateViewController(withIdentifier: "GpsEnablePopup_VC") as! GpsEnablePopup_VC
//
//            vc.modalPresentationStyle = .overCurrentContext
//           self.present(vc, animated: true) {
//               print("pop")
//           }
    }
    func showCustomPopup(altMsg:String,alerttitle:String,alertimg:UIImage,cancelHide:Bool,OkAction:@escaping ()->Void){
        let vc = CustomPopUpVC.instance(.main) as! CustomPopUpVC
//    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomPopUpVC") as! CustomPopUpVC

                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.alertMessage = altMsg
                vc.alertTitle=alerttitle
                vc.alertImage=alertimg
                vc.cancelHide = cancelHide
               self.present(vc, animated: true) {
                   print("pop")
               }
           OKNewCallBack = { () in
              OkAction()
          }
        }
    
    
    
    func showCustomPopupView(altMsg:String, alerttitle:String, alertimg:UIImage, OkAction:@escaping ()->Void){
          let vc = CustomPopView.instance(.main) as! CustomPopView
          
          vc.modalPresentationStyle = .overCurrentContext
          vc.modalTransitionStyle = .crossDissolve
          vc.alertMessage = altMsg
          vc.alertTitle=alerttitle
          vc.alertImage=alertimg
        
          self.present(vc, animated: true) {
              print("pop")
          }
          OKNewCallBack = { () in
              OkAction()
          }
      }
    
    
    func showCustomPopupViewAction(altMsg:String, alerttitle:String, alertimg:UIImage,btnText:String, OkAction:@escaping (CustomPopViewViewGuest)->Void){
          let vc = CustomPopViewViewGuest.instance(.main) as! CustomPopViewViewGuest
          //    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomPopView") as! CustomPopView
          
          vc.modalPresentationStyle = .overCurrentContext
          vc.modalTransitionStyle = .crossDissolve
          vc.alertMessage = altMsg
          vc.alertTitle=alerttitle
          vc.alertImage=alertimg
          vc.btntext=btnText
          self.present(vc, animated: true) {
              print("pop")
          }
          OKNewCallBack = { () in
              OkAction(vc)
          }
      }
    
    func showCustomSnackAlert(altMsg:String,OkAction:@escaping ()->Void){
            let vc = CustomSnackAlertView.instance(.main) as! CustomSnackAlertView

                    vc.modalPresentationStyle = .overCurrentContext
                    vc.modalTransitionStyle = .crossDissolve
                    vc.alertMsg = altMsg
                   self.present(vc, animated: true) {
                       print("pop")
                   }
               OKNewCallBack = { () in
                  OkAction()
              }
        }
    
    
    
//    func ShowFeedCustomPopup(MyOrderAction:@escaping ()->Void){
//       let vc = storyHome.instantiateViewController(withIdentifier: "FeedbackPopupVC") as! FeedbackPopupVC
//
//            vc.modalPresentationStyle = .overCurrentContext
//            vc.modalTransitionStyle = .crossDissolve
//           self.present(vc, animated: true) {
//               print("pop")
//           }
//       MyOrderCallBack = { () in
//          MyOrderAction()
//      }
//    }
    
   func changeStatusBarColor() {
       if #available(iOS 13.0, *) {
           let app = UIApplication.shared
           let statusBarHeight: CGFloat = app.statusBarFrame.size.height
           
           let statusbarView = UIView()
           statusbarView.backgroundColor = #colorLiteral(red: 0, green: 0.8980392157, blue: 0.3019607843, alpha: 1)
           view.addSubview(statusbarView)
         
           statusbarView.translatesAutoresizingMaskIntoConstraints = false
           statusbarView.heightAnchor
               .constraint(equalToConstant: statusBarHeight).isActive = true
           statusbarView.widthAnchor
               .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
           statusbarView.topAnchor
               .constraint(equalTo: view.topAnchor).isActive = true
           statusbarView.centerXAnchor
               .constraint(equalTo: view.centerXAnchor).isActive = true
         
       } else {
           let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
           statusBar?.backgroundColor = #colorLiteral(red: 0, green: 0.8980392157, blue: 0.3019607843, alpha: 1)
       }
   }
   
       func scrollToTop() {
           func scrollToTop(view: UIView?) {
               guard let view = view else { return }

               switch view {
               case let scrollView as UIScrollView:
                   if scrollView.scrollsToTop == true {
                       scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
                       return
                   }
               default:
                   break
               }

               for subView in view.subviews {
                   scrollToTop(view: subView)
               }
           }

           scrollToTop(view: view)
       }

       // Changed this

       var isScrolledToTop: Bool {
           if self is UITableViewController {
               return (self as! UITableViewController).tableView.contentOffset.y == 0
           }
           for subView in view.subviews {
               if let scrollView = subView as? UIScrollView {
                   return (scrollView.contentOffset.y == 0)
               }
           }
           return true
       }
        
    func log_Out_from_App(){
        
        var navArr = self.navigationController!.viewControllers as Array
        
        
        obj.prefs.removeObject(forKey: APP_IS_LOGIN)
        obj.prefs.removeObject(forKey: APP_ACCESS_TOKEN)
        obj.prefs.removeObject(forKey: APP_CURRENT_LANG)
        var isfind = false
        for vc in navArr{
            if vc.isKind(of: LoginViewController.self){
                self.navigationController?.popToViewController(vc, animated: true)
                isfind = true
                break
            }else{
                navArr.remove(at: navArr.count-1)
            }
        }
        if !isfind{
            let vc = LoginViewController.instance(.main) as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        
    }
    
    func MovetoLogin(){
        
        var navArr = self.navigationController!.viewControllers as Array
        
        
        obj.prefs.removeObject(forKey: APP_IS_LOGIN)
        obj.prefs.removeObject(forKey: APP_ACCESS_TOKEN)
        obj.prefs.removeObject(forKey: APP_CURRENT_LANG)
        var isfind = false
        for vc in navArr{
            if vc.isKind(of: LoginViewController.self){
                self.navigationController?.popToViewController(vc, animated: true)
                isfind = true
                break
            }else{
                navArr.remove(at: navArr.count-1)
            }
        }
        if !isfind{
            let vc = LoginViewController.instance(.main) as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        
    }
//
    func PopToSpecificController(vcMove:AnyClass){

             var navArr = self.navigationController!.viewControllers as Array
             

            // UserModel.removeAllAccounts()
             var isfind = false
             for vc in navArr{
                 if vc.isKind(of:vcMove){
                     self.navigationController?.popToViewController(vc, animated: true)
                     isfind = true
                     break
                 }else{
                     navArr.remove(at: navArr.count-1)
                 }
             }
             if !isfind{
               let vc = BaseTabBarViewController.instance(.baseTab) as! BaseTabBarViewController
                let NavVC = UINavigationController(rootViewController: vc)
                    NavVC.isNavigationBarHidden = true
                UIApplication.shared.windows[0].rootViewController = vc
                   UIApplication.shared.windows[0].makeKeyAndVisible()
            }

         
         

     }
    
}
//extension UITextField
//{
//    func setBottomBorder(borderColor: UIColor)
//    {
//        self.borderStyle = UITextField.BorderStyle.none
//        self.backgroundColor = UIColor.clear
//        let width = 0.5
//        let borderLine = UIView()
//        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(self.frame.size.width), height: width)
//        borderLine.backgroundColor = borderColor
//        self.addSubview(borderLine)
//    }
//
//    func setLeftPaddingPoints(_ amount:CGFloat){
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//    func setRightPaddingPoints(_ amount:CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }
//
//    func setLeftPaddingWithImage(_ amount:CGFloat, _ imgname:String) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        let imgView = UIImageView(frame:CGRect(x: 10, y: self.frame.size.height/2 - 12, width: 24, height: 24))
//        imgView.image = UIImage.init(named: imgname)
//        imgView.contentMode = .scaleAspectFit
//        paddingView.addSubview(imgView)
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//
//    func setleftPaddingWithImage(_ amount:CGFloat, _ imgname:String) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        let imgView = UIImageView(frame:CGRect(x: 10, y: self.frame.size.height/2 - 10, width: 20, height: 20))
//        imgView.image = UIImage.init(named: imgname)
//        imgView.contentMode = .scaleAspectFit
//        paddingView.addSubview(imgView)
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//
//
//    func setRightPaddingWithImage(_ amount:CGFloat, _ imgname:String) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        let imgView = UIImageView(frame:CGRect(x: 5, y: self.frame.size.height/2 - 13, width: 24, height: 24))
//        imgView.image = UIImage.init(named: imgname)
//        paddingView.addSubview(imgView)
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }
//    func setRightPaddingWithButtonImage(_ amount:CGFloat, _ imgname:String) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        let btnView = UIButton(frame:CGRect(x: 5, y: self.frame.size.height/2 - 12, width: 24, height: 24))
//        btnView.setImage(UIImage.init(named:imgname), for: .normal)
//        paddingView.addSubview(btnView)
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }
//}
extension UIView {
        func rotateAnimation() {
            
            UIView.transition(with: self, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                
            }, completion: nil)
            
        }
    }


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

////MARK:Transparent navigation bar
extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.backgroundColor = .clear
        self.barTintColor = .clear
    }
    
    func tarnsparentnaviagtionbar(){
            self.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
                self.shadowImage = UIImage()
                self.isTranslucent = true
                self.backgroundColor = .clear
    }
    func TransparentNavigationBar() {
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            self.backgroundColor = .clear
            self.barTintColor = .clear
        }
    }


//MARK: HEART SHAP EXTENTION


//MARK: EXTENTION INT


////String Extension
//extension String {
//    func capitalizingFirstLetter() -> String {
//        let first = String(prefix(1)).capitalized
//        return first
//    }
//
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
//
//        func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
//
//            return ceil(boundingBox.height)
//        }
//        func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//            let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
//
//            return ceil(boundingBox.width)
//        }
//
//}
//MARK:Add border on any kind of uicontrol
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x:0, y:0, width:self.frame.size.width, height:thickness)
            border.backgroundColor = color.cgColor;
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0,y: self.frame.size.height - thickness, width:self.frame.size.width, height:thickness)
            border.backgroundColor = color.cgColor;
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width:thickness, height:self.frame.size.height)
            border.backgroundColor = color.cgColor;
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.size.width - thickness, y:0, width:thickness, height:self.frame.size.height)
            border.backgroundColor = color.cgColor;
            break
        default:
            self.borderWidth = thickness
            self.borderColor = color.cgColor;
            self.cornerRadius = 5
            break
        }
        
        
        self.addSublayer(border)
    }
    
}

protocol Bluring {
    func addBlur(_ alpha: CGFloat)
   
}
protocol Rem_Bluring {
   func removeBlur()
    
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.8) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
    
}


extension Rem_Bluring where Self: UIView {
    func removeBlur() {
        
            if let view = self as? UIVisualEffectView {
                view.removeFromSuperview()
            }
      
    }
}
// Conformance
extension UIView: Bluring {}
extension UIView: Rem_Bluring {}

//MARK:get shadow  on View
extension UIView {
    
    // OUTPUT shadow on left and bottom
    func dropShadows(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.cornerRadius = 5.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2 shadow on complete view
    func dropShadows(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false

    }
  //  set textview border in botton
    func setTextViewBottomBorder(borderColor: UIColor)
    {
     //   self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        let width = 1.0
        let borderLine = UIView()
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(self.frame.size.width), height: width)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
    
}


extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = 1
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
//extension UIViewController {
//
//    func showToast(message : String) {
//
//        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height-100, width: SCREEN_WIDTH-20, height: 40))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = .center;
//        toastLabel.font = font_Regular
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        self.view.addSubview(toastLabel)
//        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
//            toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    } }

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 1.0
        pulse.damping = 2.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.5
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    

}
func checkStringNill(_ string: String?) -> String {
    
    if let hasString = string {
        return hasString
    }else {
        return ""
    }
    
}



class Methods: NSObject,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imageCache = NSCache<AnyObject, AnyObject>()
     var imageURL  = String()
    var imageviews = UIImageView()
    var label = UILabel()
    let prefs = UserDefaults.standard
    //var callback : ((Any,Any) -> Void)?
    var callback : ((Any,Any) -> Void)?
    var locationCallBack:(() ->Void)?
    var cancelCallBack:(() -> Void)?
    
    
    func roundedimageCorner(_ images:UIImageView,CornerSize:CGFloat)
    {
        images.layer.cornerRadius = CornerSize
        images.clipsToBounds = true
        
    }
    // MARK: Rounded Image

    func roundedimage(_ images:UIImageView)
    {
        images.layer.cornerRadius = images.frame.size.height/2
        images.clipsToBounds = true
        
    }
     // MARK: Rounded Button
    func roundedButton(_ Button:UIButton,_ cornerRadius:CGFloat)
    {
        Button.layer.cornerRadius = cornerRadius
        Button.clipsToBounds = true
        
    }
    func RoundCornerview(_ view:UIView,size:CGFloat)
    {
        view.layer.cornerRadius = size
        view.clipsToBounds = true
        
    }
    
    func circleButton(_ Button:UIButton)
    {
        Button.layer.cornerRadius = Button.frame.size.height/2
        Button.clipsToBounds = true
        
    }
    
    // MARK: roundedTextField
    func roundedTextField(_ TextField:UITextField,radius:CGFloat)
    {
        TextField.layer.cornerRadius = radius
        TextField.clipsToBounds = true
        TextField.layer.borderWidth = 0.50
        TextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setplaceHoldertextAndColor(_ text:String,textField:UITextField,placeHolderColor:UIColor,textFieldColor:UIColor)
    {
        let attrString = NSAttributedString (
            string: text,
            attributes: [kCTForegroundColorAttributeName as NSAttributedString.Key: placeHolderColor])
        textField.attributedPlaceholder = attrString
        textField.delegate = self
        textField.textColor = textFieldColor
        textField.resignFirstResponder()
        
    }
     // MARK: Rounded Label
    func roundedLabel(_ label:UILabel)
    {
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        
    }    
    
    func CircleView(_ view:UIView)
    {
        view.layer.cornerRadius = view.frame.width/2
        view.clipsToBounds = true
        
    }
    
    func roundView(_ view:UIView,radius:CGFloat)
    {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        
    }
    
    func setTextViewBottomBorder(borderColor: UIColor,txtView:UITextView)
    {
        //   self.borderStyle = UITextBorderStyle.none
        txtView.backgroundColor = UIColor.clear
        let width = 1.0
        let borderLine = UIView()
        borderLine.frame = CGRect(x: 0, y: Double(txtView.frame.height) - width, width: Double(txtView.frame.size.width), height: width)
        borderLine.backgroundColor = borderColor
        txtView.addSubview(borderLine)
    }
    func setplaceHoldertextUserName(_ text:String,textField:UITextField)
    {
        
        let attrString = NSAttributedString (
            string: text,
            attributes: [kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.lightGray])
        textField.attributedPlaceholder = attrString
        textField.delegate = self
        textField.textColor = UIColor.black
        textField.resignFirstResponder()
    }
    
     // MARK: Placeholder text
    func setplaceHoldertext(_ text:String,textField:UITextField)
    {
        let attrString = NSAttributedString (
            string: text,
            attributes: [kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.lightGray])
        textField.attributedPlaceholder = attrString
        textField.delegate = self
        textField.textColor = UIColor.black
        textField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    func ButtonBorder(_ view:UIButton,_ borderColor:UIColor,_ borderWidth:CGFloat)
    {
        view.layer.borderWidth = borderWidth
        view.clipsToBounds = true
        view.layer.borderColor = borderColor.cgColor
        
    }
    
    

   func isValidEmail(testStr:String) -> Bool {
          
          print("validate emilId: \(testStr)")
          let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
              "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
              "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
              "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
              "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
              "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
          "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
          
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          let result = emailTest.evaluate(with: testStr)
          return result
      }
   
      func isValidPassword(testStr:String?) -> Bool {
          guard testStr != nil else { return false }
       
          // at least one uppercase,
          // at least one digit
          // at least one lowercase//(?=.*[a-z]) enter this regrex also if want
          // 8 characters total
          let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$")
          return passwordTest.evaluate(with: testStr)
      }
      func validate_phone(value: String) -> Bool {
          
          var returnValue = true
          //        let mobileRegEx = "^[789][0-9]{9,11}$"
          let mobileRegEx = "^[0-9]{8}$"
          
          do {
              let regex = try NSRegularExpression(pattern: mobileRegEx)
              let nsString = value as NSString
              let results = regex.matches(in: value, range: NSRange(location: 0, length: nsString.length))
              
            if results.count == 0
              {
                  returnValue = false
              }
              
          } catch let error as NSError {
              print("invalid regex: \(error.localizedDescription)")
              returnValue = false
          }
          
          return  returnValue
          
      }
      
    
  
    
    
 // MARK: NSUserDefault
    
//    func saveModeluserDefault(modelData:UserModel){
//        let archiData = try! JSONEncoder().encode([modelData])
//        prefs.set(object: archiData, forKey: "UserData")
//    }
//
//    func GetUserDefaultData(){
//        let uData = prefs.object(forKey: "UserData") as? NSData
//
//        if let userD = uData {
//            let decoder = JSONDecoder()
//            let uModel = try! decoder.decode(UserModel.self, from: userD as Data)
//
//         //  print( uModel.name)
////            if let uDetail = uModel {
////
////                print(uDetail.name)
////            }
//
//        }
//    }
   
//MARK: Alert view
func alertShow(_objVC:UIViewController,msgString:String){
        
        let alertController = UIAlertController(title: "Alert", message: msgString as String?, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
          
        }
        
        alertController.addAction(noAction)
        
        _objVC.present(alertController, animated: true, completion: nil)
    }
    func alertShowWithPopBAck(_objVC:UIViewController,msgString:String){
        
        let alertController = UIAlertController(title: "Alert", message: msgString as String?, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
            _objVC.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(noAction)
        
        _objVC.present(alertController, animated: true, completion: nil)
    }
    
//    func show_noConnection_popUp(objVc:UIViewController) -> Void {
//        let mystory = UIStoryboard(name: "Main", bundle: nil)
//        let vc = mystory.instantiateViewController(withIdentifier:"No_Internet_Connection_VC" ) as! No_Internet_Connection_VC
//        vc.modalPresentationStyle = .overCurrentContext
//      
//        objVc.present(vc, animated: false, completion: nil)
//    }
    
    func alertShowWithAction(_objVC:UIViewController,msgString:String,action_ok_tapped:@escaping (String) -> Void){
        
        let alertController = UIAlertController(title: "Alert", message: msgString as String?, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
            action_ok_tapped("ok")
        }
//        let cancel_rmv = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//           
//        }
        
        alertController.addAction(noAction)
      //  alertController.addAction(cancel_rmv)
        
        _objVC.present(alertController, animated: true, completion: nil)
    }
    
    
    func alertShowWithAction_cancel(_objVC:UIViewController,msgString:String,action_ok_tapped:@escaping (String) -> Void){
        
        let alertController = UIAlertController(title: "Alert", message: msgString as String?, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
            action_ok_tapped("ok")
        }
                let cancel_rmv = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        
                }
        
        alertController.addAction(noAction)
        alertController.addAction(cancel_rmv)
        
        _objVC.present(alertController, animated: true, completion: nil)
    }
    
    
    func showToast(message : String,objvc:UIViewController) {
        
        let toastLabel = UILabel(frame: CGRect(x: 10, y: objvc.view.frame.size.height-120, width: SCREEN_WIDTH-20, height: 60))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        objvc.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
   

    //MARK: Check Empty Screen
    func checkEmptyString(str:String?)->String
    {
        if let strNew = str
        {
            return strNew
        }else{
            return " "
        }
        
    }

        //MARK:convert json string into dictionary
       
        func imagePick(objVC:UIViewController){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            let alertController  = UIAlertController(title:"Select option".localized(),message:"",preferredStyle:UIAlertController.Style.actionSheet)
            
            let cameraAction = UIAlertAction(title: "Choose from Camera".localized(), style: UIAlertAction.Style.default, handler:
            {Void in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.mediaTypes = ["public.image"]
                    
                    objVC.present(imagePicker, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title:"Camera", message:"Camera not working in simulator",preferredStyle: UIAlertController.Style.alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
                        
                    }
                    alert.addAction(cancelAction)
                    
                    objVC.present(alert, animated: true, completion: nil)
                    
                }
            })
            
            alertController.addAction(cameraAction)
            let GalleryAction = UIAlertAction(title: "Choose from Gallery".localized(), style: UIAlertAction.Style.default, handler:
            {Void in
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = true
                imagePicker.mediaTypes = ["public.image"]
                objVC.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(GalleryAction)
            let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
            }
            alertController.addAction(cancelAction)
            objVC.present(alertController, animated: true, completion: nil)
            
           // imagePicker.showsCameraControls = false
        }
    
    
    func VideoPick(objVC:UIViewController){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
        let alertController  = UIAlertController(title:"Select option".localized(),message:"",preferredStyle:UIAlertController.Style.actionSheet)
            
        let cameraAction = UIAlertAction(title: "Choose from the Camera".localized(), style: UIAlertAction.Style.default, handler:
            {Void in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.mediaTypes = ["public.movie"]
                    
                    objVC.present(imagePicker, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title:"Camera", message:"Camera not working in simulator",preferredStyle: UIAlertController.Style.alert)
                    
                    let cancelAction = UIAlertAction(title: "OK".localized(), style: .cancel) { (action) -> Void in
                        
                    }
                    alert.addAction(cancelAction)
                    
                    objVC.present(alert, animated: true, completion: nil)
                    
                }
            })
            
            alertController.addAction(cameraAction)
        let GalleryAction = UIAlertAction(title: "Choose from the Gallery".localized(), style: UIAlertAction.Style.default, handler:
            {Void in
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = true
                imagePicker.mediaTypes = ["public.movie"]
                objVC.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(GalleryAction)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
            }
            alertController.addAction(cancelAction)
            objVC.present(alertController, animated: true, completion: nil)
            
           // imagePicker.showsCameraControls = false
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print(info)

            if let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
    //
                    let oriimage = imageOrientation(pickedImage)
                    let urlImage = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
                   callback!(oriimage, urlImage)
                 }else{
                    let urlVideo = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
              
                callback!(urlVideo, urlVideo)
             

               }
    //
                 
                 picker.dismiss(animated: true, completion: nil)
        }
        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            print(info)
//            if let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//    //
//                    let oriimage = imageOrientation(pickedImage)
//                    callback!(oriimage)
//                 }else{
//                    let urlVideo = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
//
//                          callback!(urlVideo as! UIImage)
//
//
//
//               }
//    //
//
//                 picker.dismiss(animated: true, completion: nil)
//        }
    //     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //
    //     if let pickedImage  = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
    //
    //             let oriimage = imageOrientation(pickedImage)
    //              callback!(oriimage)
    //          }else{
    //             let urlVideo = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as! NSURL
    //
    //                   callback!(urlVideo as! UIImage)
    //
    //
    //
    //          }
    //
    //
    //          picker.dismiss(animated: true, completion: nil)
    //    }
    //
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func Open_All_Attach_Chat(objVC:UIViewController){
            let imagePicker      = UIImagePickerController()
            imagePicker.delegate = self
          
            
            let alertController  = UIAlertController(title:"Select Your Option",message:"",preferredStyle:UIAlertController.Style.actionSheet)
            
            let cameraAction = UIAlertAction(title: "Choose from Camera", style: UIAlertAction.Style.default, handler:
            {Void in
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.mediaTypes = ["public.image"]
                    imagePicker.allowsEditing = true
                    objVC.present(imagePicker, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title:"Camera", message:"Camera not working in simulator",preferredStyle: UIAlertController.Style.alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
                        
                    }
                    alert.addAction(cancelAction)
                    
                    objVC.present(alert, animated: true, completion: nil)
                    
                }
            })
            
            alertController.addAction(cameraAction)
            let GalleryAction = UIAlertAction(title: "Choose from Gallery", style: UIAlertAction.Style.default, handler:
            {Void in
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = true
                imagePicker.mediaTypes = ["public.image"]
                objVC.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(GalleryAction)
            
            let MapAction = UIAlertAction(title: "Share Location", style: UIAlertAction.Style.default, handler:
            { Void in
               
                self.locationCallBack!()
                    
               
            })
            alertController.addAction(MapAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                self.cancelCallBack!()
            }
            alertController.addAction(cancelAction)
            objVC.present(alertController, animated: true, completion: nil)
            
            // imagePicker.showsCameraControls = false
        }
     
    //    func convertHtmlPlainText(_ HTMLString: String) -> String {
    //
    //        let HTMLData: Data? = HTMLString.data(using: String.Encoding.utf8, allowLossyConversion: false)
    //        let attrString = try? NSAttributedString(data: HTMLData!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
    //        let plainString: String? = attrString?.string
    //        return plainString!
    //
    //    }
    //
    //    //MARK:checkNetwork Status
    //
    //    private let manager = NetworkReachabilityManager(host: "www.apple.com")
    //    func isNetworkReachable() -> Bool {
    //        return manager?.isReachable ?? false
    //    }
    //
        func imageOrientation(_ srcImage: UIImage)->UIImage {
            if srcImage.imageOrientation == UIImage.Orientation.up {
                return srcImage
            }
            var transform: CGAffineTransform = CGAffineTransform.identity
            switch srcImage.imageOrientation {
            case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
                transform = transform.translatedBy(x: srcImage.size.width, y: srcImage.size.height)
                transform = transform.rotated(by: .pi)// replace M_PI by Double.pi when using swift 4.0
                break
            case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
                transform = transform.translatedBy(x: srcImage.size.width, y: 0)
                transform = transform.rotated(by: .pi/2)// replace M_PI_2 by Double.pi/2 when using swift 4.0
                break
            case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                transform = transform.translatedBy(x: 0, y: srcImage.size.height)
                transform = transform.rotated(by: -.pi/2)// replace M_PI_2 by Double.pi/2 when using swift 4.0
                break
            case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
                break
            }
            switch srcImage.imageOrientation {
            case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
                transform.translatedBy(x: srcImage.size.width, y: 0)
                transform.scaledBy(x: -1, y: 1)
                break
            case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
                transform.translatedBy(x: srcImage.size.height, y: 0)
                transform.scaledBy(x: -1, y: 1)
            case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
                break
            }
            let ctx:CGContext = CGContext(data: nil, width: Int(srcImage.size.width), height: Int(srcImage.size.height), bitsPerComponent: (srcImage.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (srcImage.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            ctx.concatenate(transform)
            switch srcImage.imageOrientation {
            case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                ctx.draw(srcImage.cgImage!, in: CGRect(x: 0, y: 0, width: srcImage.size.height, height: srcImage.size.width))
                break
            default:
                ctx.draw(srcImage.cgImage!, in: CGRect(x: 0, y: 0, width: srcImage.size.width, height: srcImage.size.height))
                break
            }
            let cgimg:CGImage = ctx.makeImage()!
            let img:UIImage = UIImage(cgImage: cgimg)
            return img
        }
        
        
    
    func hexStringToUIColor(hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
   
    func convert24to12FormatString(format:String, dateAsString:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        var Date12 = dateFormatter.string(from: date!)
        
        
        return Date12
    }
    
    func convertInMinutes(dateString: String = "7:30 AM") -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateString)!
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hours = comp.hour
        let minutes = comp.minute
        let totalMinutes = (hours! * 60 ) + minutes!
        return totalMinutes
    }
    
    func convertMinutestoTime(minutes: String) -> String {
        if minutes.isEmpty || minutes == "" {return ""}
        let totalMinutes = Int(minutes)
        let hours = totalMinutes!/60
        let minutesInDisplay = totalMinutes! % 60
        let temp = "\(hours):\(minutesInDisplay)"
        print(temp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: temp)
        dateFormatter.dateFormat = "h:mm a"
        print(date)
        var time = ""
        if date != nil {
            time = dateFormatter.string(from: date!)
        }
        print(time)
        return time
    }
    
    func changeRootViewController(sbName:String, vc:String) {
        let storyboard = UIStoryboard(name:sbName, bundle: nil).instantiateViewController(withIdentifier: vc)
        var options = UIWindow.TransitionOptions()
        options.direction = .toBottom
        options.duration = 0.0
        options.style = .easeInOut
        UIApplication.shared.windows.first?.setRootViewController(storyboard, options: options)
    }
    
    func getAuthToken() -> String {
      //  return (UserDefaults.standard.object(forKey: "AuthToken") ?? "1234656") as! String
        return UserDefaults.standard.value(forKey: "AuthToken") as? String ?? ""
    }
    func setAuthToken(value:String){
        
        // let valuess = value.MD5()! + "." + self.getUserID().MD5()!
        UserDefaults.standard.set(value, forKey: "AuthToken")
        UserDefaults.standard.synchronize()
    }
    
    func convertMinutesto24TimeFormat(minutes: String) -> String {
        if minutes.isEmpty || minutes == "" { return "" }
        let totalMinutes = Int(minutes)
        let hours = totalMinutes!/60
        let minutesInDisplay = totalMinutes! % 60
        let temp = "\(hours):\(minutesInDisplay)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: temp)
        // dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: date!)
        
        return time
    }
    func amAppend(str:String) -> String{
        var temp = ""
        var strArr = str.split{$0 == ":"}.map(String.init)
        let hour = Int(strArr[0])!
        let min = Int(strArr[1])!
        if(hour > 12) && (min >= 0){
            temp = "PM"
        } else {
            temp = "AM"
        }
        return temp
    }
    //MARK:- Encrypt text message
   
    
}
extension Date {
    
   
    
    func getElapsedForTimeInterval(delivaryDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
       // dateFormatter.timeZone = TimeZone(identifier: "UTC")
     
        let month = dateFormatter.string(from: delivaryDate)
        dateFormatter.dateFormat = "dd, yyyy , h:mm a"
        let date = dateFormatter.string(from: delivaryDate)
        let delivartString =  month.prefix(3) + " " + date
        
        return String(delivartString)
        
    }
    
        func getDate(date:Double)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return Date(timeIntervalSince1970: TimeInterval(date))
    }
    
    
}
extension Double {
    func getDateStringFromUTC() -> Date {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMMM yyyy, hh:mm a"
        let dateStr = dateFormatter.string(from: date)
        return dateFormatter.date(from: dateStr)!
    }
}

extension UINavigationController {
func popToViewController(ofClass: AnyClass, animated: Bool = true) {
if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
popToViewController(vc, animated: animated)
}
}
}



public extension UIWindow {
    
    /// Transition Options
    struct TransitionOptions {
        
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let key: String!
                switch self {
                case .linear:        key = CAMediaTimingFunctionName.linear.rawValue
                case .easeIn:        key = CAMediaTimingFunctionName.easeIn.rawValue
                case .easeOut:        key = CAMediaTimingFunctionName.easeOut.rawValue
                case .easeInOut:    key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
                }
                return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key!))
            }
        }
        
        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            ///
            /// - Returns: transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20
        
        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight
        
        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background? = nil
        
        /// Initialize a new options object with given direction and curve
        ///
        ///   - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        public init() { }
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }
    
    
    /// Change the root view controller of the window
    ///
    ///    - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        
        var transitionWnd: UIWindow? = nil
        if let background = options.background {
            transitionWnd = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWnd?.rootViewController = UIViewController.newController(withView: view, frame: transitionWnd!.bounds)
            case .solidColor(let color):
                transitionWnd?.backgroundColor = color
            }
            transitionWnd?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        //self.makeKeyAndVisible()
        
        if let wnd = transitionWnd {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.duration), execute: {
                wnd.removeFromSuperview()
            })
        }
    }
}
internal extension UIViewController {
    
    /// Create a new empty controller instance with given view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - frame: frame
    /// - Returns: instance
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}

extension UINavigationController {
func PopToViewController(ofClass: AnyClass, animated: Bool = true) {
if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
popToViewController(vc, animated: animated)
}
}
}
