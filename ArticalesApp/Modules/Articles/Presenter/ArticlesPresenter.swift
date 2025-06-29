//
//  ArticlesPresenter.swift
//  ArticalesApp
//
//  Created by Kareem on 29/06/2025.
//

import Foundation

protocol ArticlesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func refreshArticles()
    func didSelectArticle(_ article: Article)
}

 class ArticlesPresenter: ArticlesPresenterProtocol {
    weak var viewModel: ArticlesViewModel?
    var interactor: ArticlesInteractorProtocol?
    var router: ArticlesRouterProtocol?
    
    init() {}
    
    init(viewModel: ArticlesViewModel, interactor: ArticlesInteractorProtocol, router: ArticlesRouterProtocol) {
        self.viewModel = viewModel
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        viewModel?.showLoading()
        interactor?.fetchArticles()
    }
    
    func refreshArticles() {
        viewModel?.showLoading()
        interactor?.fetchArticles()
    }
    
    func didSelectArticle(_ article: Article) {
        print("👆 Presenter: didSelectArticle called for: \(article.title)")
        // Navigation handled by SwiftUI NavigationLink
    }
}

// MARK: - Interactor to Presenter Communication
extension ArticlesPresenter {
    func articlesFetchedSuccessfully(_ articles: [Article]) {
        viewModel?.hideLoading()
        viewModel?.showArticles(articles)
    }
    
    func articlesFetchFailed(_ error: NetworkError) {
        viewModel?.hideLoading()
        viewModel?.showError(error.localizedDescription)
    }
}
