//
//  FollowModal.swift
//  Mzadi
//
//  Created by Emizentech on 15/09/21.
//

import Foundation

// MARK: - Welcome
struct FollowModal: Codable {
    let statusCode: Int
    let message: String
    let data: FollowData

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct FollowData: Codable {
    let followedID: Int
    let followingID, updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case followedID = "followed_id"
        case followingID = "following_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

