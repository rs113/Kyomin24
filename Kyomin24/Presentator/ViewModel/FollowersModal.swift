//
//  FollowersModal.swift
//  Mzadi
//
//  Created by Emizen tech on 31/08/21.
//

import Foundation
struct FollowersModal: Codable {
    let statusCode: Int?
    let message: String?
    let data: [FollowersData]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct FollowersData: Codable {
    let followedID, name, address: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case followedID = "followed_id"
        case name, address, image
    }
}
