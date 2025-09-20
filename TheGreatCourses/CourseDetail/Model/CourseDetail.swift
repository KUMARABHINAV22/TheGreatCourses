//
//  CourseDetail.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

//
//  CourseDetail.swift
//  GreatCourcesDemoApp
//
//
import Foundation

struct CourseDetail: Codable, Identifiable {
    let title: String
    let description: String
    let lectures: [Lecture]
    let course_id: Int
    enum CodingKeys: String, CodingKey {
        case title = "course_name"
        case description = "course_description"
        case lectures
        case course_id
    }
    
    var id: Int { course_id }
}



struct Lecture: Codable, Identifiable {
    let lectureNumber: Int
    let lectureSku: String
    let lectureMagentoId: Int
    let lectureName: String
    let lectureDescription: String
    let lectureImageFilename: String
    let lectureVideoFilename: String
    let lectureSoundtrackFilename: String
    let lectureVideoDownloadFilename: String
    let lectureBifFilename: String
    let timeInMinutes: String
    let timeInSeconds: String
    let contentClassification: String
    let contentRestriction: String
    let contentBrand: String
    let contentBrandImage: String
    let contentPartner: String
    let contentPartnerImage: String
    let lecturePosterImage: String
    let lectureLimitedAccess: Int
    let lectureCompletePercentage: Double
    let lecturePoints: Int

    enum CodingKeys: String, CodingKey {
        case lectureNumber = "lecture_number"
        case lectureSku = "lecture_sku"
        case lectureMagentoId = "lecture_magento_id"
        case lectureName = "lecture_name"
        case lectureDescription = "lecture_description"
        case lectureImageFilename = "lecture_image_filename"
        case lectureVideoFilename = "lecture_video_filename"
        case lectureSoundtrackFilename = "lecture_soundtrack_filename"
        case lectureVideoDownloadFilename = "lecture_videodownload_filename"
        case lectureBifFilename = "lecture_bif_filename"
        case timeInMinutes = "time_in_minutes"
        case timeInSeconds = "time_in_seconds"
        case contentClassification = "content_classification"
        case contentRestriction = "content_restriction"
        case contentBrand = "content_brand"
        case contentBrandImage = "content_brand_image"
        case contentPartner = "content_partner"
        case contentPartnerImage = "content_partner_image"
        case lecturePosterImage = "lecture_poster_image"
        case lectureLimitedAccess = "lecture_limited_access"
        case lectureCompletePercentage = "lecture_complete_percentage"
        case lecturePoints = "lecture_points"
    }

    var id: Int { lectureMagentoId }

    /// Placeholder video URL, replace with actual mapping logic if needed
    var videoURL: URL {
        URL(string: "https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8")!
    }
}

