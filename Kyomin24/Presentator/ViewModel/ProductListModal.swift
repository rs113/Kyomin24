//
//  ProductListModal.swift
//  Mzadi
//
//  Created by Emizen tech on 17/08/21.
//

import Foundation


// MARK: - Welcome
struct ProductListModal: Codable {
    let statusCode: Int
    let message: String
    var data: DataClass

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var productList: [ProductList]
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
struct ProductList: Codable {
    let id, title, price: String
    let gallery: [Gallery]
    let totalComment: String
    let langReturn: [String]
    let featured,totalview,isFavourite: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, gallery
        case totalComment = "total_comment"
        case totalview = "total_view"
        case langReturn, featured, isFavourite 
    }
}

// MARK: - Gallery
struct Gallery: Codable {
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
