//
//  PurchasePlanModel.swift
//  Mzadi
//
//  Created by Emizentech on 21/10/21.
//

import Foundation

// MARK: - Welcome
struct PurchasePlanModal: Codable {
    let statusCode: Int
    let message: String
    let data: [PurchaseData]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct PurchaseData: Codable {
    let id, title, intervel, price: String
}
