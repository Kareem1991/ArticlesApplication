//
//  ArticlesRouter.swift
//  ArticlesApp
//
//  Created by Kareem on 26/06/2025.
//

import SwiftUI

protocol ArticlesRouterProtocol: AnyObject {
    func navigateToArticleDetail(_ article: Article) -> ArticleDetailsView
}

final class ArticlesRouter: ArticlesRouterProtocol {
    func navigateToArticleDetail(_ article: Article) -> ArticleDetailsView {
        return ArticleDetailsConfigurator.configureModule(with: article)
    }
}
