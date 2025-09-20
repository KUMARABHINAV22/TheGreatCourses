//
//  NetworkService.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import Foundation

protocol NetworkServiceProtocol  {
    func fetch<T: Decodable>(_ type: T.Type, from urlStr: String) async throws -> T?
}

final class NetworkService: NetworkServiceProtocol {

    func fetch<T: Decodable>(_ type: T.Type, from urlStr: String) async throws -> T? {
        guard let url = URL(string: urlStr) else {
            print("URL is not valid")
            return nil
        }
        
        let (data, resp) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(type, from: data)
        return response
    }
}
