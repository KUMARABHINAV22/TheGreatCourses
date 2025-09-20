//
//  HomeView.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.courseItems) { item in
                NavigationLink(destination: CourseDetailView(courseId: item.id)) {
                    HStack(alignment: .top, spacing: 16) {
                        AsyncImage(url: item.imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 100)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 100)
                                    .clipped()
                                    .cornerRadius(6)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 100)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item.productName)
                                .font(.headline)
                            
                            Text(item.productShortDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Courses")
            .task {
                let urlStr = "https://tgc-stg-m2-apps.s3.amazonaws.com/ioschallenge/homeitems/index.json"
                await viewModel.fetchCourseItem(urlStr, context)
            }
        }
    }
}

#Preview {
    HomeView()
}
