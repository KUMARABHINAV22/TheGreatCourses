//
//  CourseDetailViewModel.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import Foundation

@MainActor
class CourseDetailViewModel: ObservableObject {
    @Published var courseDetail: CourseDetail?
    let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func fetchCourseDetail(_ urlStr: String) async {
        do {
            let result = try await service.fetch(CourseDetail.self, from: urlStr)
            self.courseDetail = result
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
        }
    }
}
