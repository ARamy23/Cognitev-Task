//
//  ExploreResponse.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation

// MARK: - ExploreResponse
struct ExploreResponse: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let suggestedFilters: SuggestedFilters?
    let suggestedRadius: Int?
    let headerLocation, headerFullLocation, headerLocationGranularity, query: String?
    let totalResults: Int?
    let suggestedBounds: SuggestedBounds?
    let groups: [Group]?
}

// MARK: - Group
struct Group: Codable {
    let type, name: String?
    let items: [GroupItem]?
}

// MARK: - GroupItem
struct GroupItem: Codable {
    let reasons: Reasons?
    let venue: Venue?
    let referralID: String?
    let flags: Flags?

    enum CodingKeys: String, CodingKey {
        case reasons, venue
        case referralID = "referralId"
        case flags
    }
}

// MARK: - Flags
struct Flags: Codable {
    let outsideRadius: Bool?
}

// MARK: - Reasons
struct Reasons: Codable {
    let count: Int?
    let items: [ReasonsItem]?
}

// MARK: - ReasonsItem
struct ReasonsItem: Codable {
    let summary: String?
    let type: String?
    let reasonName: String?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
    let photos: Photos?
}

// MARK: - Category
struct Category: Codable {
    let id: String?
    let name: String?
    let pluralName: String?
    let shortName: String?
    let icon: Icon?
    let primary: Bool?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode: String?
    let cc: String?
    let city, country: String?
    let formattedAddress: [String]?
    let neighborhood: String?
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int?
}

// MARK: - SuggestedBounds
struct SuggestedBounds: Codable {
    let ne, sw: Ne?
}

// MARK: - Ne
struct Ne: Codable {
    let lat, lng: Double?
}

// MARK: - SuggestedFilters
struct SuggestedFilters: Codable {
    let header: String?
    let filters: [Filter]?
}

// MARK: - Filter
struct Filter: Codable {
    let name, key: String?
}
