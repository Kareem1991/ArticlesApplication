//
//  NetworkErrors.swift
//
//  Created by Kareem on 26/06/2025.
//


import Foundation

// MARK: - Enhanced Network Errors
enum NetworkError: Error, LocalizedError {
    case unknown(String)
    case notValidURL
    case unauthorized
    case invalidApiKey
    case rateLimitExceeded
    case requestFailed
    case decodingError(String)
    case httpError(Int, String)
    case serverError(Int, String)
    case networkUnavailable
    case internalError(NetworkErrorResponse)
    case nyTimesAPIError(String)
    
    var errorDescription: String? {
        switch self {
        case .unknown(let message):
            return "Unknown error: \(message)"
        case .notValidURL:
            return "Invalid URL"
        case .unauthorized:
            return "Unauthorized access"
        case .invalidApiKey:
            return "Invalid API Key. Please check your NY Times API key and ensure you're using 'api-key' parameter."
        case .rateLimitExceeded:
            return "Rate limit exceeded. Please try again later."
        case .requestFailed:
            return "Request failed"
        case .decodingError(let message):
            return "Failed to decode response: \(message)"
        case .httpError(let code, let message):
            return "HTTP Error \(code): \(message)"
        case .serverError(let code, let message):
            return "Server Error \(code): \(message)"
        case .networkUnavailable:
            return "No internet connection"
        case .internalError(let errorResponse):
            return errorResponse.error?.messages?.first ?? "Internal server error"
        case .nyTimesAPIError(let message):
            return "NY Times API Error: \(message)"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .invalidApiKey:
            return "1. Verify your API key is correct\n2. Use 'api-key' parameter instead of 'api'\n3. Check your NY Times developer account status"
        case .rateLimitExceeded:
            return "Wait a few minutes before making another request"
        case .networkUnavailable:
            return "Check your internet connection and try again"
        case .serverError, .httpError:
            return "The service may be temporarily unavailable. Try again later."
        default:
            return "Try again or contact support if the problem persists"
        }
    }
}

// MARK: - NY Times API Error Models
struct NYTimesAPIError: Codable {
    let fault: Fault
    
    struct Fault: Codable {
        let faultstring: String
        let detail: Detail
        
        struct Detail: Codable {
            let errorcode: String
        }
    }
}

