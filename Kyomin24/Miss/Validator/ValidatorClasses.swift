//
//  ValidatorClasses.swift
//  Mzadi
//
//  Created by A Care Indore on 21/06/21.
//

import Foundation

class ValidatorClasses : NSObject {
    static let descriptionAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,/- "
    static let nameAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
    static let alphaNumericAccept = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    static let emailAcceptCharacter = "@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-+!#$%&'*/=?^_"
    static let passwordAcceptCharacter = "@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-"
    static let phoneNoAcceptableCharacter = "0123456789"
    static let userNameAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789."
    static let allAcceptableCharacter = "@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_01234567890.,/- "
    static let URLAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_."
    static let AmountAcceptableCharacter = "1234567890."

  /*class func isValidEmail(strEmail:String) -> Bool {
         do {
             //let regex = try NSRegularExpression(pattern: "^([a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~:<>;\"()_-]+)@{1}(([a-zA-Z0-9_-]{1,62})|([a-zA-Z0-9-]+\\.[a-zA-Z0-9-]{1,62}))$", options: .caseInsensitive)
            let regex = try NSRegularExpression(pattern: "^([a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~:<>;\"()_-]+)@{1}(([a-zA-Z0-9_-]{1,62})|([a-zA-Z0-9-]+\\.[a-zA-Z0-9-]{1,62}))$", options: .caseInsensitive)
             return regex.firstMatch(in: strEmail, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, strEmail.count)) != nil
         } catch {
             return false
         }
  }*/
    
    class func isValidEmail(strEmail: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // "@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-+!#$%&'*/=?^_"//
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: strEmail)
    }
    
    // "[_A-Za-z0-9.]{3,12}"
    
    class func isValidPassword(strPassword:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "((?!\\s)\\A)(\\s|(?<!\\s)\\S){6,20}\\Z", options: .caseInsensitive)
            return regex.firstMatch(in: strPassword, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, strPassword.count)) != nil
        } catch {
            return false
        }
    }
    
    class func validateUsername(str: String) -> Bool { // "^[[A-Z]|[a-z]][[A-Z]|[a-z]|\\d|[_]]{7,29}$"
        do
        { // "[_A-Za-z0-9.]{3,12}"
            let regex = try NSRegularExpression(pattern: "[_A-Za-z0-9.]{3,30}", options: .caseInsensitive)
            if regex.matches(in: str, options: [], range: NSMakeRange(0, str.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    
    class func isValidName(strName:String) -> Bool {
        if strName.count < 2{
            return false
        }
        return true
    }

    class func isValidOTPNumber(strOTPNumber:String) -> Bool {
          if strOTPNumber.count != 4 {
              return false
          }
          return true
      }
    
    class func isValidMobileNumber(strMobileNumber:String) -> Bool {
        if strMobileNumber.count < 10 || strMobileNumber.count > 11 {
            return false
        }
        return true
    }

}
