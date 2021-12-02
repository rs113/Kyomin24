//
//  GetCategoryListModel.swift
//  Mzadi
//
//  Created by Emizentech on 11/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subcategoryCategoryModel = try? newJSONDecoder().decode(SubcategoryCategoryModel.self, from: jsonData)

import Foundation

// MARK: - SubcategoryCategoryModel

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subcategoryCategoryModel = try? newJSONDecoder().decode(SubcategoryCategoryModel.self, from: jsonData)

import Foundation

// MARK: - SubcategoryCategoryModel
struct GetCategoryListModel: Codable {
    let statusCode: Int?
    let message: String?
    var data: [Datumcategory]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Datumcategory: Codable {
    let id, parentID, title: String?
    let subcategory: [Subcategory]?

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case title, subcategory
    }
}

struct Subcategory: Codable {
    let id, parentID, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case title
    }
}


