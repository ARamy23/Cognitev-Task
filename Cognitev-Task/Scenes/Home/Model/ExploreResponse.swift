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
    var meta: Meta?
    var response: Response?
    
    init() { }
}

// MARK: - Meta
struct Meta: Codable {
    var code: Int?
    var requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    var suggestedFilters: SuggestedFilters?
    var suggestedRadius: Int?
    var headerLocation, headerFullLocation, headerLocationGranularity, query: String?
    var totalResults: Int?
    var suggestedBounds: SuggestedBounds?
    var groups: [Group]?
    
    init() { }
}

// MARK: - Group
struct Group: Codable {
    var type, name: String?
    var items: [GroupItem]?
    
    init() { }
}

// MARK: - GroupItem
struct GroupItem: Codable, Equatable {
    var reasons: Reasons?
    var venue: Venue?
    var referralID: String?
    var flags: Flags?
    
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case reasons, venue
        case referralID = "referralId"
        case flags
    }
    
    static func == (lhs: GroupItem, rhs: GroupItem) -> Bool {
        return lhs.referralID == rhs.referralID
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
    var id, name: String?
    var location: Location?
    var categories: [Category]?
    var photos: Photos?
    
    init() { }
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
