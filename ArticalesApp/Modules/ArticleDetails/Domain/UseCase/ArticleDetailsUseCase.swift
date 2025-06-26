//
//  ArticleDetailsUseCase.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

protocol ArticleDetailsUseCaseProtocol: AnyObject {
    func doSomething()
}

class ArticleDetailsUseCase: ArticleDetailsUseCaseProtocol {

    private let remoteArticleDetailsRepo: ArticleDetailsRemoteRepositoryProtocol?
    private let localArticleDetailsRepo: ArticleDetailsLocalRepositoryProtocol?

    init(remoteArticleDetailsRepo: ArticleDetailsRemoteRepositoryProtocol?, localArticleDetailsRepo: ArticleDetailsLocalRepositoryProtocol?) {
        self.remoteArticleDetailsRepo = remoteArticleDetailsRepo
        self.localArticleDetailsRepo = localArticleDetailsRepo
    }
    
    func doSomething() {
        
    }
}
