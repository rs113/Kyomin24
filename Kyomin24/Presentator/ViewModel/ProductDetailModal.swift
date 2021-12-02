//
//  ProductDetailModal.swift
//  Mzadi
//
//  Created by Emizen tech on 20/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProductDetailModal: Codable {
    let statusCode: Int?
    let message: String?
    let data: ProductData?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct ProductData: Codable {
    let id: String?
    let photo: [Photo]?
    let title, price, postDate, totalView: String?
    let totalFav, isFavourite: String?
    let sellerProfile: SellerProfile?
    let productDetails: [ProductDetails]?
    let dataDescription: String?
    let filter: [Filter]?
    let location: Location?
    let comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case postDate = "post_date"
        case totalView = "total_view"
        case totalFav = "total_fav"
        case isFavourite
        case sellerProfile = "seller_profile"
        case productDetails = "product_detail"
        case dataDescription = "description"
        case photo = "gallery"
        case filter, location, comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, userName, userID: String?
    let userProfile: String?
    let createdAt, comment: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case userID = "user_id"
        case userProfile = "user_profile"
        case createdAt = "created_at"
        case comment
    }
}

// MARK: - Filter
struct Filter: Codable {
    let id, title: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}

// MARK: - Gallery
struct Photo: Codable {
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

// MARK: - Location
struct Location: Codable {
    let location: String?
    let lat: String?
    let long: String?
}

// MARK: - ProductDetail
struct ProductDetails: Codable {
    let title: String?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case value = "value"
    }
}

// MARK: - SellerProfile
struct SellerProfile: Codable {
    let id, name: String?
    let profile: String?
    let mobile, totalFollowers, isFollow: String?

    enum CodingKeys: String, CodingKey {
        case id, name, profile, mobile
        case totalFollowers = "total_followers"
        case isFollow
    }
}
