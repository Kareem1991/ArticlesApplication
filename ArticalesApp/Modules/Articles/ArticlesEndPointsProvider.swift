

//
//  ArticlesEndPointsProvider.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation

enum ArticlesEndPointsProvider {
    case getMostPopularArticales
}
extension ArticlesEndPointsProvider: NetworkRequest {
    var baseURL: String {
        Constants.baseURL
    }
    
    var endPoint: String {
        switch self {
        case .getMostPopularArticales:
            return "svc/mostpopular/v2/viewed/1.json"
        }
    }
    
    var headers: [String: String]? {
        NetworkHeaders.getHeaders()
    }
    

    var queryParams: [String : Any]? {
        switch self {
        case .getMostPopularArticales:
            return [
                "api-key": Constants.apiKey
            ]
        }
    }
    var parameters: [String: Any]? {
        return nil
    }
    var method: APIHTTPMethod {
        return .GET
    }
    
}
