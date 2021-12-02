//
//  LeftMenuSubCategoryModel.swift
//  Mzadi
//
//  Created by Emizentech on 16/08/21.
//

import Foundation

// MARK: - SubcategoryCategoryModel
struct  LeftMenuCategoryModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [DatumLeft]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct DatumLeft: Codable {
    let id, title: String?
}

