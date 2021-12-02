//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Amit Shukla on 22/12/17.
//  Copyright © 2017 Amit Shukla. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import NVActivityIndicatorView
import AVKit
import MobileCoreServices

let isDebug = true



public class ImageModel {
     
    public var image_video : String = ""
    public var thumbnail : String = ""
    
    public class func modelsFromDictionaryArray(array: [[String: Any]]) -> [ImageModel] {
        var models:[ImageModel] = []
        for item in array {
            models.append(ImageModel(dictionary: item))
        }
        return models
    }
    
    required public init() {
        
    }
    required public init(dictionary: [String: Any]) {
        image_video = dictionary["image_video"] as? String ?? ""
        thumbnail = dictionary["thumbnail"] as? String ?? ""
    }
}





class SSFiles {
	var url: URL?
	var image: UIImage?
	var name: String = "File"
	var oldMedia: ImageModel? 
	var isVideo = false
	var thumbImage: UIImage?
	
	init(url: URL, thumbImage: UIImage) {
		self.url = url
		name = (url.absoluteString as NSString).lastPathComponent
		isVideo = true
		self.thumbImage = thumbImage
	}
	
	init(url: URL) {
		self.url = url
		name = (url.absoluteString as NSString).lastPathComponent
	}
	
	init(image: UIImage) {
		self.image = image
		name = "image"
	}
	
	
	init(image: UIImage, thumbImage: UIImage) {
		self.image = image
		name = "image"
		isVideo = false
		self.thumbImage = thumbImage
	}
	
	init(oldMedia: ImageModel) {
		self.oldMedia = oldMedia
	}
	
}

class MultipartImage {
	 
	var image:UIImage!
	var keyName: String = "File"
	var fileName: String = "File"
	 
	init(image: UIImage, keyName: String, fileName: String) {
		self.image = image
		self.keyName = keyName
		self.fileName = fileName
	}
}

class NetworkManager {
	 
	static let PROTOCOL:String = "http://";
	static let SUB_DOMAIN:String =  "testapi.";
	
	static let DOMAIN:String = "newdevpoint.in/";
 
	static let API_DIR:String = "api/";
	
	static let SITE_URL = PROTOCOL + SUB_DOMAIN + DOMAIN;
	static let API_URL = SITE_URL + API_DIR;
	
//	static let STORAGE_URL = SITE_URL + "storage/";
    static let STORAGE_URL = "";
	
	
	
	 
	static let PRIVACY_POLICY_URL = "\(DOMAIN)"
	static let TERMS_AND_CONDITIONS = "\(DOMAIN)"
	
	
	
	
	
	
	//-------------
//    static let URL_FILE_UPLOAD = "\(SITE_URL)upload"//http://192.168.1.6:8000/?url=upload
    static let URL_FILE_UPLOAD = "https://mzadi.ezxdemo.com/api/chatfileupload"
    
	static let URL_TRAVELER_FOLLOWER_LIST = "\(API_URL)user-follower-list"
	static let URL_TRAVELER_FOLLOWING_LIST = "\(API_URL)user-following-list"
	
	
	static let URL_MY_POST_LIST = "\(API_URL)my-post-list"
	static let URL_POST_LIST = "\(API_URL)post-list"
	
	static let URL_DESTINATION_LIKE = "\(API_URL)destination-likes"
	static let URL_PLACE_LIKE_LIST = "\(API_URL)place-likes"
	static let URL_PLACE_FOLLOWES_LIST = "\(API_URL)place-follows"
	static let URL_POST_LIKE_USER_LIST = "\(API_URL)post-like-user-list"
	
	static let URL_TRAVELERS_LIST  = "\(API_URL)travelers-list"
	static let URL_TRAVELERS_DETAILS  = "\(API_URL)traveler-details"
	
	static let URL_SAVE_HOTELS_LIST  = "\(API_URL)save-hotels-list"
	static let URL_SAVE_POST_LIST  = "\(API_URL)save-post-list"
	static let URL_SAVE_FOOD_LIST  = "\(API_URL)save-food-list"
	static let URL_SAVE_DESTINATION_LIST  = "\(API_URL)save-place-destination-list"
	
