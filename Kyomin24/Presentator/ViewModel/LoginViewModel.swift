//
//  LoginViewModel.swift
//  Mzadi
//
//  Created by A Care Indore on 21/06/21.
//

import Foundation
class LoginViewModel : NSObject {
    
    func checkValidation(mobileNumber : String) -> NSMutableArray {
            let validArray = NSMutableArray()

            if mobileNumber.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
                validArray.add(Constants.ApiStrings.validationMobileNumber)
            }else{
                if !ValidatorClasses.isValidMobileNumber(strMobileNumber: mobileNumber){
                    validArray.add(Constants.ApiStrings.validMobileNumberTxt)
                }
            }

            return validArray
        }
    
}
