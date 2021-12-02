//
//  MyAdsListModal.swift
//  Mzadi
//
//  Created by Emizen tech on 20/08/21.
//

import Foundation

// MARK: - Welcome
struct MyAddsModalApi: Codable {
    let statusCode: Int?
    let message: String?
    var data: DataProduct?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct DataProduct: Codable {
    var adsList: [AddList]?
    let currentPage, lastPage, perPage, total: String?

    enum CodingKeys: String, CodingKey {
        case adsList = "product_list"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}

// MARK: - ProductList
struct AddList: Codable {
    let id, title, price: String?
    let items: [Item]?
    let totalComment, totalView, status,repostdate,featured: String?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case totalComment = "total_comment"
        case totalView = "total_view"
        case status, featured
        case repostdate = "repost_date"
        case items = "gallery"
    }
}

// MARK: - Gallery
struct Item: Codable {
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
