//
//  Util.swift
//  Recipe
//
//  Created by MacMini on 19/01/18.
//  Copyright © 2018 Codiant. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    //MARK: open url
    class func openUrl(str: String) {
        if let url = URL(string: str) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { (completed) in
                        
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    class func makeACall(phoneNumber: String, completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
        var strUrl = phoneNumber
        if phoneNumber.range(of: "tel://") == nil {
            strUrl = "tel://" + phoneNumber
        }
        if let url = URL(string: strUrl) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: completion)
                } else {
                    UIApplication.shared.openURL(url)
                    if completion != nil {
                        completion!(true)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Alert Methods
    class func showNetWorkAlert() {
        showAlertWithCallback("No Network Connection", message: "Please check your connection and try again.",okStr: "OK",cancelStr: "Cancel", isWithCancel: false)
        
    }
    
    //MARK:- alert with handler
    class func showAlertWithCallback(_ title: String?, message: String?, okStr: String, cancelStr: String, isWithCancel: Bool, handler: (() -> Void)? = nil) {
        if UIApplication.topViewController() != nil {
            if (UIApplication.topViewController()!.isKind(of: UIAlertController.self)) {
                return
            }
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if isWithCancel {
            alertController.addAction(UIAlertAction(title: cancelStr, style: .destructive, handler: nil))
        }
        
        alertController.addAction(UIAlertAction(title: okStr, style: .default, handler: { (action) in
            handler?()
        }))
        
       // alertController.view.tintColor = UIColor.red
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        //UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertWithCancelCallback(_ title: String?, message: String?, isWithCancel: Bool, handler: ((String) -> Void)? = nil) {
        if UIApplication.topViewController() != nil {
            if (UIApplication.topViewController()!.isKind(of: UIAlertController.self)) {
                return
            }
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            handler?("Ok")
        }))
        
        if isWithCancel {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
                handler?("Cancel")
            }))
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - *******Validations Methods*******
    class func isValidEmail(_ emailStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    //MARK: - ********Image Picker********
    class func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = UIApplication.currentViewController() as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = true
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            Util.openCamera(imagePicker)
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            Util.openGallary(imagePicker)
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        UIApplication.currentViewController()?.present(alert, animated: true, completion: nil)
    }
    
    class func openCamera(_ picker: UIImagePickerController){
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            UIApplication.currentViewController()?.present(picker, animated: true, completion: nil)
            
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.currentViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func openGallary(_ picker: UIImagePickerController){
        
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        UIApplication.currentViewController()?.present(picker, animated: true, completion: nil)
    }
    
    class func getValidString(_ string: String?) -> (String) {
        if string == nil || string == "nil" || string!.isKind(of: NSNull.self) || string == "null" || string == "<null>" || string == "(null)" {
            
            return ""
        }
        return string!.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    class func encodeURLLink(_ string: String) -> (String){
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}


struct ScreenSize {
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
    static func inOrientation() -> CGSize {
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            return CGSize(width: max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height), height: min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
        default:
            return CGSize(width: min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height), height: max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
        }
    }
}



