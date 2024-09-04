//
//  MyRandomImageView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/4/24.
//

import SwiftUI

struct Title: Hashable, Identifiable {
    let id = UUID()
    let title: String
}

struct MyRandomImageView: View {
    
    let titleList: [Title] = [
        Title(title: "첫번째 섹션"),
        Title(title: "두번째 섹션"),
        Title(title: "세번째 섹션"),
        Title(title: "네번째 섹션")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(titleList, id: \.id) { item in
                    SectionTitleView(title: item.title)
                    HorizontalImageView()
                }
            }
            .navigationTitle("My Random Image")
        }
    }
}

struct SectionTitleView: View {
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical)
    }
}

struct HorizontalImageView: View {
    let url = URL(string: "https://picsum.photos/200/300")
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<6) { item in
                    PosterView()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PosterView: View {
    let url = URL(string: "https://picsum.photos/200/300")
    
    var body: some View {
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
                    .frame(width: 120, height: 180)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipShape(.buttonBorder)
            case .failure(_):
                Image(systemName: "star")
                    .frame(width: 120, height: 180)
            @unknown default:
                Image(systemName: "star")
                    .frame(width: 120, height: 180)
            }
        }
    }
}

#Preview {
    MyRandomImageView()
}
