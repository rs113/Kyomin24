//
//  UserModel12.swift
//  Mzadi
//
//  Created by Emizentech on 04/10/21.
//

import Foundation
import SwiftyJSON

class UserModel2:NSObject,Codable{
     var user_id :String = ""
     var lang_id :String = ""
     var name :String = ""
     var userIDUnique :String = ""
     var slug :String = ""
     var email :String = ""
     var profile :String = ""
     var gender :String = ""
     var phonenumber :String = ""
     var country_code :String = ""
     var usertoken :String = ""
     var device_id :String = ""
     var social_id :String = ""
     var status :String = ""
     var firstName :String = ""
     var lastName :String = ""
     var userProfiles :UserProfileModel2?



    init(userDetail:[String:JSON]) {
        let uProfile = userDetail["user_profile"]?.dictionary
        self.userProfiles = UserProfileModel2(userDetail: uProfile ?? [String:JSON]())
        self.user_id = userDetail["id"]?.string ?? ""
        self.name = userDetail["name"]?.string ?? ""
        self.profile = userDetail["profile_pic"]?.string ?? ""
        self.phonenumber = userDetail["phone_no"]?.string ?? ""
        self.usertoken = userDetail["token"]?.string ?? ""
        self.status = userDetail["status"]?.string ?? ""
        



    }


}

class UserProfileModel2:NSObject,Codable{
    var user_id :String?
    var latitude :String?
    var address :String?
    var age :String?
    var longitude :String?
    var location :String?
    var country :String?
    var countryDetail:CountryDetailModel?
    var locationDetail:LocationDetailModel?

    init(userDetail:[String:JSON]) {
        self.user_id = userDetail["user_id"]?.string
        self.latitude = userDetail["latitude"]?.string
        self.longitude = userDetail["longitude"]?.string
        self.address = userDetail["address"]?.string
        self.age = userDetail["age"]?.string
        self.location = userDetail["location"]?.string
        self.country = userDetail["country"]?.string
        let conDetail = userDetail["countrydetail"]?.dictionary
        let locDetail = userDetail["locationdetail"]?.dictionary
        self.countryDetail = CountryDetailModel(conAllDetail:conDetail ?? [String:JSON]())
        self.locationDetail = LocationDetailModel(locAllDetail:locDetail ?? [String:JSON]())

    }
}

class CountryDetailModel:NSObject,Codable{
    var created_at :String?
    var lang_id :String?
    var id :String?
    var title :String?
    var status :String?

   

    init(conAllDetail:[String:JSON]) {
        self.created_at = conAllDetail["created_at"]?.string
        self.lang_id = conAllDetail["lang_id"]?.string
        self.id = conAllDetail["id"]?.string
        self.title = conAllDetail["title"]?.string
        self.status = conAllDetail["status"]?.string


    }
}
class LocationDetailModel:NSObject,Codable{
    var country_id :String?
    var created_at :String?
    var lang_id :String?
    var id :String?
    var title :String?
    var status :String?
    
   

    init(locAllDetail:[String:JSON]) {
        self.country_id = locAllDetail["country_id"]?.string
        self.created_at = locAllDetail["created_at"]?.string
        self.lang_id = locAllDetail["lang_id"]?.string
        self.id = locAllDetail["id"]?.string
        self.title = locAllDetail["title"]?.string
        self.status = locAllDetail["status"]?.string
        
    }
}

class UserModel: NSObject {
   // var name = ""

    
//    var user_id :String = ""
//    var lang_id :String = ""
//    var name :String = ""
//    var userIDUnique :String = ""
//    var slug :String = ""
//    var email :String = ""
//    var profile :String = ""
//    var gender :String = ""
//    var phonenumber :String = ""
//    var country_code :String = ""
//    var device_type :String = ""
//    var device_id :String = ""
//    var social_id :String = ""
//    var status :String = ""
//    var userProfiles :UserProfileModel?
//    //Added new field
//
//
//
//    class func parseUserInfo(userDetail : [String:JSON]) -> (UserModel)
//    {
//        let userM:UserModel = UserModel()
//
//
//        userM.user_id = userDetail["id"]?.string ?? ""
//        userM.lang_id = userDetail["lang_id"]?.string ?? ""
//        userM.name = userDetail["name"]?.string ?? ""
//        userM.userIDUnique = userDetail["userID"]?.string ?? ""
//        userM.slug = userDetail["slug"]?.string ?? ""
//        userM.email = userDetail["email"]?.string ?? ""
//        userM.profile = userDetail["profile"]?.string ?? ""
//        userM.gender = userDetail["gender"]?.string ?? ""
//        userM.phonenumber = userDetail["phonenumber"]?.string ?? ""
//        userM.country_code = userDetail["country_code"]?.string ?? ""
//        userM.device_type = userDetail["device_type"]?.string ?? ""
//        userM.device_id = userDetail["device_id"]?.string ?? ""
//        userM.social_id = userDetail["social_id"]?.string ?? ""
//        userM.status = userDetail["status"]?.string ?? ""
//        let uProfile = userDetail["user_profile"]?.dictionary
//        let um = UserProfileModel.parseUserProfileInfo(userDetail: uProfile ?? [String:JSON]())
//        userM.userProfiles = um
//
//        return userM
//    }
//
//    func encode(with aCoder: NSCoder) {
//
//        aCoder.encode(self.user_id,forKey:"id")
//        aCoder.encode(self.lang_id,forKey:"lang_id")
//        aCoder.encode(self.name,forKey:"name")
//        aCoder.encode(self.userIDUnique,forKey:"userID")
//        aCoder.encode(self.slug,forKey:"slug")
//        aCoder.encode(self.email,forKey:"email")
//        aCoder.encode(self.profile,forKey:"profile")
//        aCoder.encode(self.gender,forKey:"gender")
//        aCoder.encode(self.phonenumber,forKey:"phonenumber")
//        aCoder.encode(self.country_code,forKey:"country_code")
//        aCoder.encode(self.device_type,forKey:"device_type")
//        aCoder.encode(self.device_id,forKey:"device_id")
//        aCoder.encode(self.social_id,forKey:"social_id")
//        aCoder.encode(self.status,forKey:"status")
//        aCoder.encode(self.userProfiles,forKey:"Profile")
//
//
//
//    }
//
//
//
//    required convenience init(coder decoder: NSCoder)
//    {
//        self.init()
//
//        self.name = decoder.decodeObject(forKey: "name") as! String
//        self.user_id = decoder.decodeObject(forKey: "id") as! String
//        self.lang_id = decoder.decodeObject(forKey: "lang_id") as! String
//        self.userIDUnique = decoder.decodeObject(forKey: "userID") as! String
//        self.slug = decoder.decodeObject(forKey: "slug") as! String
//        self.email = decoder.decodeObject(forKey: "email") as! String
//        self.profile = decoder.decodeObject(forKey: "profile") as! String
//        self.gender = decoder.decodeObject(forKey: "gender") as! String
//        self.phonenumber = decoder.decodeObject(forKey: "phonenumber") as! String
//        self.country_code = decoder.decodeObject(forKey: "country_code") as! String
//        self.device_type = decoder.decodeObject(forKey: "device_type") as! String
//        self.device_id = decoder.decodeObject(forKey: "device_id") as! String
//        self.social_id = decoder.decodeObject(forKey: "social_id") as! String
//        self.status = decoder.decodeObject(forKey: "status") as! String
//        self.userProfiles = decoder.decodeObject(forKey: "Profile") as! UserProfileModel
//
//
//
//    }
    
    
    
