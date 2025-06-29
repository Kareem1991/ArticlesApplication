//
//  ArticleDetailsConfigurator.swift
//  ArticalesApp
//
//  Created by Kareem on 29/06/2025.
//


import SwiftUI

final class ArticleDetailsConfigurator {
    static func configureModule(with article: Article) -> ArticleDetailsView {
        return ArticleDetailsModule.build(with: article)
    }
}
