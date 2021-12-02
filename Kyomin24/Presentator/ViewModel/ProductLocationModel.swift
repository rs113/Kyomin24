//
//  ProductLocationModel.swift
//  Mzadi
//
//  Created by Emizentech on 13/09/21.
//

import Foundation

// MARK: - Welcome
struct ProductLocationModal: Codable {
    let statusCode: Int
    let message: String
    let data: [ProductLocation]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct ProductLocation: Codable {
    let id, title, lat, long: String
}

