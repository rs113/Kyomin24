//
//  LikeUnlikeModal.swift
//  Mzadi
//
//  Created by Emizentech on 16/09/21.
//

import Foundation

// MARK: - Welcome
struct LikeUnlikeModal: Codable {
    let statusCode: Int
    let message: String
    let data: LikeUnlike

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct LikeUnlike: Codable {
    let postID: String
    let userID: Int
    let updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case userID = "user_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

