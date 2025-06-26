//
//  NetworkHeaders.swift
//
//  Created by Kareem on 26/06/2025.
//

import Foundation

final class NetworkHeaders {
    class func getHeaders() -> [String: String] {
        return ["Accept-Language": "en" ,  "Content-Type" : "application/json"]
    }
}
