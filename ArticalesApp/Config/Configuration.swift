//
//  Configuration.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import Foundation

struct Configuration {
    private static let configPlist = "Info"
    
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: configPlist, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let apiKey = plist["API_KEY"] as? String else {
            fatalError("API Key not found in Config.plist")
        }
        return apiKey
    }
    
    static var baseURL: String {
        guard let path = Bundle.main.path(forResource: configPlist, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let baseURL = plist["BASE_URL"] as? String else {
            fatalError("Base URL not found in Config.plist")
        }
        return baseURL
    }
}
