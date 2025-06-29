//
//  ArticlesInteractor.swift
//  ArticlesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

protocol ArticlesInteractorProtocol: AnyObject {
    func fetchArticles()
}

final class ArticlesInteractor: ArticlesInteractorProtocol {
    weak var presenter: ArticlesPresenter?
    private let networkClient: NetworkClientProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.networkClient = NetworkClient()
    }
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchArticles() {
        let request = ArticlesEndPointsProvider.getMostPopularArticales.makeRequest
        
        networkClient.request(request: request)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.presenter?.articlesFetchFailed(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] (response: ArticalesResponseModel) in
                    self?.presenter?.articlesFetchedSuccessfully(response.results)
                }
            )
            .store(in: &cancellables)
    }
}
