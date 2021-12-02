//
//  File.swift
//  FindIT
//
//  Created by Shobhakar Tiwari on 26/04/20.
//  Copyright © 2020 Sai. All rights reserved.
//

import UIKit

struct Defaults {
    
    private static let userDefault = UserDefaults.standard
    
    /**
     - Description - Saving user details
     - Inputs - value `String` & address `String`
     */
    static func saveStringValue(_ value: String, key:String) {
        userDefault.set(value,forKey: key)
        userDefault.synchronize()
    }
    
    static func saveIntValue(_ value: Int, key:String) {
           userDefault.set(value,forKey: key)
           userDefault.synchronize()
    }
    
    static func saveDoubleValue(_ value: Double, key:String) {
           userDefault.set(value,forKey: key)
           userDefault.synchronize()
       }
    
    static func saveBool(_ value:Bool, key:String) {
        userDefault.set(value,forKey: key)
        userDefault.synchronize()
    }
    
    static func saveImage(image: UIImage?, forKey key: String) {
           var imageData: NSData?
           if let image = image {
               imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
           }
        userDefault.set(imageData, forKey: key)
    
       }
    
    /**
     - Description - Fetching Values via Model `UserDetails` you can use it based on your uses.
     - Output - `UserDetails` model
     */
    static func getStringValue(forKey : String) -> String {
        return userDefault.value(forKey: forKey) as? String ?? ""
    }
    
    static func getIntValue(forKey : String) -> Int {
           return userDefault.value(forKey: forKey) as? Int ?? 0
    }
   
    
    static func getDoubleValue(forKey : String) -> Double {
        return userDefault.value(forKey: forKey) as? Double ?? 0.00
       }
    
    
    static func getBoolValue(forKey:String) -> Bool {
         return userDefault.value(forKey: forKey) as? Bool ?? false
    }
    
   static func getImage(forkey: String) -> UIImage? {
        var image: UIImage?
    if let imageData = userDefault.value(forKey: forkey) {
        image = NSKeyedUnarchiver.unarchiveObject(with: imageData as! Data) as? UIImage
        }
        return image
    }
   
    
    
    
    
    
    
    /**
        - Description - Clearing user details for the user key `com.save.usersession`
     */
    static func clearUserData(){
        let dictionary = userDefault.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }
}
