//
//  EditDetailModal.swift
//  Mzadi
//
//  Created by Emizen tech on 08/09/21.
//

import Foundation

// MARK: - Welcome
struct EditDetailModal: Codable {
    let statusCode: Int?
    let message: String?
    let data: EditData?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct EditData: Codable {
    let id, userID, price, enTitle: String?
    let enDescription, arTitle, arDescription, kuTitle: String?
    let kuDescription, location, lat, long: String?
    let city, adType, proType, proModel: String?
    let proCondition, proGuaranty, proKM, proQuality: String?
    let proGear, proSim, proCapacity, proCamera: String?
    let proNoRoom, proFurnishing, proArea, proGender: String?
    let proUnite, proMaterial, totalView, status: String?
    let createdAt, updatedAt: String?
    let getGallery: [GetGallery]?
    let getCategory: [GetCategory]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case price
        case enTitle = "en_title"
        case enDescription = "en_description"
        case arTitle = "ar_title"
        case arDescription = "ar_description"
        case kuTitle = "ku_title"
        case kuDescription = "ku_description"
        case location, lat, long, city
        case adType = "ad_type"
        case proType = "pro_type"
        case proModel = "pro_model"
        case proCondition = "pro_condition"
        case proGuaranty = "pro_guaranty"
        case proKM = "pro_km"
        case proQuality = "pro_quality"
        case proGear = "pro_gear"
        case proSim = "pro_sim"
        case proCapacity = "pro_capacity"
        case proCamera = "pro_camera"
        case proNoRoom = "pro_no_room"
        case proFurnishing = "pro_furnishing"
        case proArea = "pro_area"
        case proGender = "pro_gender"
        case proUnite = "pro_unite"
        case proMaterial = "pro_material"
        case totalView = "total_view"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case getGallery = "get_gallery"
        case getCategory = "get_category"
    }
}

// MARK: - GetCategory
struct GetCategory: Codable {
    let id, productID, categoryID, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case categoryID = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - GetGallery
struct GetGallery: Codable {
    
    let id, productID: String?
    let url: String?
    let fileType, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case url
        case fileType = "file_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
