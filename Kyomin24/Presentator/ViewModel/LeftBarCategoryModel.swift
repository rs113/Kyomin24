//
//  LeftBarCategoryModel.swift
//  Mzadi
//
//  Created by Emizentech on 10/08/21.
//

import Foundation

// MARK: - LeftBarCategoryModel
struct LeftBarCategoryModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [Leftcategoryclass]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Leftcategoryclass: Codable {
    let id, title: String?
}
