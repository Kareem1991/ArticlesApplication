//
//  ArticleDetailsViewModel.swift
//  ArticlesApp
//
//  Created by Kareem on 29/06/2025.
//

import Foundation

protocol ArticleDetailsViewModelProtocol: ObservableObject {
    var currentArticle: Article? { get }
    
    func loadArticle(_ article: Article)
}

class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {
    @Published var currentArticle: Article?
    
    init() {}
    
    func loadArticle(_ article: Article) {
        DispatchQueue.main.async {
            self.currentArticle = article
        }
    }
}
