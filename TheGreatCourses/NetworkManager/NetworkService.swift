//
//  NetworkService.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import Foundation

protocol NetworkServiceProtocol  {
    func fetch<T: Decodable>(_ type: T.Type, from urlStr: String) async throws -> Result<T?, Error>
}

final class NetworkService: NetworkServiceProtocol {

    func fetch<T: Decodable>(_ type: T.Type, from urlStr: String) async throws -> Result<T?, Error> {
        guard let url = URL(string: urlStr) else {
            print("URL is not valid")
            return .failure(NetworkError.badURL)
        }
        
        let (data, resp) = try await URLSession.shared.data(from: url)
        
        guard let response = resp as? HTTPURLResponse,
              let statusCode = HTTPStatusCode(rawValue: response.statusCode) else {
            return .failure(NetworkError.badResponse)
        }
        
        switch statusCode.category {
        case .informational:
            return .failure(NetworkError.dataNotFound)
        case .success:
            let result = try JSONDecoder().decode(type, from: data)
            return .success(result)
        case .redirection:
            return .failure(NetworkError.dataNotFound)
        case .clientError:
            return .failure(NetworkError.dataNotFound)
        case .serverError:
            return .failure(NetworkError.dataNotFound)
        case .unknown:
            return .failure(NSError(domain: "NetworkError", code: statusCode.rawValue, userInfo: nil))
        }
    }
}
