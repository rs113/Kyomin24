//
//  FavPostModal.swift
//  Mzadi
//
//  Created by Emizen tech on 31/08/21.
//

import Foundation

// MARK: - Welcome
struct FavPostModal: Codable {
    let statusCode: Int?
    let message: String?
    let data: [FavData]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case statusCode = "status_code"
        case message
    }
}

// MARK: - Datum
struct FavData: Codable {
    let id, title, price: String?
    let gallery: [FavDataPhoto]?
    let totalComment: String?
    let langReturn: [String]?
    let totalView, isFavourite, featured: String?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case gallery = "gallery"
        case totalComment = "total_comment"
        case langReturn
        case totalView = "total_view"
        case isFavourite, featured
    }
}

// MARK: - Gallery
struct FavDataPhoto: Codable {
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
