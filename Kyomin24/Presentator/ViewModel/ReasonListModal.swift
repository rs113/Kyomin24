//
//  ReasonListModal.swift
//  Mzadi
//
//  Created by Emizentech on 06/09/21.
//

import Foundation

// MARK: - Welcome
struct ReasonListModal: Codable {
    let statusCode: Int
    let message: String
    let data: [ReasonList]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct ReasonList: Codable {
    let id, title: String
}

