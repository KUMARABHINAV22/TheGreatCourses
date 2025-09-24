//
//  HomeViewModel.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import Foundation
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var courseItems: [CourseItem] = []
    let service: NetworkServiceProtocol
        
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    private func loadFromStorage(_ context: ModelContext) async throws {
        let descriptor = FetchDescriptor<CourseItem>()
        let storedCourseItems = try context.fetch(descriptor)
        if !storedCourseItems.isEmpty {
            self.courseItems = storedCourseItems
        }
    }
    
    func fetchCourseItem(_ urlStr: String, _ context: ModelContext) async {
        do {
            try await loadFromStorage(context)
            if !courseItems.isEmpty {
                return
            }
        } catch {
            print("SwiftData fetch failed:", error)
        }
        
        do {
            let result = try await service.fetch(CourseResponseDTO.self, from: urlStr)
            
            switch result {
            case .success(let courseResponse):
                guard let courseResponse else { return }
                for dto in courseResponse.products {
                    try CourseItem.upsert(from: dto, in: context)
                }
                
                try context.save()
                
                do {
                    try await loadFromStorage(context)
                } catch {
                    print("SwiftData fetch failed:", error)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                courseItems = []
            }
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
        }
    }
}
