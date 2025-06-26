//
//  ArticleDetailsConfigurator.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//
import SwiftUI
/// Defines the router functionalities
final class ArticleDetailsConfigurator {
	
    static func configureModule(with article: Article) -> ArticleDetailsView {
        let remoteRepo = ArticleDetailsRemoteRepository()
        let localRepo = ArticleDetailsLocalRepository()
        let articleDetailsUseCase = ArticleDetailsUseCase(remoteArticleDetailsRepo: remoteRepo, localArticleDetailsRepo: localRepo)
        let viewModel = ArticleDetailsViewModel(articaleDetailsUseCase: articleDetailsUseCase)
        let view = ArticleDetailsView(viewModel: viewModel, article: article)
        return view
    }
}
