//
//  SubproductTypeModel.swift
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
struct SubProductTypeModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: ProductTypeClass?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct ProductTypeClass: Codable {
    let category, subCategory: CategoryProduct?
    let productType: [ProductType]?

    enum CodingKeys: String, CodingKey {
        case category
        case subCategory = "sub_category"
        case productType = "product_type"
    }
}

// MARK: - Category
struct CategoryProduct: Codable {
    let id, name: String?
}

// MARK: - ProductType
struct ProductType: Codable {
    let id, title: String?
    let url: String?
}

