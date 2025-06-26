//
//  NetworkClient.swift
//
//  Created by Kareem on 26/06/2025.
//

import Foundation
import Combine

// MARK: - Network Client Protocol
protocol NetworkClientProtocol: AnyObject {
    func request<R: Codable>(request: URLRequest) -> AnyPublisher<R, NetworkError>
}

// MARK: - Network Client Implementation
final class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Properties
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Constants
    private enum Constants {
        static let successStatusCodeRange = 200..<300
        static let unauthorizedStatusCode = 401
        static let rateLimitStatusCode = 429
        static let serverErrorRange = 500..<600
    }
    
    // MARK: - Init
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - Public Methods
    func request<R: Decodable>(request: URLRequest) -> AnyPublisher<R, NetworkError> {
        logRequest(request)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] result in
                try self?.handleResponse(result, for: request) ?? Data()
            }
            .decode(type: R.self, decoder: decoder)
            .mapError { [weak self] error in
                self?.handleError(error, for: request) ?? .unknown(error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Response Handling
private extension NetworkClient {
    func handleResponse(_ result: URLSession.DataTaskPublisher.Output, for request: URLRequest) throws -> Data {
        guard let httpResponse = result.response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        switch httpResponse.statusCode {
        case Constants.successStatusCodeRange:
            logSuccessResponse(result.data, for: request)
            return result.data
            
        case Constants.unauthorizedStatusCode:
            throw handleUnauthorizedError(result.data)
            
        case Constants.rateLimitStatusCode:
            throw NetworkError.rateLimitExceeded
            
        case Constants.serverErrorRange:
            throw NetworkError.serverError(httpResponse.statusCode, "Server Error")
            
        default:
            throw handleGenericError(result.data, statusCode: httpResponse.statusCode)
        }
    }
    
    func handleUnauthorizedError(_ data: Data) -> NetworkError {
        // Try to decode NY Times API error
        if let nyTimesError = try? decoder.decode(NYTimesAPIError.self, from: data) {
            return mapNYTimesError(nyTimesError.fault)
        }
        
        // Try to decode generic error
        if let genericError = try? decoder.decode(NetworkErrorResponse.self, from: data) {
            return .internalError(genericError)
        }
        
        return .unauthorized
    }
    
    func handleGenericError(_ data: Data, statusCode: Int) -> NetworkError {
        if let errorResponse = try? decoder.decode(NetworkErrorResponse.self, from: data) {
            return .internalError(errorResponse)
        }
        return .httpError(statusCode, "HTTP Error \(statusCode)")
    }
    
    func mapNYTimesError(_ fault: NYTimesAPIError.Fault) -> NetworkError {
        switch fault.detail.errorcode {
        case "oauth.v2.InvalidApiKey":
            return .invalidApiKey
        case "policies.ratelimit.QuotaViolation":
            return .rateLimitExceeded
        default:
            return .nyTimesAPIError(fault.faultstring)
        }
    }
    
    func handleError(_ error: Error, for request: URLRequest) -> NetworkError {
        if let networkError = error as? NetworkError {
            logError(networkError, for: request)
            return networkError
        }
        
        if let decodingError = error as? DecodingError {
            let decodingNetworkError = NetworkError.decodingError(decodingError.localizedDescription)
            logError(decodingNetworkError, for: request)
            return decodingNetworkError
        }
        
        let unknownError = NetworkError.unknown(error.localizedDescription)
        logError(unknownError, for: request)
        return unknownError
    }
}

// MARK: - Logging
private extension NetworkClient {
    func logRequest(_ request: URLRequest) {
        #if DEBUG
        print("🚀 [\(request.httpMethod?.uppercased() ?? "GET")] \(request.url?.absoluteString ?? "")")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8), !bodyString.isEmpty {
            print("📦 Body: \(bodyString)")
        }
        #endif
    }
    
    func logSuccessResponse(_ data: Data, for request: URLRequest) {
        #if DEBUG
        print("✅ [\(request.httpMethod?.uppercased() ?? "GET")] Success")
        if let responseString = String(data: data, encoding: .utf8) {
            print("📄 Response: \(responseString.prefix(200))...")
        }
        #endif
    }
    
    func logError(_ error: NetworkError, for request: URLRequest) {
        #if DEBUG
        print("❌ [\(request.httpMethod?.uppercased() ?? "GET")] Error: \(error.localizedDescription)")
        #endif
    }
}
