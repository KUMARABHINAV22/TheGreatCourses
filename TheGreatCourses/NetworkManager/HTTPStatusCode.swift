//
//  HTTPStatusCode.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 24/09/25.
//

import Foundation

enum HTTPStatusCode: Int, CustomStringConvertible {
    // 1xx: Informational
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    
    // 2xx: Success
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    
    // 3xx: Redirection
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case notModified = 304
    
    // 4xx: Client Error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    
    // 5xx: Server Error
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    
    // Fallback (non-standard or unlisted)
    case unknown = -1
}

extension HTTPStatusCode {
    
    var category: HTTPStatusCategory {
        HTTPStatusCategory(code: self.rawValue)
    }
    
    var isSuccess: Bool {
        category == .success
    }
    
    var description: String {
        switch self {
        case .ok: return "OK"
        case .notFound: return "Not Found"
        case .internalServerError: return "Internal Server Error"
        case .unknown: return "Unknown Status"
        default: return "\(self.rawValue)"
        }
    }
}

enum HTTPStatusCategory: String {
    case informational = "Informational"
    case success = "Success"
    case redirection = "Redirection"
    case clientError = "Client Error"
    case serverError = "Server Error"
    case unknown = "Unknown"

    init(code: Int) {
        switch code {
        case 100..<200: self = .informational
        case 200..<300: self = .success
        case 300..<400: self = .redirection
        case 400..<500: self = .clientError
        case 500..<600: self = .serverError
        default       : self = .unknown
        }
    }
}
