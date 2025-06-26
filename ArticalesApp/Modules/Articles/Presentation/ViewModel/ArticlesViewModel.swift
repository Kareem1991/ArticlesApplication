//
//
//  ArticalesViewModel.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine
import SwiftUI

enum ArticlesNavigationCases: Equatable {
    case showArticleDetail(Article)
    
    static func == (lhs: ArticlesNavigationCases, rhs: ArticlesNavigationCases) -> Bool {
        switch (lhs, rhs) {
        case (.showArticleDetail(let lhsArticle), .showArticleDetail(let rhsArticle)):
            return lhsArticle.id == rhsArticle.id
        }
    }
}


class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showError = false
    @Published var navigationCase: ArticlesNavigationCases?
    @Published var selectedArticle: Article?
    
    private let articalesUseCase: ArticalesUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(articalesUseCase: ArticalesUseCaseProtocol) {
        self.articalesUseCase = articalesUseCase
    }
    
    func loadArticles(forceRefresh: Bool = false) {
        isLoading = true
        errorMessage = nil
        showError = false
        
        articalesUseCase.getMostPopularArticales()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    
                    if case .failure(let error) = completion {
                        self?.handleError(error)
                    }
                },
                receiveValue: { [weak self] response in
                    self?.articles = response.results
                }
            )
            .store(in: &cancellables)
    }
    
    func refreshArticles() {
        loadArticles(forceRefresh: true)
    }
    
    func selectArticle(_ article: Article) {
        selectedArticle = article
        navigationCase = .showArticleDetail(article)
    }
    
 
    
    func clearCache() {
        articles.removeAll()
    }
    
    func dismissError() {
        showError = false
        errorMessage = nil
    }
    
    func retryLastAction() {
        loadArticles()
    }
    
    private func handleError(_ error: Error) {
        let errorText: String
        
        if let networkError = error as? NetworkError {
            errorText = networkError.localizedDescription
        } else {
            errorText = error.localizedDescription
        }
        
        errorMessage = errorText
        showError = true
    }
    
    deinit {
        cancellables.removeAll()
    }
}
