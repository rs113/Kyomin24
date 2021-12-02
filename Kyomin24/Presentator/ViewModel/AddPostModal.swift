//
//  AddPostModal.swift
//  Mzadi
//
//  Created by Emizentech on 29/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AddPostModal: Codable {
    let statusCode: Int
    let message: String
    let data: AddPostClass

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct AddPostClass: Codable {
    let productID: Int

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
    }
}

