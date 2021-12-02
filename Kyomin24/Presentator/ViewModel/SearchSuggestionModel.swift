//
//  SearchSuggestionModel.swift
//  Mzadi
//
//  Created by Emizentech on 20/08/21.
//

import Foundation

// MARK: - Welcome
struct SearchSuggestionModal: Codable {
    let statusCode: Int
    let message: String
    let data: [DataSearch]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct DataSearch: Codable {
    let id, title: String
    let type: TypeEnum
    let mainCategory: MainCategoryData

    enum CodingKeys: String, CodingKey {
        case id, title, type
        case mainCategory = "main_category"
    }
}

// MARK: - MainCategory
struct MainCategoryData: Codable {
    let id, title: String
    let subCategory: SubCategoryData

    enum CodingKeys: String, CodingKey {
        case id, title
        case subCategory = "sub_category"
    }
}

// MARK: - SubCategory
struct SubCategoryData: Codable {
    let id, title: String
}

enum TypeEnum: String, Codable {
    case cat = "cat"
    case pro = "pro"
}

