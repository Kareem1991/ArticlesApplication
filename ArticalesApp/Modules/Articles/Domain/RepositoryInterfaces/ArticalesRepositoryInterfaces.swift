//
//  ArticalesRepositoryInterfaces.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

protocol ArticalesRemoteRepositoryProtocol: AnyObject {
    func getMostPopularArticales() -> AnyPublisher<ArticalesResponseModel, NetworkError>
}

protocol ArticalesLocalRepositoryProtocol: AnyObject {
}