	static let URL_TAG_DESTINATION_LIST  = "\(API_URL)destination-tags-list"
	static let URL_TAG_HOTELS_LIST  = "\(API_URL)hotel-tags-list"
	static let URL_TAG_POST_LIST  = "\(API_URL)post-tags-list"
	static let URL_TAG_FOOD_LIST  = "\(API_URL)food-tags-list"
	
	
	static let URL_ADVISE_LIST  = "\(API_URL)list-advise"
	static let URL_USER_ADVISE_LIST  = "\(API_URL)list-user-advise"
	
	
	static let URL_PLACE_FOLLOW_LIST  = "\(API_URL)place-follow-list"
	
	
	static let URL_ABOUT_US  = "\(SITE_URL)cms/about-us"
	static let URL_PRIVACY_POLICY  = "\(SITE_URL)cms/about-us"
//
//		static let URL_  = "\(API_URL)travelers-list"
//
//		static let URL_  = "\(API_URL)travelers-list"
//		static let URL_  = "\(API_URL)travelers-list"
	
	
	static func placesList(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)list-places" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func seasonList(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)list-season" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	
	
	
	
	static func clearNotification(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)delete-notification" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func userProfile(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-profile" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	static func fetchRookieLevel(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)rookie-level" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func notificationList(page: Int, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)notifications?page=\(page)" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func reportTypeList(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)report-types" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func topScorers(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)top-scorers" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func getAssignList(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)assign-list" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func getAllFoodList(completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)get-all-food" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func parentDashBoard(slug:String, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)parent-dashboard/\(slug)")  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func getCurrentProfile( completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)my_profile")  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
 
	static func fetchUserRating(page: Int, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-reviews?page=\(page)" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	///----------------
	
	
	static func updateProfile(parameters:Parameters, file:MultipartImage?, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceMultipart(url: "\(API_URL)user-update-profile", parameters:parameters, file: file)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func addAdvise(parameters:Parameters, file:MultipartImage?, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceMultipart(url: "\(API_URL)add-advise", parameters:parameters, file: file)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func addTravelPlan(parameters:Parameters, file:MultipartImage?, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceMultipart(url: "\(API_URL)add-travel-plan", parameters:parameters, file: file)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	///----------------
	
	
	static func login(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceLogin(url: "\(API_URL)login", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	 
	static func resendOtp(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceLogin(url: "\(API_URL)reset-opt", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	static func register(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceLogin(url: "\(API_URL)signup", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func destinationList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)destination-list-by-place", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func placeDetails(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)place-details", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	 
  
	
	static func likeDestination(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)like-destination", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func likePost(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)post-like", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func saveDestination(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)save-place-destination", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func savePost(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)post-save", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func saveFood(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)save-place-food", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func saveHotel(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)save-place-hotels", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func likePlace(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)like-place", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func userTagList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-tag-list", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func tagToUser(url: String, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)\(url)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func followPlace(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)follow-place", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func followTreveler(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-follow", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	///----------------
	
	static func congratate(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)congratulation", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func assignUser(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)assign-more", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func getLogBookData(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)min-max", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func checkInvitationCode(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)check-invitation-code", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func requestTicket(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-ticket", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addReview(isEdit: Bool, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		let endPoint = isEdit ? "update-single-rating" : "add-review"
		NetworkManager.callService(url: "\(API_URL)\(endPoint)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	 
	
	static func searchPlacesList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)search-places", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func checkInUsersList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)check-in-user-list-place", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func addCheckIn(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-check-in-place", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	static func hotelList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)hotel-list-by-place", parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func postReport(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)post-report", parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	static func travelPlanList( parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)travel-plan-list", parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
//	static func postTagList( parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
//		NetworkManager.callService(url: "\(API_URL)post-tags-list", parameters:parameters )  { (networkResponseState) in
//			completion(networkResponseState)
//		}
//	}
	
	
//	static func destinationTagList( parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
//		NetworkManager.callService(url: "\(API_URL)destination-tags-list", parameters:parameters )  { (networkResponseState) in
//			completion(networkResponseState)
//		}
//	}
	
	
//	static func hotelTagList( parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
//		NetworkManager.callService(url: "\(API_URL)hotel-tags-list", parameters:parameters )  { (networkResponseState) in
//			completion(networkResponseState)
//		}
//	}
	
//	static func adviseList(page: Int, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
//		NetworkManager.callService(url: "\(API_URL)list-advise?page=\(page)", parameters:parameters )  { (networkResponseState) in
//			completion(networkResponseState)
//		}
//	}
	
	static func removeAdvise( parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)delete-advise", parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func removePost( parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)delete-post", parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
//	static func placeLikeList(url:String, page: Int, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
//		NetworkManager.callService(url: "\(API_URL)\(url)?page=\(page)", parameters:parameters )  { (networkResponseState) in
//			completion(networkResponseState)
//		}
//	}
	
	static func travelerLikeList(url:String, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)\(url)")  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func checkInUserList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)check-in-user-list-travel", parameters: parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func foodList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)food-list-by-place", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func sharePost(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)share-post", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func deleteChild(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)delete-child", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func actOnInvitation(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)invitation-status", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func childDetails(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)child-detail", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func inviteFriend(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-invite", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
 
	static func syncContact(url:String, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)\(url)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func sendRequest(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)ask-invite-code", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func hideProfile(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)hide-profile", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addComment(url: String, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)\(url)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func readNotification(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)read-notification", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func commentList(url: String, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)\(url)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func likeList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)list-like", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	
	static func uploadChatFile(file: SSFiles, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)chat-file", item: file, parameters: parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	//    static func uploadChatFile(image:UIImage, completion: @escaping (Bool, Any) -> Void) {
	//        NetworkManager.callService(url: "\(API_URL)upload-chat-files/", file: nil, image: image)  { (success, response) in
	//            completion(success, response)
	//        }
	//    }
	
	
	
	
	static func updateStudentProfile(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-update-profile" , parameters:parameters, httpMethod: .post)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func deleteAssignUser(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)delete-assign" , parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addNewAssignUser(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-assign" , parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addAssignUser(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)conf-add-assign" , parameters:parameters )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
 
	//request for session by student
	static func makeRequest(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-for-session/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func getFoodPlnnerList(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)get-food-planner-list", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func userPosts(page:Int, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-post?page=\(page)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func deletePost(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)delete-post", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func userReviews(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)reviews", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func requestRating(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-review", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func requestToViewProfile(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-view-profile", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func activityList(page: Int, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)activity-list?page=\(page)" )  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func getUserProfile(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)profile-detail", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func myProfile(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)my-detail", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func fetchShairedLink(code:String, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)user-profile-share/\(code)")  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addActivity(parameters:Parameters, certificates:[SSFiles], completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceMultipalFiles(url: "\(API_URL)add-post", files: certificates , parameters:parameters){ (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func editActivity(parameters:Parameters, certificates:[SSFiles], completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callServiceMultipalFiles(url: "\(API_URL)update-post", files: certificates , parameters:parameters){ (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	 
	static func singlePost(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)single-post", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	//add new class
	static func addNewClass(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-class-request/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func makeABooking(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)new-booking/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func changePassword(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)change_password", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func acceptRequest(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-session-accept/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func rejectRequest(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-session-reject/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func deleteRequest(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)request-session-delete/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func startSession(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)booking-session-update/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func sendOtp(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)otp-send", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addTmpUser(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-temporary-users", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func checkOtp(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)otp-check", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func resetPassword(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)reset-password", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func addFoodPlanner(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-food-plan", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func editFoodPlanner(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)edit-food", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addMeal(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)save-add-meal", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func addLogbook(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-logbook", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	static func submitRating(parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)add-review/", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	
	static func searchActivityList(page: Int, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void) {
		NetworkManager.callService(url: "\(API_URL)activity-search?page=\(page)", parameters:parameters)  { (networkResponseState) in
			completion(networkResponseState)
		}
	}
	
	static func callService(url:String, parameters:Parameters, httpMethod:HTTPMethod = .post, completion:@escaping (NetworkResponseState) -> Void){
		
		var  tokenDict:HTTPHeaders = [:]
		//        if LoginUserModel.shared.isLogin {
        if  obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String != "" {
            tokenDict = ["Content-Type": "application/json","Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")" ]
		}else{
			tokenDict = ["Content-Type": "application/json" ]
		}
		        print("Bearer \(LoginUserModel.shared.token)")
		//		print("parms \(parameters)")
       
		AF.request(url, method:httpMethod, parameters:parameters, encoding: JSONEncoding.default,headers: tokenDict).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(String(describing: response.value))")                   // response serialization result
			
            if((response.value) != nil) {
                  switch response.result {
                  case .success( _):
                      
                    if response.response?.statusCode == 200 {
                       let responseJSON = response.value as? [String: Any]
                        completion(.success(responseJSON ?? [String:Any]()) )
                    }else{
                        completion(.failed("Something went wrong!!"))
                    }
                  case .failure(let error):
                      
                        completion(.failed("Something went wrong!!"))
                          print("Error while fetching json: \(String(describing: response.error))")
                          return
                  }
              } else {
                  
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.error))")
                    return
              }
           
			

		}
	}
	static func callServiceLogin(url:String, parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void){
		var  tokenDict:HTTPHeaders = [:]
		 tokenDict = ["Content-Type": "application/json", "Device-Registration": LoginUserModel.shared.fCMToken ]
		
		AF.request(url, method:.post, parameters:parameters, encoding: JSONEncoding.default, headers: tokenDict).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(String(describing: response.value))")                         // response serialization result
			
            if((response.value) != nil) {
                  switch response.result {
                  case .success( _):
                      
                    if response.response?.statusCode == 200 {
                       let responseJSON = response.value as? [String: Any]
                        completion(.success(responseJSON ?? [String:Any]()) )
                    }else{
                        completion(.failed("Something went wrong!!"))
                    }
                  case .failure(let error):
                      
                        completion(.failed("Something went wrong!!"))
                          print("Error while fetching json: \(String(describing: response.error))")
                          return
                  }
              } else {
                  
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.error))")
                    return
              }
			
			
			
		}
	}
	
	static func callServiceMultipalFiles(url:String, files:[SSFiles], parameters:Parameters, completion: @escaping (NetworkResponseState) -> Void){
		
		var  tokenDict:HTTPHeaders = [:]
		//        if LoginUserModel.shared.isLogin {
		if LoginUserModel.shared.token != "" {
			tokenDict = ["Content-Type": "application/json","Authorization": "Bearer \(LoginUserModel.shared.token)" ]
		}else{
			tokenDict = ["Content-Type": "application/json" ]
		}
		print("Bearer \(LoginUserModel.shared.token)")
		AF.upload(
			multipartFormData: { multipartFormData in
				var count = 0
				for item in files {
					if let fileUrl: URL = item.url, let thumb: UIImage = item.thumbImage {
						do {
							let data = try Data(contentsOf: fileUrl )
							multipartFormData.append(data, withName: "post_picture[\(count)]", fileName: (fileUrl.absoluteString as NSString).lastPathComponent, mimeType: "application/octet-stream")
							
							var fileName: String = (fileUrl.absoluteString as NSString).lastPathComponent
							fileName = fileName.replacingOccurrences(of: ".\(fileUrl.pathExtension)", with: ".jpg")
							multipartFormData.append(thumb.jpegData(compressionQuality: 1.0)!, withName: "video_thumbnail[\(count)]", fileName: fileName, mimeType: "image/jpg")
							
							count = count + 1
						} catch let error{
							print(error)
						}
					} else if let image = item.image, let thumb: UIImage = item.thumbImage {
						guard let imageData = image.jpegData(compressionQuality: 1.0) else {
							print("Could not get JPEG representation of UIImage")
							return
						}
						
						let fileName: String = "\(Date().timeIntervalSince1970).jpg"
						
						multipartFormData.append(imageData, withName: "post_picture[\(count)]",fileName: fileName, mimeType: "image/jpg")
						 
						multipartFormData.append(thumb.jpegData(compressionQuality: 1.0)!, withName: "video_thumbnail[\(count)]", fileName: fileName, mimeType: "image/jpg")
						
						
						count = count + 1
					} else if let oldMedia = item.oldMedia {
						multipartFormData.append((oldMedia.image_video as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: "post_picture[\(count)]")
						
						multipartFormData.append((oldMedia.thumbnail as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: "video_thumbnail[\(count)]")
						
						count = count + 1
					}
				}
				
				for (key, value) in parameters {
					multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
				}
            }, to: url, method: .post, headers: tokenDict)
            .responseJSON { (response) in
                switch response.result {
                case .success(let upload):
				
					print("Request: \(String(describing: response.request))")   // original url request
					print("Response: \(String(describing: response.response))") // http url response
					print("Result: \(String(describing: response.value))")                         // response serialization result
                    if response.response?.statusCode == 200 {
                       let responseJSON = response.value as? [String: Any]
                        completion(.success(responseJSON ?? [String:Any]()) )
                    }else{
                        completion(.failed("Something went wrong!!"))
                        print("Error while fetching json: \(String(describing: response.error))")
                        return
                    }
                   
   
            case .failure( _):
				completion(.failed("Something went wrong!!"))
			}
		}
	}
	static func callService(url:String, item: SSFiles, parameters:Parameters, completion:@escaping (NetworkResponseState) -> Void){
		
		var  tokenDict:HTTPHeaders = [:]
		//        if LoginUserModel.shared.isLogin {
		if LoginUserModel.shared.token != "" {
			tokenDict = ["Content-Type": "application/json","Authorization": "Bearer \(LoginUserModel.shared.token)" ]
		}else{
			tokenDict = ["Content-Type": "application/json" ]
		}
		AF.upload(
			multipartFormData: { multipartFormData in
					if let fileUrl: URL = item.url {
						do {
							let data = try Data(contentsOf: fileUrl )
							multipartFormData.append(data, withName: "file", fileName: (fileUrl.absoluteString as NSString).lastPathComponent, mimeType: "application/octet-stream")
							
							var fileName: String = (fileUrl.absoluteString as NSString).lastPathComponent
							fileName = fileName.replacingOccurrences(of: ".\(fileUrl.pathExtension)", with: ".jpg")
							if let thumb: UIImage = item.thumbImage {
								multipartFormData.append(thumb.jpegData(compressionQuality: 1.0)!, withName: "thumbnail", fileName: fileName, mimeType: "image/jpg")
							}
							 
						} catch let error{
							print(error)
						}
					} else if let image = item.image {
						guard let imageData = image.jpegData(compressionQuality: 1.0) else {
							print("Could not get JPEG representation of UIImage")
							return
						}
						
						let fileName: String = "\(Date().timeIntervalSince1970).jpg"
						
						multipartFormData.append(imageData, withName: "file",fileName: fileName, mimeType: "image/jpg")
						
						if let thumb: UIImage = item.thumbImage {
							multipartFormData.append(thumb.jpegData(compressionQuality: 1.0)!, withName: "thumbnail", fileName: fileName, mimeType: "image/jpg")
						}
					}
//					else if let oldMedia = item.oldMedia {
//						multipartFormData.append((oldMedia.image_video as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: "file")
//
//						multipartFormData.append((oldMedia.thumbnail as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: "thumbnail")
//
//
//					}
				 
				for (key, value) in parameters {
					multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
				}
				
		}, to: url, method: .post, headers: tokenDict)
                 .responseJSON { (response) in
                     switch response.result {
                     case .success(let upload):
                     
                         print("Request: \(String(describing: response.request))")   // original url request
                         print("Response: \(String(describing: response.response))") // http url response
                         print("Result: \(String(describing: response.value))")                         // response serialization result
                         if response.response?.statusCode == 200 {
                            let responseJSON = response.value as? [String: Any]
                             completion(.success(responseJSON ?? [String:Any]()) )
                         }else{
                             completion(.failed("Something went wrong!!"))
                             print("Error while fetching json: \(String(describing: response.error))")
                             return
                         }
                        
        
                 case .failure( _):
                     completion(.failed("Something went wrong!!"))
                 }
		}
	}
	
	static func callServiceMultipart(url:String, parameters:Parameters, file:MultipartImage? = nil, method:HTTPMethod = .post, completion:@escaping (NetworkResponseState) -> Void){
		
		let TokenDict:HTTPHeaders  = ["Content-Type": "application/json", "Authorization": "Bearer \(LoginUserModel.shared.token)" ]
		
		AF.upload(
			multipartFormData: { multipartFormData in
				
				if let item: MultipartImage = file {
					
					guard let imageData = item.image.jpegData(compressionQuality: 1.0) else {
						print("Could not get JPEG representation of UIImage")
						return
						
					}
					multipartFormData.append(imageData, withName: item.keyName, fileName: item.fileName, mimeType: "image/jpg")
				}
				
				for (key, value) in parameters {
					multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
				}
		}, to: url, method: .post, headers: TokenDict)
                 .responseJSON { (response) in
                     switch response.result {
                     case .success(let upload):
                     
                         print("Request: \(String(describing: response.request))")   // original url request
                         print("Response: \(String(describing: response.response))") // http url response
                         print("Result: \(String(describing: response.value))")                         // response serialization result
                         if response.response?.statusCode == 200 {
                            let responseJSON = response.value as? [String: Any]
                             completion(.success(responseJSON ?? [String:Any]()) )
                         }else{
                             completion(.failed("Something went wrong!!"))
                             print("Error while fetching json: \(String(describing: response.error))")
                             return
                         }
                        
        
                 case .failure( _):
                     completion(.failed("Something went wrong!!"))
                 }
		}
	}
	
    static func getState(uiRef: UIViewController,Webservice: String,completion: @escaping (JSON) -> Void) {
        
        let API_Call =   "https://classified.ezxdemo.com/api/get-countries"
        
        //             var tokenToSend:String = UserDefaults.standard.string(forKey: "token")!
        //
        //            print(tokenToSend)
        //
        //             tokenToSend = "Bearer " + tokenToSend
        //
        //
        //             TokenDict1 = ["Authorization" : tokenToSend]
        
        let parameters: Parameters = [:]
        
        print(API_Call)
        print(parameters)
        
        //  TokenDict1 = ["Authorization": tokenToSend]
        
        NetworkManager.callServiceGet(uiRef:uiRef,Webservice: API_Call, parameters:parameters)  { (JSON) in
            completion(JSON)
        }
    }
    
    
         static   func showLoader() {
               
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
                        
//                               if let bnd = self.view.window?.bounds{
//                                 viewindicator.frame = (self.view.window?.bounds)!
//                               }else{
//
//                               }
                               
                               indicator  = NVActivityIndicatorView(frame:CGRect(x: 30,y:30,width:60,height:60),type: .ballClipRotatePulse,color: App_main_clor ,padding:5)
                               indicator?.startAnimating()
                             //  img_indicator = UIImageView(frame:CGRect(x: 20,y:20,width:80,height:80))
                               //img_indicator.image = UIImage.gif(name: "loading-stivale")
                               
                             //  img_indicator.startAnimating()
                               
                               viewSmaillBack.addSubview(indicator ?? UIView())
                               viewindicator.addSubview(viewSmaillBack)
                              // self.view.window?.addSubview(viewindicator)
                       }
  
            }
    
    static func callServiceGet(uiRef: UIViewController,Webservice: String, parameters:Parameters, completion:@escaping (JSON) -> Void){
        
        
        if Reachability.isConnectedToNetwork(){
            
            var tokenDict:HTTPHeaders = [:]
            if LoginUserModel.shared.isLogin {
                tokenDict = ["Accept": "application/json", "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmJkOTk5MGM0YTI5NDA1ZDAyYzc4ZTNiNWQ2ZWVkMjQ3OGE0NTFlM2Q5ZWMxZjgxNmEyMGQ3MTVmM2U4MzMyNjY5YzJkNzNhODI1MmFlMjQiLCJpYXQiOjE2Mzc3NTg5NzMuODk0OTAyLCJuYmYiOjE2Mzc3NTg5NzMuODk0OTA1LCJleHAiOjE2NjkyOTQ5NzMuODI1NDU4LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.hU1BS4vvB6wRIbCrpk_SqqtBv0dWJ2kc6nGM088qnYPMF932p39vwUjExfGNRCp7RQFCS8IgTJ6C9Ka79sMjJ8mOgeLAtiF9JVcXJcNIP6F9Wt84PIFIOXDJGZOAws7POTY9Vle0dmesPnnVs3CzBbKmM0LM435QACVs1M_XTFIRRX7vilrmbZlxJ0yHCzzs44N9dXgt_LQTHhVbuiVmwXAk8cfmTXNunp3OpgYFZYDrq0ESjeIY9z0HiAyqYo54If7SbqbONNjNhNVaOJ0S0Z0BLMYpJUaUsJETF54qSWVjqFIVtpBUSbDI8ShMlWIJnjwab443PEtOHfhNEGqALpGsz-elyCAzy7nzeZHlzdnvV7EWQu_G6Y2OlmH1PSSqARKSW_2rL45K_-Kt7hwJ3H3EDCcD_4y2th9YF2j-Kg4z5Y9rtBVQg_qJLGgvawCGM6oV3r1FeMGtu2tjZY9b22KPVPrHl2W0fQNs9zzR0gI1jVJp5tqxxuA-BSH8tiI3je_x4dE4tRgMr6w6vTXfHlLIxO-dtBYuw1GlNnq1Thylc6DGf41YcEY6ClQCRNOrPi6ZGGtdg_UWLBeOHIyJufzhYCKtPm65TjbVAoCpZmpPytGdjUL56b-2GdtQv6LZEfsnW71RnJ4N9UNWZ9KQoihUTAGGJBrBwt9MlQvW0-c" ]
            }else{
                tokenDict = ["Accept": "application/json", "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmJkOTk5MGM0YTI5NDA1ZDAyYzc4ZTNiNWQ2ZWVkMjQ3OGE0NTFlM2Q5ZWMxZjgxNmEyMGQ3MTVmM2U4MzMyNjY5YzJkNzNhODI1MmFlMjQiLCJpYXQiOjE2Mzc3NTg5NzMuODk0OTAyLCJuYmYiOjE2Mzc3NTg5NzMuODk0OTA1LCJleHAiOjE2NjkyOTQ5NzMuODI1NDU4LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.hU1BS4vvB6wRIbCrpk_SqqtBv0dWJ2kc6nGM088qnYPMF932p39vwUjExfGNRCp7RQFCS8IgTJ6C9Ka79sMjJ8mOgeLAtiF9JVcXJcNIP6F9Wt84PIFIOXDJGZOAws7POTY9Vle0dmesPnnVs3CzBbKmM0LM435QACVs1M_XTFIRRX7vilrmbZlxJ0yHCzzs44N9dXgt_LQTHhVbuiVmwXAk8cfmTXNunp3OpgYFZYDrq0ESjeIY9z0HiAyqYo54If7SbqbONNjNhNVaOJ0S0Z0BLMYpJUaUsJETF54qSWVjqFIVtpBUSbDI8ShMlWIJnjwab443PEtOHfhNEGqALpGsz-elyCAzy7nzeZHlzdnvV7EWQu_G6Y2OlmH1PSSqARKSW_2rL45K_-Kt7hwJ3H3EDCcD_4y2th9YF2j-Kg4z5Y9rtBVQg_qJLGgvawCGM6oV3r1FeMGtu2tjZY9b22KPVPrHl2W0fQNs9zzR0gI1jVJp5tqxxuA-BSH8tiI3je_x4dE4tRgMr6w6vTXfHlLIxO-dtBYuw1GlNnq1Thylc6DGf41YcEY6ClQCRNOrPi6ZGGtdg_UWLBeOHIyJufzhYCKtPm65TjbVAoCpZmpPytGdjUL56b-2GdtQv6LZEfsnW71RnJ4N9UNWZ9KQoihUTAGGJBrBwt9MlQvW0-c" ]
            }
              
            showLoader()
          
            print(Webservice)
            AF.request("\(Webservice)", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: tokenDict).responseJSON
                {
                    response in
                switch response.result {
                           case .success(let value):
                               if let json = value as? [String: Any] {
                                print("Output: \(json)") // serialized json response
                                let sJSON = JSON(json)
                                
                                
                                if sJSON["status"].intValue == 200 {
                                    // we're OK to parse!
                                }
                                else { // Error found
                                    print("Error: ")
                                    //                    sJSON["message"].stringValue)
                                    
                                    //                    print(sJSON["message"].stringValue)
                                    
                                    //  NetworkManager.showErrorAlert(uiRef: uiRef,message:  sJSON["message"].stringValue)
                                }
                                
                                completion (sJSON)                               }
                           case .failure(let error):
                               print(error)
                           }
            }
        }
        else {
         //   showErrorAlert(uiRef: uiRef, message: "Please check your internet connection")
        }
    }
	
	static func callService(url:String, completion:@escaping (NetworkResponseState) -> Void){
		var tokenDict:HTTPHeaders = [:]
		if LoginUserModel.shared.isLogin {
			tokenDict = ["Accept": "application/json", "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmJkOTk5MGM0YTI5NDA1ZDAyYzc4ZTNiNWQ2ZWVkMjQ3OGE0NTFlM2Q5ZWMxZjgxNmEyMGQ3MTVmM2U4MzMyNjY5YzJkNzNhODI1MmFlMjQiLCJpYXQiOjE2Mzc3NTg5NzMuODk0OTAyLCJuYmYiOjE2Mzc3NTg5NzMuODk0OTA1LCJleHAiOjE2NjkyOTQ5NzMuODI1NDU4LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.hU1BS4vvB6wRIbCrpk_SqqtBv0dWJ2kc6nGM088qnYPMF932p39vwUjExfGNRCp7RQFCS8IgTJ6C9Ka79sMjJ8mOgeLAtiF9JVcXJcNIP6F9Wt84PIFIOXDJGZOAws7POTY9Vle0dmesPnnVs3CzBbKmM0LM435QACVs1M_XTFIRRX7vilrmbZlxJ0yHCzzs44N9dXgt_LQTHhVbuiVmwXAk8cfmTXNunp3OpgYFZYDrq0ESjeIY9z0HiAyqYo54If7SbqbONNjNhNVaOJ0S0Z0BLMYpJUaUsJETF54qSWVjqFIVtpBUSbDI8ShMlWIJnjwab443PEtOHfhNEGqALpGsz-elyCAzy7nzeZHlzdnvV7EWQu_G6Y2OlmH1PSSqARKSW_2rL45K_-Kt7hwJ3H3EDCcD_4y2th9YF2j-Kg4z5Y9rtBVQg_qJLGgvawCGM6oV3r1FeMGtu2tjZY9b22KPVPrHl2W0fQNs9zzR0gI1jVJp5tqxxuA-BSH8tiI3je_x4dE4tRgMr6w6vTXfHlLIxO-dtBYuw1GlNnq1Thylc6DGf41YcEY6ClQCRNOrPi6ZGGtdg_UWLBeOHIyJufzhYCKtPm65TjbVAoCpZmpPytGdjUL56b-2GdtQv6LZEfsnW71RnJ4N9UNWZ9KQoihUTAGGJBrBwt9MlQvW0-c" ]
		}else{
			tokenDict = ["Accept": "application/json", "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmJkOTk5MGM0YTI5NDA1ZDAyYzc4ZTNiNWQ2ZWVkMjQ3OGE0NTFlM2Q5ZWMxZjgxNmEyMGQ3MTVmM2U4MzMyNjY5YzJkNzNhODI1MmFlMjQiLCJpYXQiOjE2Mzc3NTg5NzMuODk0OTAyLCJuYmYiOjE2Mzc3NTg5NzMuODk0OTA1LCJleHAiOjE2NjkyOTQ5NzMuODI1NDU4LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.hU1BS4vvB6wRIbCrpk_SqqtBv0dWJ2kc6nGM088qnYPMF932p39vwUjExfGNRCp7RQFCS8IgTJ6C9Ka79sMjJ8mOgeLAtiF9JVcXJcNIP6F9Wt84PIFIOXDJGZOAws7POTY9Vle0dmesPnnVs3CzBbKmM0LM435QACVs1M_XTFIRRX7vilrmbZlxJ0yHCzzs44N9dXgt_LQTHhVbuiVmwXAk8cfmTXNunp3OpgYFZYDrq0ESjeIY9z0HiAyqYo54If7SbqbONNjNhNVaOJ0S0Z0BLMYpJUaUsJETF54qSWVjqFIVtpBUSbDI8ShMlWIJnjwab443PEtOHfhNEGqALpGsz-elyCAzy7nzeZHlzdnvV7EWQu_G6Y2OlmH1PSSqARKSW_2rL45K_-Kt7hwJ3H3EDCcD_4y2th9YF2j-Kg4z5Y9rtBVQg_qJLGgvawCGM6oV3r1FeMGtu2tjZY9b22KPVPrHl2W0fQNs9zzR0gI1jVJp5tqxxuA-BSH8tiI3je_x4dE4tRgMr6w6vTXfHlLIxO-dtBYuw1GlNnq1Thylc6DGf41YcEY6ClQCRNOrPi6ZGGtdg_UWLBeOHIyJufzhYCKtPm65TjbVAoCpZmpPytGdjUL56b-2GdtQv6LZEfsnW71RnJ4N9UNWZ9KQoihUTAGGJBrBwt9MlQvW0-c" ]
		}
       
		AF.request(url, method:.get, headers:tokenDict).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(String(describing: response.value))")                   // response serialization result
            if((response.value) != nil) {
                  switch response.result {
                  case .success( _):
                      
                    if response.response?.statusCode == 200 {
                       let responseJSON = response.value as? [String: Any]
                        completion(.success(responseJSON ?? [String:Any]()) )
                    }else if response.response?.statusCode == 401 {
                        LoginUserModel.shared.logout()
                        
                       
                    }else{
                        completion(.failed("Something went wrong!!"))
                    }
                  case .failure(let error):
                      
                        completion(.failed("Something went wrong!!"))
                          print("Error while fetching json: \(String(describing: response.error))")
                          return
                  }
              } else {
                  
                    completion(.failed("Something went wrong!!"))
                    print("invalid json recieved from server: \(String(describing: response.error))")
                    return
              }
			
			
			
			
		}
	}
}
enum NetworkResponseState {
	case success([String:Any])
	case failed(String)
}
