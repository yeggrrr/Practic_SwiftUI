//
//  MyRandomImageView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/4/24.
//

import SwiftUI

struct PosterSection: Hashable, Identifiable {
    let id = UUID()
    var title: String
    let imageURLs: [URL?]
}

struct MyRandomMainView: View {
    @State private var posterSections: [PosterSection] = []
    @State private var changedSectionTitle: (id: UUID, title: String)?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(posterSections, id: \.id) { section in
                    SectionView(
                        posterSection: section,
                        changedSectionTitle: $changedSectionTitle)
                }
            }
            .navigationTitle("My Random Image")
        }
        .onAppear(perform: onAppear)
        .onChange(of: changedSectionTitle?.id, sectionTitleChanged)
    }
    
    private func onAppear() {
        posterSections = [
            PosterSection(title: "첫번째 섹션", imageURLs: getSectionImageURLs(rowCount: 6)),
            PosterSection(title: "두번째 섹션", imageURLs: getSectionImageURLs(rowCount: 6)),
            PosterSection(title: "세번째 섹션", imageURLs: getSectionImageURLs(rowCount: 6)),
            PosterSection(title: "네번째 섹션", imageURLs: getSectionImageURLs(rowCount: 6))
        ]
    }
    
    private func sectionTitleChanged() {
        guard changedSectionTitle != nil else { return }
        var index = 0
        
        for i in 0..<posterSections.count {
            if posterSections[i].id == changedSectionTitle?.id {
                index = i
                break
            }
        }
        
        if let newTitle = changedSectionTitle?.title {
            posterSections[index].title = newTitle
        }
        changedSectionTitle = nil
    }
    
    private func getSectionImageURLs(rowCount: Int) -> [URL?] {
        var randomNumbers: [Int] = []
        while Set(randomNumbers).count < rowCount {
            randomNumbers.append(Int.random(in: 1...100))
        }
        let urls = randomNumbers.map { URL(string: "https://picsum.photos/id/\($0)/200/300") }
        return urls
    }
}

extension MyRandomMainView {
    struct SectionView: View {
        let posterSection: PosterSection
        @Binding var changedSectionTitle: (id: UUID, title: String)?
        
        var body: some View {
            VStack {
                Text(posterSection.title)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(posterSection.imageURLs, id: \.?.absoluteString) { url in
                            NavigationLink(
                                destination: {
                                    PosterDetailView(
                                        title: posterSection.title,
                                        id: posterSection.id,
                                        imageURL: url,
                                        changedSectionTitle: $changedSectionTitle)
                                },
                                label: {
                                    PosterView(imageURL: url)
                                })
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        
        private struct PosterDetailView: View {
            let title: String
            let id: UUID
            let imageURL: URL?
            
            @Binding var changedSectionTitle: (id: UUID, title: String)?
            @State var text: String = ""
            
            var body: some View {
                VStack {
                    PosterView(imageURL: imageURL)
                    TextField("섹션 제목을 입력하세요", text: $text)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    Text(imageURL?.absoluteString ?? "-")
                }
                .onAppear(perform: onAppear)
                .onDisappear(perform: onDisappear)
            }
            
            private func onAppear() {
                text = title
            }
            
            private func onDisappear() {
                changedSectionTitle = (id, text)
            }
        }
        
        private struct PosterView: View {
            let imageURL: URL?
            
            var body: some View {
                AsyncImage(url: imageURL) { data in
                    switch data {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(.buttonBorder)
                    default:
                        Image(systemName: "star")
                    }
                }
                .frame(width: 120, height: 180)
            }
        }
    }
}

#Preview {
    MyRandomMainView()
}
