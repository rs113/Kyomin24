//
//  APIManager.swift
//  LifeNest
//
//  Created by Virendra Sharma on 03/09/19.
//  Copyright © 2019 Virendra Sharma. All rights reserved.
//


import Alamofire
import UIKit
import SwiftyJSON
import Localize_Swift



class ApiManager:NSObject{
    
    static let apiShared = ApiManager()
    
    
    func sendRequestServerPostWithHeader1(url:String,VCType:UIViewController,isShowLoader:Bool = true, dictParameter: [String:Any] , success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String,_ statusCode:Int) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.".localized(), 0)
            return
        }
        
        if isShowLoader{
            VCType.showLoader()
        }
        
        //VCType.showLoader()
        
        print("ServerURL:- \(url)")
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
           // "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "Accept":"application/json"
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(baseURL + url
                , method: .post, parameters: dictParameter, encoding: URLEncoding.default,headers: headers).responseJSON { response in
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
                                    success(json)
                                    
                                case .failure(let error):
                                    
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized(), stCode ?? 0)
                            }
                        }else if stCode == 201{
                            if((response.value) != nil) {
                                switch response.result {
                                case .success( _):
                                    let json = JSON(response.data!)
                                    print(json)
                                    success(json)
                                    
                                case .failure(let error):
                                    
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized(), stCode ?? 0)
                            }
                        }else if stCode == 202{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 400{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 401{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            //        VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                            //        VCType.dismiss(animated: true, completion: nil)
                            //            // VCType.log_Out_from_App()
                            //                        }
                            
                        }else if stCode == 419{
                            VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                                VCType.dismiss(animated: true, completion: nil)
                                VCType.log_Out_from_App()
                            }
                            
                        }
                        else if stCode == 402{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 404{
                            
                            errorClosure(ermsg ?? " Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 500{
                            
                            errorClosure(ermsg ?? "500:Server Error try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 503{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                        }else{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                        }
                        
                        
                    }
            }
        }
        
    }
    
    
    func sendRequestServerPostWithHeaderK24(url:String,VCType:UIViewController,isShowLoader:Bool = true, dictParameter: [String:Any] , success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String,_ statusCode:Int) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.".localized(), 0)
            return
        }
        
        if isShowLoader{
            VCType.showLoader()
        }
        
        //VCType.showLoader()
        
        print("ServerURL:- \(url)")
        print(dictParameter)
       // let headers: HTTPHeaders!
        
        let headers : HTTPHeaders = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
       
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(baseURL + url
                , method: .post, parameters: dictParameter, encoding: URLEncoding.default,headers: headers).responseJSON { response in
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
                                    success(json)
                                    
                                case .failure(let error):
                                    
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized(), stCode ?? 0)
                            }
                        }else if stCode == 201{
                            if((response.value) != nil) {
                                switch response.result {
                                case .success( _):
                                    let json = JSON(response.data!)
                                    print(json)
                                    success(json)
                                    
                                case .failure(let error):
                                    
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized(), stCode ?? 0)
                            }
                        }else if stCode == 202{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 400{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 401{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            //        VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                            //        VCType.dismiss(animated: true, completion: nil)
                            //            // VCType.log_Out_from_App()
                            //                        }
                            
                        }else if stCode == 419{
                            VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                                VCType.dismiss(animated: true, completion: nil)
                                VCType.log_Out_from_App()
                            }
                            
                        }
                        else if stCode == 402{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 404{
                            
                            errorClosure(ermsg ?? " Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 500{
                            
                            errorClosure(ermsg ?? "500:Server Error try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 503{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                        }else{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                        }
                        
                        
                    }
            }
        }
        
    }
    
    func sendRequestServerPostWithHeader(url:String,VCType:UIViewController,isShowLoader:Bool = true, dictParameter: [String:Any] , success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String,_ statusCode:Int) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.".localized(), 0)
            return
        }
        
        if isShowLoader{
            VCType.showLoader()
        }
        
        //VCType.showLoader()
        
        print("ServerURL:- \(url)")
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(baseURL + url
                , method: .post, parameters: dictParameter, encoding: URLEncoding.default,headers: headers).responseJSON { response in
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
                                    success(json)
                                    
                                case .failure(let error):
                                    
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized(), stCode ?? 0)
                            }
                        }else if stCode == 201{
                            if((response.value) != nil) {
                                switch response.result {
                                case .success( _):
                                    let json = JSON(response.data!)
                                    print(json)
                                    success(json)
                                    
                                case .failure(let error):
                                    
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized(), stCode ?? 0)
                            }
                        }else if stCode == 202{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 400{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 401{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            //        VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                            //        VCType.dismiss(animated: true, completion: nil)
                            //            // VCType.log_Out_from_App()
                            //                        }
                            
                        }else if stCode == 419{
                            VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                                VCType.dismiss(animated: true, completion: nil)
                                VCType.log_Out_from_App()
                            }
                            
                        }
                        else if stCode == 402{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 404{
                            
                            errorClosure(ermsg ?? " Unable to complete the request, try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 500{
                            
                            errorClosure(ermsg ?? "500:Server Error try again!".localized(), stCode ?? 0)
                            
                        }else if stCode == 503{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                        }else{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized(), stCode ?? 0)
                        }
                        
                        
                    }
            }
        }
        
    }
    
    
    func sendRequestServerPostWithHeaderModel<T:Codable>(url:String,VCType:UIViewController,ReqMethod:HTTPMethod, dictParameter: [String:Any],isShowLoader:Bool = true ,responseObject:T.Type, success:@escaping (_ json:JSON,_ parsedModel:T,_ strMsg:String) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.".localized())
            return
        }
        if isShowLoader{
            VCType.showLoader()
        }
        
        
        
        print("ServerURL:- \(url)")
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en",
            "Content-Type": "application/json"
            
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(baseURL + url
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
                                    errorClosure("Unable to complete the request, try again!".localized())
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized())
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
                                    errorClosure("Unable to complete the request, try again!".localized())
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized())
                            }
                        }else if stCode == 202{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 400{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 401{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                            //                            VCType.showCustomPopup(altMsg: "Session Expired,Please Login Again", cancelHide: true) {
                            //                                VCType.dismiss(animated: true) {
                            //                                     VCType.log_Out_from_App()
                            //                                }
                            //
                            //                          }
                            
                        }else if stCode == 419{
                            VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                                VCType.dismiss(animated: true, completion: nil)
                                VCType.log_Out_from_App()
                            }
                            
                        }
                        else if stCode == 402{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 404{
                            
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 405{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 500{
                            
                            errorClosure(ermsg ?? "500:Server Error, try again!".localized())
                            
                        }else if stCode == 503{
                        errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        }else{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        }
                        
                        
                    }
            }
        }
        
    }
    
    
    func sendNewRequestServerPostWithHeaderModel<T:Codable>(url:String,VCType:UIViewController,ReqMethod:HTTPMethod, dictParameter: [String:Any],isShowLoader:Bool = true ,responseObject:T.Type, success:@escaping (_ json:JSON,_ parsedModel:T,_ strMsg:String) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.".localized())
            return
        }
        if isShowLoader{
            //VCType.showLoader()
        }
        
        
        
        print("ServerURL:- \(url)")
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en",
            "Content-Type": "application/json"
            
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(baseURL + url
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
                                    errorClosure("Unable to complete the request, try again!".localized())
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized())
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
                                    errorClosure("Unable to complete the request, try again!".localized())
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized())
                            }
                        }else if stCode == 202{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 400{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 401{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            //                            VCType.showCustomPopup(altMsg: "Session Expired,Please Login Again", cancelHide: true) {
                            //                                VCType.dismiss(animated: true) {
                            //                                     VCType.log_Out_from_App()
                            //                                }
                            //
                            //                          }
                            
                        }else if stCode == 419{
                            VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                                VCType.dismiss(animated: true, completion: nil)
                                VCType.log_Out_from_App()
                            }
                            
                        }
                        else if stCode == 402{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 404{
                            
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 405{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 500{
                            
                            errorClosure(ermsg ?? "500:Server Error, try again!".localized())
                            
                        }else if stCode == 503{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        }else{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        }
                        
                        
                    }
            }
        }
        
    }
    func SendRequestServerPostWithHeaderModel<T:Codable>(url:String,ReqMethod:HTTPMethod, dictParameter: [String:Any],isShowLoader:Bool = true ,responseObject:T.Type, success:@escaping (_ json:JSON,_ parsedModel:T,_ strMsg:String) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("You’ve been away from the app for some time. Please refresh the home screen and check your internet connection.".localized())
            return
        }
        
        
        
        
        print("ServerURL:- \(url)")
        print(dictParameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en",
            "Content-Type": "application/json"
        ]
        
        print(headers)
        DispatchQueue.global(qos: .default).async {
            AF.request(baseURL + url
                , method: ReqMethod, parameters: dictParameter, encoding:JSONEncoding.default,headers: headers).responseJSON { response in
                    debugPrint(response)
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
                                    errorClosure("Unable to complete the request, try again!".localized())
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized())
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
                                    errorClosure("Unable to complete the request, try again!".localized())
                                    print("Request failed with error: \(error)")
                                }
                            } else {
                                
                                errorClosure("Unable to complete the request, try again!".localized())
                            }
                        }else if stCode == 202{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 400{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 401{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            //                            VCType.showCustomPopup(altMsg: "Session Expired,Please Login Again", cancelHide: true) {
                            //                                VCType.dismiss(animated: true) {
                            //                                     VCType.log_Out_from_App()
                            //                                }
                            //
                            //                          }
                            
                        }else if stCode == 419{
                            //                                self.showCustomPopupView(altMsg:ermsg ?? "Session expire please login", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                            //                                        VCType.dismiss(animated: true, completion: nil)
                            //                                             VCType.log_Out_from_App()
                            //                                                                    }
                            
                        }
                        else if stCode == 402{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 404{
                            
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 405{
                            
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                            
                        }else if stCode == 500{
                            
                            errorClosure(ermsg ?? "500:Server Error, try again!".localized())
                            
                        }else if stCode == 503{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        }else{
                            errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        }
                        
                        
                    }
            }
        }
        
    }
    
    func RequestMultiPartPOSTURLwithImageVideo<T:Codable>(url:String,VCType:UIViewController, arrImageVideo : [[String:Any]],  params : [String : AnyObject]?,isShowLoader:Bool = true ,imageKey:String,thumbNailKey:String,responseObject:T.Type, success:@escaping ( _ json:JSON, _ parsedModel:T, _ strMsg:String) -> Void,errorClosure : @escaping (  _ errorMessage:String) -> Void)
        
    {
        
        
        
        
        if Reachability.isConnectedToNetwork() == false{
            errorClosure("Please Check Internet Connection and try again!".localized())
            return
        }
        if isShowLoader{
            VCType.showLoader()
        }
        
        
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
        ]
        
        AF.upload(multipartFormData: { (FormData) in
            
            for (key, value) in params! {
                
                FormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            
            
            for i in 0..<arrImageVideo.count
                
            {
                let di = arrImageVideo[i]
                if di["type"] as? String == "image"{
                    let img = di["img"] as? UIImage ?? UIImage()
                    let tim = Date().timeIntervalSince1970
                    let imgThumb = di["imgThumb"] as? UIImage ?? UIImage()
                    let imag_name = String(format: "Image%d%d.png", tim,i)
                    if  let imageData = img.jpegData(compressionQuality: 0.3) {
                        
                        FormData.append(imageData, withName: imageKey, fileName: "image.jpg", mimeType: "image/png")
                        
                        
                    }
                    if  let imageThumbData = imgThumb.jpegData(compressionQuality: 0.45) {
                        
                        FormData.append(imageThumbData, withName: thumbNailKey, fileName: "image.jpg", mimeType: "image/png")
                        
                        
                    }
                    
                }else{
                    let videoUrl = di["videoUrl"] as? NSURL
                    let imgThumb = di["img"] as? UIImage ?? UIImage()
                    do{
                        let vidData =  try Data(contentsOf: videoUrl! as URL, options: .mappedIfSafe)
                        FormData.append(vidData, withName: imageKey, fileName: "video.mp4", mimeType: "mp4")
                        if  let imageData = imgThumb.jpegData(compressionQuality: 0.45) {
                            
                            FormData.append(imageData, withName: thumbNailKey, fileName: "image.jpg", mimeType: "image/png")
                            // MultipartFormData.append(imageData, withName: "profile_img")
                            
                        }
                    }catch{
                        print("")
                    }
                }
            }
            
            
            
        } , to: baseURL + url, method: .post, headers: headers)
            .responseJSON { (response) in
                debugPrint("SUCCESS RESPONSE: \(response)")
                
                
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
                                errorClosure("Unable to complete the request, try again!".localized())
                                print("Request failed with error: \(error)")
                            }
                        } else {
                            
                            errorClosure("Unable to complete the request, try again!".localized())
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
                                errorClosure("Unable to complete the request, try again!".localized())
                                print("Request failed with error: \(error)")
                            }
                        } else {
                            
                            errorClosure("Unable to complete the request, try again!".localized())
                        }
                    }else if stCode == 202{
                        
                        errorClosure(ermsg ?? "202 Unable to complete the request, try again!".localized())
                        
                    }else if stCode == 400{
                        
                        errorClosure(ermsg ?? "400 Unable to complete the request, try again!".localized())
                        
                    }else if stCode == 401{
                        
                        
                        errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                        
                        //               //                      let json = JSON(response.data ?? Data())
                        //               //                      let ermsg = json["message"].string
                        //                                    // errorClosure(ermsg ?? "401 Unable to complete the request, try again!")
                        //                            VCType.showCustomPopupView(altMsg: "401 Session Expired,Please Login Again", alerttitle: "Error!", alertimg:UIImage(named:"Errorimg")) {
                        //                                           VCType.log_Out_from_App()
                        //                                    }
                        //                                    showCustomPopup(altMsg: "401 Session Expired,Please Login Again", cancelHide: false) {
                        //                                           VCType.log_Out_from_App()
                        //                                       }
                        
                    }else if stCode == 419{
                        VCType.showCustomPopupView(altMsg:ermsg ?? "Session expire please login".localized(), alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                            VCType.dismiss(animated: true, completion: nil)
                            VCType.log_Out_from_App()
                        }
                        
                    }
                    else if stCode == 402{
                        
                        errorClosure(ermsg ?? "402 Unable to complete the request, try again!".localized())
                        
                    }else if stCode == 404{
                        
                        
                        errorClosure(ermsg ?? "404 Unable to complete the request, try again!".localized())
                        
                    }else if stCode == 405{
                        
                        errorClosure(ermsg ?? "405 Unable to complete the request, try again!".localized())
                        
                    }else if stCode == 500{
                        
                        errorClosure(ermsg ?? "500 Server Error, try again!".localized())
                        
                    }else if stCode == 503{
                        errorClosure(ermsg ?? "503 Unable to complete the request, try again!".localized())
                    }else{
                        errorClosure(ermsg ?? "Unable to complete the request, try again!".localized())
                    }
                    
                    
                }
        }
        
    }
    
    
    func postImageAPI( image:UIImage, imageName:String,VCType:UIViewController,isShowLoader:Bool = true,parameter:[String:Any], url:String, _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        
        
        
        
        if isShowLoader{
            VCType.showLoader()
        }
        
        let path =  baseURL + url
        debugPrint(path)
        debugPrint(parameter)
        
        
        print("ServerURL:- \(url)")
        print(parameter)
        let headers: HTTPHeaders!
        headers = [
            "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
            "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
        ]
        
        //            print("ServerURL:- \(url)")
        //            print(parameter)
        //            let headers: HTTPHeaders!
        //            headers = [
        //                "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")"
        //            ]
        
        print(headers)
        
        
        
        let imageData = image.jpegData(compressionQuality: 0.80)
        debugPrint(image, imageData)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: imageName, fileName: "swift_file.png", mimeType: "image/png")
            for (key, value) in parameter {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: path, method: .post, headers: headers)
            .uploadProgress{progress in
                debugPrint("uploading \(progress)")
               
        }
            
        .response{ resp in
            VCType.hideLoader()
            switch resp.result {
            case .success(_):
                if let value = resp.value {
                    let json = JSON(value!)
                    successBlock(json)
                }
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
        
    }
    //
    //    func postImageAPI( image:UIImage, imageName:String,parameter:[String:Any], url:String, _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
    //
    //            let path =  baseURL + url
    //            debugPrint(path)
    //            debugPrint(parameter)
    //
    //  print("ServerURL:- \(url)")
    //  print(parameter)
    //  let headers: HTTPHeaders!
    //  headers = [
    //      "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")"
    //  ]
    //
    //  print(headers)
    //
    //
    //
    //            let imageData = image.jpegData(compressionQuality: 0.80)
    //            debugPrint(image, imageData!)
    //
    //        AF.upload(multipartFormData: { multipartFormData in
    //
    //              for (key, value) in parameter {
    //                  if let temp = value as? String {
    //                      multipartFormData.append(temp.data(using: .utf8)!, withName: key)
    //                  }
    //                  if let temp = value as? Int {
    //                      multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
    //                  }
    //                  if let temp = value as? NSArray {
    //                      temp.forEach({ element in
    //                          let keyObj = key + "[]"
    //                          if let string = element as? String {
    //                              multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
    //                          } else
    //                              if let num = element as? Int {
    //                                  let value = "\(num)"
    //                                  multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
    //                          }
    //                      })
    //                  }
    //              }
    //
    //              if let data = imageData{
    //                  multipartFormData.append(data, withName: "file", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
    //              }
    //          },
    //                    to: path, method: .post , headers: headers)
    //              .responseJSON(completionHandler: { (response) in
    //
    //                  print(response)
    //
    //                  if let err = response.error{
    //                      print(err)
    //                      return
    //                  }
    //                  print("Succesfully uploaded")
    //
    //                  let json = response.data
    //
    //                  if (json != nil)
    //                  {
    //                      let jsonObject = JSON(json!)
    //                      print(jsonObject)
    //                  }
    //              })
    //        }
    //
    
    
    //            AF.upload(multipartFormData: { (multipartFormData) in
    //                        if  let imageData = image.jpegData(compressionQuality: 0.6) {
    //                                        let tst =  NSDate().timeIntervalSince1970
    //                                        let ss = String(tst)
    //
    //    multipartFormData.append(imageData, withName: "photo", fileName: "\(ss)_pic", mimeType: "image/png")
    //
    //            }
    //
    //                        for (key, value) in parameter {
    //                           // multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
    //                            multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
    //                        }
    //
    //
    //                    }, to: path, method: .post, headers: headers)
    //                .uploadProgress{progress in
    //                    debugPrint("uploading \(progress)")
    //            }
    //            .response{ resp in
    //                switch resp.result {
    //                case .success(_):
    //                    if let value = resp.value {
    //                        let json = JSON(value!)
    //                        successBlock(json)
    //                    }
    //                case .failure(let error):
    //                    errorBlock(error as NSError)
    //                }
    //                            }
    //
    
    
    //MARK:get api
    func sendRequestToServerGet (url:String,token: String,success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
        
        let headers: HTTPHeaders!
        if token != ""{
            headers = [
                "content-type": "application/x-www-form-urlencoded",
                "x-access-token": token
            ]
        }else{
            headers = [
                "content-type": "application/x-www-form-urlencoded"
            ]
        }
        print("headers -- \(String(describing: headers))")
        var urlstr : String = ""
        if url.contains("") {
            urlstr = url
        } else {
            urlstr = baseURL + url
        }
        DispatchQueue.global(qos: .default).async {
            let encodedUrl = (urlstr).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            AF.request(encodedUrl!, headers: headers).responseJSON{ response in
                debugPrint(response)
                DispatchQueue.main.async {
                    if((response.value) != nil) {
                        switch response.result {
                        case .success( _):
                            let json = JSON(response.data!)
                            print(json)
                            success(json)
                            
                        case .failure(let error):
                            
                            print("Request failed with error: \(error)")
                        }
                    } else {
                        errorClosure("Unable to complete the request, try again!".localized())
                    }
                }
            }
        }
    }
    
    
    
    
    
    //MARK:Multipart image and video upload api
    func requestMultiPartPOSTURLwithImageVideo(_ strURL : String, arrImageVideo : [[String:Any]],  params : [String : AnyObject]?, success:@escaping (_ json:JSON) -> Void, errorClosure:@escaping (_ errorMessage:String) -> Void)
        
    {
        let aStr = baseURL+strURL
        
        
        let headers: HTTPHeaders = [
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        AF.upload(multipartFormData: { (FormData) in
            
            for (key, value) in params! {
                
                FormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            
            
            for i in 0..<arrImageVideo.count
                
            {
                let di = arrImageVideo[i]
                if di["type"] as? String == "image"{
                    let img = di["img"] as? UIImage ?? UIImage()
                    let imgThumb = di["imgThumb"] as? UIImage ?? UIImage()
                    let tim = Date().timeIntervalSince1970
                    let imag_name = String(format: "Image%d%d.png", tim,i)
                    if  let imageData = img.jpegData(compressionQuality: 0.6) {
                        
                        FormData.append(imageData, withName: "file[\(i)][file]", fileName: "image.jpg", mimeType: "image/png")
                        // MultipartFormData.append(imageData, withName: "profile_img")
                        
                    }
                    if  let imageDataT = imgThumb.jpegData(compressionQuality: 0.6) {
                        
                        FormData.append(imageDataT, withName: "file[\(i)][thumb]", fileName: "image.jpg", mimeType: "image/png")
                        // MultipartFormData.append(imageData, withName: "profile_img")
                        
                    }
                }else{
                    let videoUrl = di["videoUrl"] as? NSURL
                    let imgThumb = di["img"] as? UIImage ?? UIImage()
                    do{
                        let vidData =  try Data(contentsOf: videoUrl! as URL, options: .mappedIfSafe)
                        FormData.append(vidData, withName: "file[\(i)][file]", fileName: "video.mp4", mimeType: "mp4")
                        if  let imageData = imgThumb.jpegData(compressionQuality: 0.6) {
                            
                            FormData.append(imageData, withName: "file[\(i)][thumb]", fileName: "image.jpg", mimeType: "image/png")
                            // MultipartFormData.append(imageData, withName: "profile_img")
                            
                        }
                    }catch{
                        print("")
                    }
                }
                
                
                
            }
            
            
            
            
        } , to: aStr, method: .post, headers: headers)
            .responseJSON { (response) in
                debugPrint("SUCCESS RESPONSE: \(response)")
        }
        
        
        
        //
    }
    
    //MARK:Multipart image video upload api with thumbnail
    func requestMultiPartPOSTWithThumbnail(_ strURL : String, arrImageVideo : [[String:Any]],  params : [String : AnyObject]?, success:@escaping (_ json:JSON) -> Void, errorClosure:@escaping (_ errorMessage:String) -> Void)
        
    {
        let aStr = baseURL+strURL
        
        
        let headers: HTTPHeaders = [
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        AF.upload(multipartFormData: { (FormData) in
            
            for (key, value) in params! {
                
                FormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            
            
            for i in 0..<arrImageVideo.count
                
            {
                let di = arrImageVideo[i]
                if di["type"] as? String == "image"{
                    let img = di["img"] as? UIImage ?? UIImage()
                    
                    let tim = Date().timeIntervalSince1970
                    let imag_name = String(format: "Image%d%d.png", tim,i)
                    if  let imageData = img.jpegData(compressionQuality: 0.6) {
                        
                        FormData.append(imageData, withName: "file[\(i)]", fileName: "image.jpg", mimeType: "image/png")
                        // MultipartFormData.append(imageData, withName: "profile_img")
                        
                    }
                    
                }else{
                    let videoUrl = di["videoUrl"] as? NSURL
                    let imgThumb = di["img"] as? UIImage ?? UIImage()
                    do{
                        let vidData =  try Data(contentsOf: videoUrl! as URL, options: .mappedIfSafe)
                        FormData.append(vidData, withName: "file[\(i)][file]", fileName: "video.mp4", mimeType: "mp4")
                        if  let imageData = imgThumb.jpegData(compressionQuality: 0.6) {
                            
                            FormData.append(imageData, withName: "file[\(i)][thumb]", fileName: "image.jpg", mimeType: "image/png")
                            // MultipartFormData.append(imageData, withName: "profile_img")
                            
                        }
                    }catch{
                        print("")
                    }
                }
                
                
                
            }
            
            
            
            
        }, to: aStr, method: .post, headers: headers)
            .responseJSON { (response) in
                debugPrint("SUCCESS RESPONSE: \(response)")
        }
        
        
        
        //
    }
    
    
    
    
    
    //    func apiRequest<T:Codable>(url: String,isFormdata:Bool, params: [String:Any], method: Method, responseObject:T.Type,WithFlag flag: Bool = false,callBack:@escaping (_ json:JSON,_ parsedModel:T,_ strMsg:String) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
    //
    //           //Check internet connection
    //           if Reachability.isConnectedToNetwork() == false{
    //               errorClosure("Please Check Internet Connection and try again!".localized())
    //               return
    //           }
    //
    //           // Dict to Json
    //           if let theJSONData = try? JSONSerialization.data(
    //               withJSONObject: params,
    //               options: []) {
    //               let theJSONText = String(data: theJSONData,
    //                                        encoding: .utf8)
    //               print("JSON string = \(theJSONText!)")
    //           }
    //          // VCType.showLoader()
    //
    //           print("ServerURL:- \(url)")
    //           print(params)
    //           let headers: HTTPHeaders!
    //           headers = [
    //               "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
    //               "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
    //           ]
    //
    //           guard var urlComponents = URLComponents(string: baseURL + url) else { return }
    //
    //           var queryItems = [URLQueryItem]()
    //
    //           for (key,value) in params {
    //               queryItems.append(URLQueryItem(name:key, value: value as? String))
    //           }
    //
    //           var payloadData:Data?
    //           if flag {
    //               do {
    //                   payloadData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
    //
    //               } catch {
    //                   print(error.localizedDescription)
    //               }
    //           }
    //           else {
    //               if queryItems.count != 0 {
    //                   urlComponents.queryItems = queryItems
    //               }
    //
    //
    //           }
    //
    //           do {
    //               if let data = payloadData {
    //                   let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
    //                   print(json)
    //               }
    //
    //           } catch let error {
    //               print(error)
    //           }
    //           print("Requested URL is:\(urlComponents.url!.absoluteString)")
    //
    //           var  request = URLRequest(url: urlComponents.url!)
    //           request.httpMethod = "POST"
    //
    //           //MARK Headers
    ////           if Defaults.getStringValue(forKey: Constants.SESSION_TOKEN) != nil {
    ////               let headers = ["Authorization": "Bearer " + Defaults.getStringValue(forKey: Constants.SESSION_TOKEN)] as [String: Any]
    ////
    ////               print(headers)
    ////
    ////               request.allHTTPHeaderFields = headers as? [String : String]
    ////           }
    ////           else {
    ////               let headers = [:] as [String : Any]
    ////               request.allHTTPHeaderFields = headers as? [String : String]
    ////           }
    //
    //           request.allHTTPHeaderFields = headers
    ////           if method.name == "POST" && isFormdata {
    ////               //  request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    ////               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    ////               request.httpBody       =  try? JSONSerialization.data(withJSONObject: params, options: [])
    ////
    ////           }else{
    ////
    ////               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    ////           }
    //           print(params)
    //           print("URL: \(urlComponents)")
    //           session.dataTask(with: request) { (data, response, error) -> Void in
    //               if let data = data {
    //                   print(String(data: data, encoding: .utf8)!)
    //                   if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
    //                       do{
    //                           if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    //                               print(json)
    //                           }
    //                           let json = try JSONDecoder().decode(T.self, from: data)
    //                           callBack.onSuccess(json)
    //                       } catch let error {
    //                           callBack.onFailure(error.localizedDescription)
    //                       }
    //                   }else if let response = response as? HTTPURLResponse, 400...499 ~= response.statusCode{
    //                       print("Api Failed with Response Code:\(response.statusCode)")
    //
    //                       if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    //                           print(json)
    //                           let responceMessage = json["message"] as? String
    //                           if json["message"] as? String == "The consumer isn't authorized to access %resources." {
    //                               DispatchQueue.main.async {
    //                                   let root = UIApplication.shared.visibleViewController
    //                                   let topController = UIWindow.getVisibleViewControllerFrom(vc: root!)
    //
    //                                   CommonFunctions.showAlertWithTitle(title: ConstantStrings.App_Name.localized(), message: "The session has been expire please log in again".localized(), onViewController: topController, withButtonArray: nil) { (buttonIndex) in
    //                                       UtilityClass.callSessionExpireLogOut()
    //                                   }
    //
    //                               }
    //                           } else if ((responceMessage?.range(of: "Server internal error")) != nil) {
    //                           }
    //
    //                           callBack.onFailure(json["message"] as? String ?? "Error")
    //                       }
    //                       callBack.onFailure(response.statusCode.description)
    //
    //
    //                   }else if let response = response as? HTTPURLResponse, 500...599 ~= response.statusCode{
    //                       callBack.onFailure("Currently having some issue on server, Please try again after some time".localized())
    //                   }
    //               }else {
    //                   callBack.onFailure(error?.localizedDescription ?? "")
    //               }
    //           }.resume()
    //
    //       }
    //
}

//func sendRequestToServerPost (url:String, dictParameter: [String:Any] , success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
//
//    print("ServerURL:- \(url)")
//    print(dictParameter)
//    let headers: HTTPHeaders!
//    headers = [
//        "Content-Type": "application/x-www-form-urlencoded",
//
//    ]
//
//    print(headers)
//    DispatchQueue.global(qos: .default).async {
//
//
//        AF.request(baseURL + url
//            , method: .post, parameters: dictParameter, encoding: URLEncoding.default,headers: headers).responseJSON { response in
//                debugPrint(response)
//                DispatchQueue.main.async {
//                    //response.result.value  //Old alamofire syntax
//                    if((response.value) != nil) {
//                        switch response.result {
//                        case .success( _):
//                            let json = JSON(response.data!)
//                            print(json)
//                            success(json)
//
//                        case .failure(let error):
//
//                            print("Request failed with error: \(error)")
//                        }
//                    } else {
//                          errorClosure("Unable to complete the request, try again!")
//                    }
//                }
//        }
//    }
//
//}

//func sendRequestServerPostWithHeader(url:String, dictParameter: [String:Any] , success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
//
//    if Reachability.isConnectedToNetwork() == false{
//        errorClosure("Please Check Internet Connection and try again!".localized())
//        return
//    }
//
//    print("ServerURL:- \(url)")
//    print(dictParameter)
//    let headers: HTTPHeaders!
//    headers = [
//        "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
//        "X-localization":obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "en"
//    ]
//
//    print(headers)
//    DispatchQueue.global(qos: .default).async {
//        AF.request(baseURL + url
//            , method: .post, parameters: dictParameter, encoding: URLEncoding.default,headers: headers).responseJSON { response in
//                debugPrint(response)
//
//                DispatchQueue.main.async {
//                    let stCode = response.response?.statusCode
//                    Check_Status_Code(StCode: stCode ?? 0)
//                    let json = JSON(response.data ?? Data())
//                    let ermsg = json["message"].string
//
//                    if stCode == 200{
//                          if((response.value) != nil) {
//                            switch response.result {
//                            case .success( _):
//                                let json = JSON(response.data!)
//                                print(json)
//                                success(json)
//
//                            case .failure(let error):
//
//                                print("Request failed with error: \(error)")
//                            }
//                        } else {
//
//                              errorClosure("Unable to complete the request, try again!")
//                        }
//                    }else if stCode == 201{
//                        if((response.value) != nil) {
//                          switch response.result {
//                          case .success( _):
//                              let json = JSON(response.data!)
//                              print(json)
//                              success(json)
//
//                          case .failure(let error):
//
//                              print("Request failed with error: \(error)")
//                          }
//                      } else {
//
//                            errorClosure("Unable to complete the request, try again!")
//                      }
//                    }else if stCode == 202{
//
//                       errorClosure(ermsg ?? "Unable to complete the request, try again!")
//
//                    }else if stCode == 400{
//
//                        errorClosure(ermsg ?? "Unable to complete the request, try again!")
//
//                    }else if stCode == 401{
//
////                      let json = JSON(response.data ?? Data())
////                      let ermsg = json["message"].string
//                      errorClosure(ermsg ?? "Unable to complete the request, try again!")
//
//                    }else if stCode == 402{
//
//                       errorClosure(ermsg ?? "Unable to complete the request, try again!")
//
//                    }else if stCode == 404{
//
//                     errorClosure(ermsg ?? "Unable to complete the request, try again!")
//
//                    }else if stCode == 500{
//
//                      errorClosure(ermsg ?? "Unable to complete the request, try again!")
//                        
//                    }else if stCode == 503{
//                        errorClosure(ermsg ?? "Unable to complete the request, try again!")
//                    }else{
//                        errorClosure(ermsg ?? "Unable to complete the request, try again!")
//                    }
//
//
//                }
//        }
//    }
//
//}
//TODO: GET


//TODO: GET Withotu Base URL
//func sendRequestToServerGetWithParam (url:String,params: [String: Any], success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
//
//    let headers: HTTPHeaders!
//    headers = [
//        "content-type": "application/x-www-form-urlencoded"
//    ]
//    print("headers -- \(String(describing: headers))")
//
//    DispatchQueue.global(qos: .default).async {
//        let encodedUrl = (baseURL + url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        AF.request(encodedUrl!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON{ response in
//            debugPrint(response)
//            DispatchQueue.main.async {
//                if((response.value) != nil) {
//                    switch response.result {
//                    case .success( _):
//                        let json = JSON(response.data!)
//                        print(json)
//                        success(json)
//
//                    case .failure(let error):
//
//                        print("Request failed with error: \(error)")
//                    }
//                } else {
//                    errorClosure("Unable to complete the request, try again!")
//                }
//            }
//        }
//       // Alamofire.request(encodedUrl!, headers: headers)
//    }
//}
//TODO: Remove
//func sendRequestToServerRemove (url:String,success: @escaping ( _ json:JSON) -> Void,errorClosure : @escaping ( _ errorMessage:String) -> Void) {
//
//    let headers: HTTPHeaders = [
//        "content-type": "application/x-www-form-urlencoded"
//    ]
//    DispatchQueue.global(qos: .default).async {
//        AF.request(baseURL + url,method:.delete, headers: headers).responseJSON{ response in
//            debugPrint(response)
//            DispatchQueue.main.async {
//                if((response.value) != nil) {
//                    switch response.result {
//                    case .success( _):
//                        let json = JSON(response.data!)
//                        print(json)
//                        success(json)
//
//                    case .failure(let error):
//
//                        print("Request failed with error: \(error)")
//                    }
//                } else {
//                    errorClosure("Unable to complete the request, try again!")
//                }
//            }
//        }
//    }
//}





