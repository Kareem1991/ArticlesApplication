//
//  TestHelpers.swift
//  ArticlesAppTests
//
//  Created by Kareem on 29/06/2025.
//

import Foundation
@testable import ArticalesApp

// MARK: - Article Mock Factory
extension Article {
    static func createMock(
        id: Int = 1,
        title: String = "Mock Article",
        abstract: String = "Mock Abstract",
        byline: String = "By Mock Author",
        publishedDate: String = "2025-06-29",
        section: String = "Technology",
        url: String = "https://example.com"
    ) -> Article {
        return Article(
            uri: "mock-uri-\(id)",
            url: url,
            id: id,
            assetId: id,
            source: "The New York Times",
            publishedDate: publishedDate,
            updated: publishedDate,
            section: section,
            subsection: nil,
            nytdsection: section,
            adxKeywords: nil,
            column: nil,
            byline: byline,
            type: "Article",
            title: title,
            abstract: abstract,
            desFacet: nil,
            orgFacet: nil,
            perFacet: nil,
            geoFacet: nil,
            media: [
                Media(
                    type: "image",
                    subtype: "photo",
                    caption: "Mock caption",
                    copyright: "Mock copyright",
                    approvedForSyndication: 1,
                    mediaMetadata: [
                        MediaMetadata(
                            url: "https://example.com/image.jpg",
                            format: "mediumThreeByTwo210",
                            height: 140,
                            width: 210
                        )
                    ]
                )
            ],
            etaId: 0
        )
    }
}
