//
//  MockObjects.swift
//  ArticlesAppTests
//
//  Created by Kareem on 29/06/2025.
//

import Foundation
import Combine
@testable import ArticalesApp

// MARK: - Mock Network Client
final class MockNetworkClient: NetworkClientProtocol {
    var result: Result<ArticalesResponseModel, NetworkError> = .success(
        ArticalesResponseModel(status: "OK", copyright: "Test", numResults: 0, results: [])
    )
    
    func request<R: Codable>(request: URLRequest) -> AnyPublisher<R, NetworkError> {
        return result
            .map { $0 as! R }
            .publisher
            .eraseToAnyPublisher()
    }
}

// MARK: - Mock ViewModel
final class MockArticlesViewModel {
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showArticlesCalled = false
    var showErrorCalled = false
    var capturedArticles: [Article]?
    var capturedErrorMessage: String?
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func showArticles(_ articles: [Article]) {
        showArticlesCalled = true
        capturedArticles = articles
    }
    
    func showError(_ error: String) {
        showErrorCalled = true
        capturedErrorMessage = error
    }
}

// MARK: - Mock Interactor
final class MockArticlesInteractor: ArticlesInteractorProtocol {
    var fetchArticlesCalled = false
    
    func fetchArticles() {
        fetchArticlesCalled = true
    }
}

// MARK: - Mock Presenter Protocol
final class MockArticlesPresenterProtocol: ArticlesPresenterProtocol {
    var viewDidLoadCalled = false
    var refreshArticlesCalled = false
    var didSelectArticleCalled = false
    var capturedSelectedArticle: Article?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func refreshArticles() {
        refreshArticlesCalled = true
    }
    
    func didSelectArticle(_ article: Article) {
        didSelectArticleCalled = true
        capturedSelectedArticle = article
    }
}
