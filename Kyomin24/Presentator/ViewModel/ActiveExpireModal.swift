//
//  ActiveExpireModal.swift
//  Mzadi
//
//  Created by Emizentech on 27/10/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ActiveExpireModal: Codable {
    let statusCode: Int
    let message: String
    let data: ActiveData

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct ActiveData: Codable {
    let active, expired: [Active]
    let remaningVip: String

    enum CodingKeys: String, CodingKey {
        case active, expired
        case remaningVip = "remaning_vip"
    }
}

// MARK: - Active
struct Active: Codable {
let id, planCost, planTag, transactionID: String
let endsAt, status, createdAt: String

enum CodingKeys: String, CodingKey {
    case id
    case planCost = "plan_cost"
    case planTag = "plan_tag"
    case transactionID = "transaction_id"
    case endsAt = "ends_at"
    case status
    case createdAt = "created_at"
  }

}





