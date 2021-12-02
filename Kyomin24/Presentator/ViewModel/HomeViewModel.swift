//
//  HomeViewModel.swift
//  Mzadi
//
//  Created by Emizentech on 10/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leftBarCategoryModel = try? newJSONDecoder().decode(LeftBarCategoryModel.self, from: jsonData)

import Foundation

// MARK: - LeftBarCategoryModel
struct HomeBarCategoryModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: HomeBarCategoryModelData?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - LeftBarCategoryModelData
struct HomeBarCategoryModelData: Codable {
    let bodyData: [BodyDatum]?
    let lastAdd: [AdBanner]?

    enum CodingKeys: String, CodingKey {
        case bodyData = "body_data"
        case lastAdd = "last_add"
    }
}

// MARK: - BodyDatum
struct BodyDatum: Codable {
    let id, name, totalProduct: String?
    let icon: String?
    let adBanner: [AdBanner]?
    let subCat: [SubCat]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case totalProduct = "total_product"
        case icon
        case adBanner = "ad_banner"
        case subCat = "sub_cat"
    }
}

// MARK: - AdBanner
struct AdBanner: Codable {
    let id, categoryID: String?
    let banner: String?
    let url: AdBannerURL?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case banner, url
    }
}

// MARK: - AdBannerURL
struct AdBannerURL: Codable {
    let urlType, interType: String?
    let url: String?
    let data: PurpleData?

    enum CodingKeys: String, CodingKey {
        case urlType = "url_type"
        case interType = "inter_type"
        case url, data
    }
}

// MARK: - PurpleData
struct PurpleData: Codable {
    let id: String?
}

// MARK: - SubCat
struct SubCat: Codable {
    let id, name, parentID: String?
    let image: String?
    let typeCount: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case parentID = "parent_id"
        case image
        case typeCount = "type_count"
    }
}

// MARK: - LastAdd
struct LastAdd: Codable {
    let id, categoryID: String?
    let banner: String?
    let url: LastAddURL?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case banner, url
    }
}

// MARK: - LastAddURL
struct LastAddURL: Codable {
    let urlType, interType: String?
    let url: String?
    let data: FluffyData?

    enum CodingKeys: String, CodingKey {
        case urlType = "url_type"
        case interType = "inter_type"
        case url, data
    }
}

// MARK: - FluffyData
struct FluffyData: Codable {
}

