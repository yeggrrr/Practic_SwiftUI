//
//  SearchMovieView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/5/24.
//

import SwiftUI

struct SearchMovieView: View {
    @State private var searchText = ""
    @State private var genreList: [String] = []
    
    let genres: [String] = ["SF", "스릴러", "로맨스", "호러", "애니메이션"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(genreList, id: \.self) { genre in
                    HStack {
                        Image(systemName: "person")
                        Text(genre)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "영화를 검색해보세요")
            .navigationTitle("영화검색")
            .toolbar {
                Button {
                    print("tap!")
                    genreList.append("\(genres.randomElement()!)(\(Int.random(in: 1...100)))")
                } label: {
                    Text("추가")
                }
            }
        }
    }
}

#Preview {
    SearchMovieView()
}
