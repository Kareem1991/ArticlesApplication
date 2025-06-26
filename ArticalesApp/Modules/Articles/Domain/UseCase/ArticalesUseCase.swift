//
//  ArticalesUseCase.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

protocol ArticalesUseCaseProtocol: AnyObject {
    func getMostPopularArticales() -> AnyPublisher<ArticalesResponseModel, NetworkError>
}

class ArticalesUseCase: ArticalesUseCaseProtocol {
    
    private let remoteArticalesRepo: ArticalesRemoteRepositoryProtocol
    private let localArticalesRepo: ArticalesLocalRepositoryProtocol?
    /// Initsialize the interactor with the required parameters to work properly
    init(remoteArticalesRepo: ArticalesRemoteRepositoryProtocol, localArticalesRepo: ArticalesLocalRepositoryProtocol?) {
        self.remoteArticalesRepo = remoteArticalesRepo
        self.localArticalesRepo = localArticalesRepo
    }
    func getMostPopularArticales() -> AnyPublisher<ArticalesResponseModel, NetworkError> {
        self.remoteArticalesRepo.getMostPopularArticales()
    }
}
