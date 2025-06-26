//
//  NetworkErrorResponse.swift
//
//  Created by Kareem on 26/06/2025.
//

import Foundation

struct NetworkErrorResponse: Codable {
    let error: ErrorDetail?
    
    struct ErrorDetail: Codable {
        let messages: [String]?
    }
}
