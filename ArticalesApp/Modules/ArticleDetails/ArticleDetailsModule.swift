//
//  ArticleDetailsModule.swift
//  ArticlesApp
//
//  Created by Kareem on 29/06/2025.
//

import SwiftUI

struct ArticleDetailsModule {
    static func build(with article: Article) -> ArticleDetailsView {
        let router = ArticleDetailsRouter()
        _ = ArticleDetailsInteractor()
        _ = ArticleDetailsPresenter()
        let viewModel = ArticleDetailsViewModel()
        
        return ArticleDetailsView(viewModel: viewModel, router: router, article: article)
    }
}
