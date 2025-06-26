//
//
//  ArticleDetailsViewModel.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

class ArticleDetailsViewModel: ObservableObject {
    @Published var currentArticle: Article?
    private let articaleDetailsUseCase: ArticleDetailsUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(articaleDetailsUseCase: ArticleDetailsUseCaseProtocol) {
        self.articaleDetailsUseCase = articaleDetailsUseCase
    }
        
    func viewDidAppear(with article: Article) {
        currentArticle = article
    }
    
    deinit {
        cancellables.removeAll()
    }
}
