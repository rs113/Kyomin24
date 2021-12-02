//
//  SellerProfileModal.swift
//  Mzadi
//
//  Created by Emizen tech on 31/08/21.
//

import Foundation

// MARK: - Welcome
struct SellerModal: Codable {
    let statusCode: Int?
    let message: String?
    let data: SellerData?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct SellerData: Codable {
    let id, name, mobile, email: String?
    let prifileImage: String?
    let location, about, role, totalPost: String?
    let followers, following: String?
    let product: [SellerProduct]?

    enum CodingKeys: String, CodingKey {
        case id, name, mobile, email
        case prifileImage = "prifile_image"
        case location, about, role
        case totalPost = "total_post"
        case product = "product"
        case followers, following
    }
}

// MARK: - Product
struct SellerProduct: Codable {
    let id, title, price: String?
    let gallery: [SellerPhoto]?
    let totalComment, totalView, featured: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case price = "price"
        case title = "title"
        case totalComment = "total_comment"
        case totalView = "total_view"
        case featured
        case gallery = "gallery"
    }
}

// MARK: - Gallery
struct SellerPhoto: Codable {
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
