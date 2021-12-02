//
//  GetSubcategoryModel.swift
//  Mzadi
//
//  Created by Emizentech on 10/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subcategoryCategoryModel = try? newJSONDecoder().decode(SubcategoryCategoryModel.self, from: jsonData)

import Foundation

// MARK: - SubcategoryCategoryModel
struct SubcategoryCategoryModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: SubcategoryCategoryModelData?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - SubcategoryCategoryModelData
struct SubcategoryCategoryModelData: Codable {
    let banner: [Banner]?
    let category: Category?
    let subCategory: [SubCategory]?

    enum CodingKeys: String, CodingKey {
        case banner, category
        case subCategory = "sub_category"
    }
}

// MARK: - Banner
struct Banner: Codable {
    let id: String?
    let banner: String?
    let url: URLClass?
}

// MARK: - URLClass
struct URLClass: Codable {
    let urlType, interType: String?
    let url: String?
    let data: URLData?

    enum CodingKeys: String, CodingKey {
        case urlType = "url_type"
        case interType = "inter_type"
        case url, data
    }
}

// MARK: - URLData
struct URLData: Codable {
    let id: String?
}

// MARK: - Category
struct Category: Codable {
    let name, total: String?
}

// MARK: - SubCategory
struct SubCategory: Codable {
    let id, title: String?
    let url: String?
    let typeCount: String?

    enum CodingKeys: String, CodingKey {
        case id, title, url
        case typeCount = "type_count"
    }
}

