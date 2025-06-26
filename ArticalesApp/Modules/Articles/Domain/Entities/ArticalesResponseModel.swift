//
//  ArticalesResponseModel.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation


struct ArticalesResponseModel: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}

struct Article: Codable, Identifiable, Equatable {
    let uri: String
    let url: String
    let id: Int
    let assetId: Int
    let source: String
    let publishedDate: String
    let updated: String
    let section: String
    let subsection: String?
    let nytdsection: String
    let adxKeywords: String?
    let column: String?
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let media: [Media]
    let etaId: Int
    
    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetId = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case adxKeywords = "adx_keywords"
        case column
        case byline
        case type
        case title
        case abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaId = "eta_id"
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: publishedDate) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return publishedDate
    }
    
    var thumbnailURL: String? {
        return media.first?.mediaMetadata.first?.url
    }
    
    var imageURL: URL? {
        guard let urlString = thumbnailURL else { return nil }
        return URL(string: urlString)
    }
    
    var formattedByline: String {
        return byline.isEmpty ? "By New York Times" : byline
    }
}

struct Media: Codable, Equatable {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable, Equatable {
    let url: String
    let format: String
    let height: Int
    let width: Int
}

