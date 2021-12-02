//
//  LoginUserModel.swift
//  Kidsid
//
//  Created by Shubham Sharma on 05/06/19.
//  Copyright © 2019 Shubham Sharma. All rights reserved.
//

import Foundation


class LoginUserModel{
	var userId:String = ""
	var name:String = ""
	var email:String = ""
	var gender:String = ""
	var status:String = ""
	var phone_number:String = ""
	var date_of_birth:String = ""
	var slug:String = ""
	fileprivate var _access_token:String = ""
	fileprivate var _social_token:String = ""
	
	
	
	
	var isProceed:Bool{
		get {
			return status == "1"
		}
	}
	var token:String {
		get {
			return _access_token
		}
	}
	
	
 
    
    var fCMToken:String {
        get {
            guard let token = UserDefaults.standard.value(forKey: UserDefaultKey.USER_FCM_TOKEN) as? String else {
                return ""
            }
            return  token
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.USER_FCM_TOKEN) //Bool
        }
    }
    
    static let shared = LoginUserModel()
    
    init(){
        refresh()
    }
	
	func refresh() {
		if let userID = UserDefaults.standard.value(forKey: UserDefaultKey.USER_INFO) as? [String:Any] {
            if let tmpId = userID["userId"] as? NSNumber {
                self.userId = tmpId.stringValue
            } else if let tmpId = userID["userId"] as? NSString {
                self.userId = String(tmpId.integerValue)
            }
			
			self.name = userID["firstName"] as? String ?? ""
			self.email  = userID["userName"] as? String ?? ""
			
            
            
            self.gender  = userID["gender"] as? String ?? ""
			self.status  = userID["status"] as? String ?? ""
			self.phone_number  = userID["phone_number"] as? String ?? ""
			
			
			self.date_of_birth  = userID["date_of_birth"] as? String ?? ""
			self._access_token = userID["access_token"] as? String ?? ""
			self._social_token = userID["social_token"] as? String ?? ""
			
			
			
		}else{
			self.userId = ""
			self._access_token = ""
		}
	}
	func login(userData: [String: Any])  {
		UserDefaults.standard.set(userData, forKey: UserDefaultKey.USER_INFO)
		refresh()
	}
	
	func update(userData: [String: Any])  {
        if let oldData = UserDefaults.standard.value(forKey: UserDefaultKey.USER_INFO) as? [String:Any] {
//			oldData.merge(dictionaries: userData)
			print(oldData)
			UserDefaults.standard.set(oldData, forKey: UserDefaultKey.USER_INFO)
			refresh()
		}
	}
    
    func onBoardingFinished()  {
        if var userID = UserDefaults.standard.value(forKey: UserDefaultKey.USER_INFO) as? [String:Any] {
            userID["proceed"] = "1"
            login(userData: userID)
        }
    }
	var isTmpLogin: Bool {
		get {
			return userId != ""
		}
	}
	var isLogin:Bool {
		get {
			return userId != ""
			
		}
	}
	
	
	var isSynced:Bool {
		get {
			guard let token = UserDefaults.standard.value(forKey: UserDefaultKey.FIRST_SYNC) as? Bool else {
				return false
			}
			return token
			
		}
		set {
			UserDefaults.standard.set(newValue, forKey: UserDefaultKey.FIRST_SYNC) //Bool
		}
	}
	
	var allPlaces:[[String: Any]] {
		get {
			guard let token = UserDefaults.standard.value(forKey: UserDefaultKey.ALL_PLACES) as? [[String: Any]] else {
				return []
			}
			return token
			
		}
		set {
			UserDefaults.standard.set(newValue, forKey: UserDefaultKey.ALL_PLACES) //Bool
		}
	}
	

	
    func logout()  {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.USER_INFO)
        UserDefaults.standard.synchronize()
        refresh()
    }
}
 
class UserDefaultKey {
    static let USER_INFO = "com.reward.user.data"
    static let USER_FCM_TOKEN = "com.reward.user.FCMToken"
 
	static let FIRST_SYNC = "com.reward.user.FIRST_SYNC"
	static let ALL_PLACES = "com.reward.user.ALL_PLACES"
}
 
