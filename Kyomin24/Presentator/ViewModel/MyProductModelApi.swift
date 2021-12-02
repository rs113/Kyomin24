//
//  MyProductModelApi.swift
//  Mzadi
//
//  Created by Emizentech on 26/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MyProductModalApi: Codable {
    let statusCode: Int
    let message: String
    let data: Myproductdata

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct Myproductdata: Codable {
    let productList: [ProductListData]
    let currentPage, lastPage, perPage, total: String

    enum CodingKeys: String, CodingKey {
        case productList = "product_list"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}

// MARK: - ProductList
struct ProductListData: Codable {
    let id, title, price: String
    let gallery: [GalleryData]
    let totalComment, totalView, status,repostdate, featured: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, gallery
        case totalComment = "total_comment"
        case totalView = "total_view"
        case repostdate = "repost_date"
        case status, featured
    }
}

// MARK: - Gallery
struct GalleryData: Codable {
    let id, productID: String
    let url: String
    let fileType, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case url
        case fileType = "file_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

