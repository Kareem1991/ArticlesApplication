//
//  ArticlesModule.swift
//  ArticlesApp
//
//  Created by Kareem on 29/06/2025.
//

import SwiftUI

struct ArticlesModule {
    static func build() -> ArticlesView {

        let router = ArticlesRouter()
        
        let interactor = ArticlesInteractor(networkClient: NetworkClient())
        
        let dummyPresenter = DummyPresenter()
        let tempViewModel = ArticlesViewModel(presenter: dummyPresenter)
        
        let presenter = ArticlesPresenter(
            viewModel: tempViewModel,
            interactor: interactor,
            router: router
        )
        
        let finalViewModel = ArticlesViewModel(presenter: presenter)
        
        presenter.viewModel = finalViewModel
        
        interactor.presenter = presenter
        
        return ArticlesView(viewModel: finalViewModel, router: router)
    }
}

private class DummyPresenter: ArticlesPresenterProtocol {
    func viewDidLoad() {}
    func refreshArticles() {}
    func didSelectArticle(_ article: Article) {}
}
