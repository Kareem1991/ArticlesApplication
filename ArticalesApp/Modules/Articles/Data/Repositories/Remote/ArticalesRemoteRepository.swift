//
//  ArticalesRemoteRepository.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

class ArticalesRemoteRepository: ArticalesRemoteRepositoryProtocol {
    let networkClient = NetworkClient()

    func getMostPopularArticales() -> AnyPublisher<ArticalesResponseModel, NetworkError> {
        networkClient.request(request: ArticlesEndPointsProvider.getMostPopularArticales.makeRequest)
    }
    
}
