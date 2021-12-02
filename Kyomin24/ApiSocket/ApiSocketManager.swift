//
//  ApiSocketManager.swift
//  Mzadi
//
//  Created by Emizentech on 30/09/21.
//

import Alamofire
import UIKit
import SwiftyJSON
import Localize_Swift



class ApiSocketManager:NSObject{
    
    static let apiShared = ApiSocketManager()
    
    func sendRequestSocketServerPostWithHeaderModel<T:Codable>(VCType:UIViewController,ReqMethod:HTTPMethod, dictParameter: [String:Any],isShowLoader:Bool = true ,responseObject:T.Type, success:@escaping (_ json:JSON,_ parsedModel:T,_ strMsg:String) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.")
            return
        }
        if isShowLoader{
            VCType.showLoader()
        }
        
        
        
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en",
            "Content-Type": "application/json"
            
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(socketurl
                       , method: ReqMethod, parameters: dictParameter, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
                        debugPrint(response)
                        VCType.hideLoader()
                        DispatchQueue.main.async {
                            let stCode = response.response?.statusCode
                            
                            let json = JSON(response.data ?? Data())
                            let ermsg = json["message"].string
                            
                            if stCode == 200{
                                if((response.value) != nil) {
                                    switch response.result {
                                    case .success( _):
                                        let json = JSON(response.data!)
                                        print(json)
                                        do{
                                            if let jsonNew = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] {
                                                print(json)
                                            }
                                            let jsonN = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                                            //  callBack.onSuccess(json)
                                            success(json, jsonN, ermsg ?? "")
                                        } catch let error {
                                            // callBack.onFailure(error.localizedDescription)
                                            errorClosure(error.localizedDescription)
                                        }
                                        
                                        
                                    case .failure(let error):
                                        errorClosure("Unable to complete the request, try again!")
                                        print("Request failed with error: \(error)")
                                    }
                                } else {
                                    
                                    errorClosure("Unable to complete the request, try again!")
                                }
                            }else if stCode == 201{
                                if((response.value) != nil) {
                                    switch response.result {
                                    case .success( _):
                                        let json = JSON(response.data!)
                                        print(json)
                                        
                                        do{
                                            if let jsonNew = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] {
                                                print(json)
                                            }
                                            let jsonN = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                                            //  callBack.onSuccess(json)
                                            success(json, jsonN, ermsg ?? "")
                                        } catch let error {
                                            // callBack.onFailure(error.localizedDescription)
                                            errorClosure(error.localizedDescription)
                                        }
                                        
                                        
                                        
                                    case .failure(let error):
                                        errorClosure("Unable to complete the request, try again!")
                                        print("Request failed with error: \(error)")
                                    }
                                } else {
                                    
                                    errorClosure("Unable to complete the request, try again!")
                                }
                            }else if stCode == 202{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 400{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 401{
                                //  errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                                //                            VCType.showCustomPopup(altMsg: "Session Expired,Please Login Again", cancelHide: true) {
                                //                                VCType.dismiss(animated: true) {
                                //                                     VCType.log_Out_from_App()
                                //                                }
                                //
                                //                          }
                                
                            }else if stCode == 402{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 404{
                                
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 405{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 500{
                                
                                errorClosure(ermsg ?? "500:Server Error, try again!")
                                
                            }else if stCode == 503{
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                            }else{
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                            }
                            
                            
                        }
                       }
        }
        
    }
    
    
    func sendNewRequestSocketServerPostWithHeaderModel<T:Codable>(VCType:UIViewController,ReqMethod:HTTPMethod, dictParameter: [String:Any],isShowLoader:Bool = true ,responseObject:T.Type, success:@escaping (_ json:JSON,_ parsedModel:T,_ strMsg:String) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.")
            return
        }
        if isShowLoader{
            //VCType.showLoader()
        }
        
        
        
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en",
            "Content-Type": "application/json"
            
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(socketurl
                       , method: ReqMethod, parameters: dictParameter, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
                        debugPrint(response)
                        VCType.hideLoader()
                        DispatchQueue.main.async {
                            let stCode = response.response?.statusCode
                            
                            let json = JSON(response.data ?? Data())
                            let ermsg = json["message"].string
                            
                            if stCode == 200{
                                if((response.value) != nil) {
                                    switch response.result {
                                    case .success( _):
                                        let json = JSON(response.data!)
                                        print(json)
                                        do{
                                            if let jsonNew = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] {
                                                print(json)
                                            }
                                            let jsonN = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                                            //  callBack.onSuccess(json)
                                            success(json, jsonN, ermsg ?? "")
                                        } catch let error {
                                            // callBack.onFailure(error.localizedDescription)
                                            errorClosure(error.localizedDescription)
                                        }
                                        
                                        
                                    case .failure(let error):
                                        errorClosure("Unable to complete the request, try again!")
                                        print("Request failed with error: \(error)")
                                    }
                                } else {
                                    
                                    errorClosure("Unable to complete the request, try again!")
                                }
                            }else if stCode == 201{
                                if((response.value) != nil) {
                                    switch response.result {
                                    case .success( _):
                                        let json = JSON(response.data!)
                                        print(json)
                                        
                                        do{
                                            if let jsonNew = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] {
                                                print(json)
                                            }
                                            let jsonN = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                                            //  callBack.onSuccess(json)
                                            success(json, jsonN, ermsg ?? "")
                                        } catch let error {
                                            // callBack.onFailure(error.localizedDescription)
                                            errorClosure(error.localizedDescription)
                                        }
                                        
                                        
                                        
                                    case .failure(let error):
                                        errorClosure("Unable to complete the request, try again!")
                                        print("Request failed with error: \(error)")
                                    }
                                } else {
                                    
                                    errorClosure("Unable to complete the request, try again!")
                                }
                            }else if stCode == 202{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 400{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 401{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                                
                            }else if stCode == 402{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 404{
                                
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 405{
                                
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                                
                            }else if stCode == 500{
                                
                                errorClosure(ermsg ?? "500:Server Error, try again!")
                                
                            }else if stCode == 503{
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                            }else{
                                errorClosure(ermsg ?? "Unable to complete the request, try again!")
                            }
                            
                            
                        }
                       }
        }
        
    }
    
}
