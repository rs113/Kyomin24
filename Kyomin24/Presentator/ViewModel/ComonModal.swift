//
//  ComonModal.swift
//  Mzadi
//
//  Created by Emizen tech on 24/08/21.
//

import Foundation

// MARK: - Welcome
struct CommonModal: Codable {
    let statusCode: Int?
    let message: String?
    let data: DataItems?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct DataItems: Codable {
}


