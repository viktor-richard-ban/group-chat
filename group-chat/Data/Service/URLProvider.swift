//
//  URLProvider.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 07. 27..
//

import Foundation

enum URLType: String {
    case webSocket = "WEB_SOCKET_URL"
}

struct URLProvider {
    static func url(for type: URLType) -> URL {
        guard let environment = ProcessInfo.processInfo.environment["APP_ENV"] else {
            fatalError("APP_ENV environment variable is missing")
        }
        guard let path = Bundle.main.path(forResource: "\(environment)-Config", ofType: "plist") else {
            fatalError("Missing \(environment)-Config.plist file")
        }
        guard let config = NSDictionary(contentsOfFile: path) as? [String: Any],
              let urlString = config[type.rawValue] as? String,
              let url = URL(string: urlString) else {
            fatalError("Missing \(type) in config file or invalid URL")
        }
        return url
    }
}
