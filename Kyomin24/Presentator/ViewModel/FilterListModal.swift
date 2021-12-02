//
//  FilterListModal.swift
//  Mzadi
//
//  Created by Emizen tech on 17/08/21.
//


import Foundation

// MARK: - Welcome
struct SlideListModal: Codable {
    let statusCode: Int
    let message: String
    var data: [WelcomeDatum]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - WelcomeDatum
struct WelcomeDatum: Codable {
    let fieldType, fieldName, fieldPlaceholder, fieldLabel: String
    var selectedtext = ""
    var selectedid=0
    let validation: String
    var dataItams: [FieldData]?

    enum CodingKeys: String, CodingKey {
        case fieldType = "field_type"
        case fieldName = "field_name"
        case fieldPlaceholder = "field_placeholder"
        case fieldLabel = "field_label"
        case validation
        case dataItams = "data"
    }
}

// MARK: - DatumDatum
struct FieldData: Codable {
    let id: Int
    let title: String
    var Selectedid:Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}