    class func getSchoolDataModel() -> UserModel2
    {
        let userDefault  = UserDefaults.standard
        let  encodedObject = userDefault.object(forKey: "UserModel2") as? NSData
        if(encodedObject != nil){
            let decoder = JSONDecoder()
            let loadedPerson = (try? decoder.decode(UserModel2.self, from: encodedObject! as Data))!
           // let schoolModel:UserModel2 = NSKeyedUnarchiver.unarchiveObject(with: encodedObject! as Data)! as! UserModel2
            print(loadedPerson.name)
            print(loadedPerson.userProfiles?.latitude)
            return loadedPerson
        }
        
        return UserModel2(userDetail: [String:JSON]())
    }
    
    
    
    class func save(schoolModel:UserModel2?)
    {
        if let data = schoolModel {
            //let encodedObject  =  NSKeyedArchiver.archivedData(withRootObject: data)
            let encodedObject = try! JSONEncoder().encode(data)
            let userDefault  = UserDefaults.standard
            userDefault.set(encodedObject, forKey: "UserModel2")
            userDefault.synchronize()
        }
        
    }
    
    class func removeAllAccounts()
    {
        let userDefault  = UserDefaults.standard
        userDefault.removeObject(forKey: "UserModel2")
        
        
    }
}
//class UserProfileModel:NSObject,Codable{
//    var user_id :String?
//    var latitude :String?
//    var address :String?
//    var age :String?
//    var longitude :String?
//    var location :String?
//    var country :String?
//
////    init(userDetail:[String:JSON]) {
////        self.user_id = userDetail["user_id"]?.string
////        self.latitude = userDetail["latitude"]?.string
////        self.longitude = userDetail["longitude"]?.string
////        self.address = userDetail["address"]?.string
////        self.age = userDetail["age"]?.string
////        self.location = userDetail["location"]?.string
////        self.country = userDetail["country"]?.string
////
////    }
//    class func parseUserProfileInfo(userDetail : [String:JSON]) -> (UserProfileModel)
//    {
//        let userM:UserProfileModel = UserProfileModel()
//
//
//        userM.user_id = userDetail["id"]?.string ?? ""
//        userM.latitude = userDetail["latitude"]?.string ?? ""
//        userM.longitude = userDetail["longitude"]?.string ?? ""
//        userM.address = userDetail["address"]?.string ?? ""
//        userM.age = userDetail["age"]?.string ?? ""
//        userM.location = userDetail["location"]?.string ?? ""
//        userM.country = userDetail["country"]?.string ?? ""
//
//
//        return userM
//    }
//
//       func encode(with aCoder: NSCoder) {
//           aCoder.encode(self.user_id,forKey:"user_id")
//           aCoder.encode(self.latitude,forKey:"latitude")
//           aCoder.encode(self.longitude,forKey:"longitude")
//           aCoder.encode(self.address,forKey:"address")
//           aCoder.encode(self.age,forKey:"age")
//           aCoder.encode(self.location,forKey:"location")
//           aCoder.encode(self.country,forKey:"country")
//
//
//
//
//       }
////
////
////
//       required convenience init(coder decoder: NSCoder)
//       {
//           self.init()
//
//        self.latitude = decoder.decodeObject(forKey: "latitude") as? String
//        self.user_id = decoder.decodeObject(forKey: "user_id") as? String
//        self.longitude = decoder.decodeObject(forKey: "longitude") as? String
//        self.address = decoder.decodeObject(forKey: "address") as? String
//        self.age = decoder.decodeObject(forKey: "age") as? String
//        self.location = decoder.decodeObject(forKey: "location") as? String
//        self.country = decoder.decodeObject(forKey: "country") as? String
//
//
//
//       }
//}

