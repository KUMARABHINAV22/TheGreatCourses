//
//  CourseDetailView.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import SwiftUI

struct CourseDetailView: View {
    let courseId: Int
    @StateObject private var viewModel = CourseDetailViewModel()
    
    var body: some View {
        ScrollView {
            if let detail = viewModel.courseDetail {
                VStack(alignment: .leading, spacing: 16) {
                    Text(detail.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text(detail.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("Lectures")
                        .font(.headline)
                    
                    ForEach(detail.lectures) { lecture in
                        NavigationLink(destination: LecturePlayerView(
                            url: pickVideoURL()
                        )) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(lecture.lectureName)
                                    .font(.subheadline)
                                Text("Duration: \(lecture.timeInMinutes)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding()
            } else {
                ProgressView("Loading course details...")
                    .padding()
            }
        }
        .navigationTitle("Course Detail")
        .task {
            let urlStr = "https://tgc-stg-m2-apps.s3.amazonaws.com/ioschallenge/details/index.json"
            await viewModel.fetchCourseDetail(urlStr)
        }
    }
    
    private func pickVideoURL() -> URL {
        let urls = [
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
        ]
        return URL(string: urls[1])!
    }
}

#Preview {
    CourseDetailView(courseId: 1321)
}
