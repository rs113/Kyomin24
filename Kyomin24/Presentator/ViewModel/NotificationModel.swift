//
//  NotificationModel.swift
//  Mzadi
//
//  Created by Emizentech on 22/09/21.
//

import Foundation

// MARK: - Welcome
struct NotificationModel: Codable {
    let statusCode: Int
    let message: String
    let data: [NotificationData]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct NotificationData: Codable {
    let id: String
    let title: String
    let datumDescription, datumFor, forID, status: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case datumFor = "for"
        case forID = "for_id"
        case status
        case createdAt = "created_at"
    }
}

//enum Title: String, Codable {
//    case adPublished = "Ad published"
//    case adRejected = "Ad rejected."
//    case bUditKhandelwalBCommentedOnYourBGregfbfjbskjfbjB = "<b>udit Khandelwal</b> commented on your <b>Gregfbfjbskjfbj</b>"
//}

