//
//  GetProfileModel.swift
//  Mzadi
//
//  Created by Emizentech on 05/08/21.
//

import Foundation

// MARK: - GetProfileModel
struct GetProfileModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: ProfileClass?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct ProfileClass: Codable {
    let id: Int?
    let name, email, phoneNo: String?
    let profileImage: String?
    let status, createdAt, updatedAt, address: String?
    let about, appLang: String?
    let role: [Role]?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case phoneNo = "phone_no"
        case profileImage = "profile_image"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address, about
        case appLang = "app_lang"
        case role
    }
}

// MARK: - Role
struct Role: Codable {
    let id, name, guardName, createdAt: String?
    let updatedAt: String?
    let pivot: Pivot?

    enum CodingKeys: String, CodingKey {
        case id, name
        case guardName = "guard_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
    }
}

// MARK: - Pivot
struct Pivot: Codable {
    let modelID, roleID, modelType: String?

    enum CodingKeys: String, CodingKey {
        case modelID = "model_id"
        case roleID = "role_id"
        case modelType = "model_type"
    }
}

