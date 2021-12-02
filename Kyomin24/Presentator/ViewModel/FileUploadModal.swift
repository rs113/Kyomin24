//
//  FileUploadModal.swift
//  Mzadi
//
//  Created by Emizentech on 28/08/21.
//

import Foundation

// MARK: - Welcome
struct FileUploadModal: Codable {
    let statusCode: Int
    let message: String
    let data: FileData

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct FileData: Codable {
    let productID: Int
    let url: String
    let fileType: Int
    let updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case url
        case fileType = "file_type"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

