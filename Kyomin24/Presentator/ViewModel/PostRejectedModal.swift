//
//  PostRejectedModal.swift
//  Mzadi
//
//  Created by Emizentech on 15/09/21.
//

import Foundation

// MARK: - Welcome
struct PostRejectedModal: Codable {
    let statusCode: Int
    let message: String
    let data: [PostRejected]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct PostRejected: Codable {
    let name: String
}

