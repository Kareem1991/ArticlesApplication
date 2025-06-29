//
//  ArticlesViewModel.swift
//  ArticalesApp
//
//  Created by Kareem on 29/06/2025.
//

import Foundation
import Combine

protocol ArticlesViewModelProtocol: ObservableObject {
    var articles: [Article] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get set }
    
    func loadArticles()
    func refreshArticles()
}

class ArticlesViewModel: ArticlesViewModelProtocol {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var presenter: ArticlesPresenterProtocol
    
    init(presenter: ArticlesPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadArticles() {
        presenter.viewDidLoad()
    }
    
    func refreshArticles() {
        presenter.refreshArticles()
    }
    
    // Methods called by presenter
    func showArticles(_ articles: [Article]) {
        DispatchQueue.main.async {
            self.articles = articles
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            self.errorMessage = error
        }
    }
}
