//
//  HomeModel.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

//
//  HomeModel.swift
//  GreatCourcesDemoApp
//

import Foundation
import SwiftData

struct CourseResponseDTO: Codable {
    let products: [CourseItemDTO]
}

struct CourseItemDTO: Codable {
    let productId: Int
    let productName: String
    let productShortDescription: String
    let courseId: Int

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case productName = "product_name"
        case productShortDescription = "product_short_description"
        case courseId = "course_id"
    }
}

@Model
class CourseItem {
    @Attribute(.unique) var productId: Int
    var productName: String
    var productShortDescription: String
    var courseId: Int
    
    init(productId: Int, productName: String, productShortDescription: String, courseId: Int) {
        self.productId = productId
        self.productName = productName
        self.productShortDescription = productShortDescription
        self.courseId = courseId
    }
    
    var id: Int { productId }
    
    var imageUrl: URL {
        URL(string: "https://secureimages.teach12.com/tgc/images/m2/wondrium/courses/\(courseId)/portrait/\(courseId).jpg")!
    }
}

extension CourseItem {
    static func upsert(from dto: CourseItemDTO, in context: ModelContext) throws {
        let descriptor = FetchDescriptor<CourseItem>(
            predicate: #Predicate { $0.productId == dto.productId }
        )
        
        if let existing = try context.fetch(descriptor).first {
            existing.productName = dto.productName
            existing.productShortDescription = dto.productShortDescription
            existing.courseId = dto.courseId
        } else {
            let newItem = CourseItem(
                productId: dto.productId,
                productName: dto.productName,
                productShortDescription: dto.productShortDescription,
                courseId: dto.courseId
            )
            context.insert(newItem)
        }
    }
}
