//
//  MACROS.swift
//  EmizenGrocery
//
//  Created by emizen on 13/01/20.
//  Copyright © 2020 emizen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

//let App_main_clor = UIColor(displayP3Red: 48.0/255.0, green: 219.0/255.0, blue: 91.0/255.0, alpha: 1.0)
let App_main_clor = UIColor(red: 1, green: 0.518, blue:  0.067, alpha: 1.0)
let App_LightPink_clor = UIColor(red: 255.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
let App_main_dark = UIColor(red: 53/255, green: 71/255, blue: 82/255, alpha: 1.0)
let Applightcolor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1.0)




let scaleFactorX = UIScreen.main.bounds.width / 375
let scaleFactorY = UIScreen.main.bounds.height / 667

var OKNewCallBack:(() -> Void)?
var MyOrderCallBack:(() -> Void)?

//MARK-Default app database

var CURRENT_LAT = ""
var CURRENT_LONG = ""
var CURRENT_CORDINATE:CLLocationCoordinate2D?
var SELECTED_CORDINATE:CLLocationCoordinate2D?
var HOME_ADDRESS = ""
let APP_USER_ID = "userid"
let APP_EMAIL_ID = "email"
let APP_MOBILE_NUM = "mobile"
let APP_USER_NAME = "name"
let APP_User_Rated = "rated"
let APP_USER_DOB = "birth"
let APP_USER_GENDER = "gender"
let APP_USERFIRST_NAME = "first"
let APP_USERLAST_NAME = "last"
let APP_ACCESS_TOKEN = "token"
let App_CURRENT_THEME="theme"
let APP_CURRENT_LANG = "language"
let APP_USER_TYPE = "user"
let APP_USER_SHOW_IMG = "images"
let APP_USER_SHOW_LED = "leadrboard"
let APP_USER_SHOW_ADV = "adventures"
let APP_USER_ADDRESS = "address"
let APP_USER_COUNTRY = "country"
let APP_IS_LOGIN = "login"
let App_User_Id="id"
let App_User_Img="img"
let APP_FCM_TOKEN = "fcm"
let App_User_Role="role"
let App_User_Msg="msg"
let App_User_Addtype="type"
let App_User_Subscribe="subcribe"



let APP_User_IMAGE = "image"
let APP_Saved_Address = "address"

let APP_Saved_Lat = "lat"
let App_Saved_Long = "long"
let AppUseFirstTime = "first"
var ct = 1
let mainStory = UIStoryboard(name: "Main", bundle: nil)
let second = UIStoryboard(name: "Second", bundle: nil)

let DEVICE_TYPE = "2"
var APP_DEVICE_TOKEN = ""
var APP_CART_COUNT = 0
var SwitchValue="switch"
var Notiswitchvalue="noti"
var AppSubCatId="sub"
var Appcatid="cat"
//MARK:Api url


//Local Development Url
let baseURL="https://classified.ezxdemo.com/api/"
let socketurl=""

//Live Development  url
//let baseURL="https://mzadi.ezxdemo.com/api"


let LoginUrl = "login"
let GetState = "get-regions"
let GetCities = "get-cities"
let otpsend = "otpsend"
let OtpVerifyUrl = "otpverification"
let ResetPass = "updatepassword"
let ProfileApi = "sellerprofile"

////

let RegisterURl = "register"
let OtpResendUrl = "otpsend"
let UserMyProfileUrl="myprofile"
let GetMyProductUrl="myproduct"
let HomeUrl="home"
let GetCategoryListurl="getcategorylist"
let HomeSearchSuggestionUrl="searchsuggestion"
let UpdateProfileURl="updateprofile"
let SidebarSubCatUrl="sidebar_sub_cat"
let SubcategoryUrl="sub_cat"
let ImageUploadUrl="fileupload"
let ProductListUrl = "productlist"
let ProductLocationUrl="productlocationlist"
let GetOptionList = "getoptionlist"
let SubCatproducType="producttype"
let GetCmsUrl="getcms"
let ProductDetailUrl = "productdetail"
let AddPostUrl="addproduct"
let FavStatusUrl = "favouritestatus"
let SelectedAddTypeUrl="checkaddpostconditions"
let FollowUrl = "followerstatus"
let FavPruductUrl = "favouriteproduct"
let FollowersUrl = "followers"
let FollowingUrl = "following"
let SellerUrl = "sellerprofile"
let AddCommentUrl="addcomment"
let ReportSubmitUrl="reportsubmit"
let ReasonListUrl="reasonlist"
let removeUrl = "deleteproduct"
let updateProductStatusUrl = "updateproductstatus"
let RepostApiUrl="repostproduct"
let editproducturl="editproductdetail"
let EditProductUrl="editproduct"
let ImageDeleteUrl="deleteuploadimage"
let PostRejectUrl="rejectproduct"
let SaveFirebaseUrl="savefirebasetoken"
let GetNotificationUrl="getnotifications"
let UpdateNotificationUrl="updatenotificationstatus"
let LogOutUrl="logout"
let DeleteCommentUrl="deleteComment"
let ContactusUrl="contact-us"
let PlanListUrl="planslist"
let SubcriptionPlanUrl="iphonesubscription"
let MyplanListUrl="myplanlist"
let ClearNotificationUrl="clearnotifications"







enum STATUS_CODE:Int{
    
    case SUCCESS = 200
    case CREATED = 201
    case ACCEPTED = 202
    case BAD_REQUEST = 400
    case UNAUTHORIZED = 401
    case FORBIDDEN = 402
    case NOT_FOUND = 404
    case INTERNAL_SERVER_ERROR = 500
    case SERVICE_UNAVAILABLE = 503
}


