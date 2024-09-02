//
//  SearchTableView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/2/24.
//

import SwiftUI

struct SearchModel: Hashable, Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subTitle: String
    let star: Bool
}

struct SearchTableView: View {
    
    @State private var data = [
        SearchModel(image: "leaf", title: "가나", subTitle: "아이유", star: false),
        SearchModel(image: "leaf", title: "나다", subTitle: "잔나비", star: false),
        SearchModel(image: "leaf", title: "다라", subTitle: "아이콘", star: false),
        SearchModel(image: "leaf", title: "라마", subTitle: "잔나비", star: false),
        SearchModel(image: "leaf", title: "마바", subTitle: "아이유", star: false),
        SearchModel(image: "leaf", title: "바사", subTitle: "잔나비", star: false),
        SearchModel(image: "leaf", title: "사아", subTitle: "아이유", star: false),
        SearchModel(image: "leaf", title: "아자", subTitle: "잔나비", star: false),
        SearchModel(image: "leaf", title: "자차", subTitle: "아이콘", star: false),
        SearchModel(image: "leaf", title: "차카", subTitle: "잔나비", star: false),
        SearchModel(image: "leaf", title: "카타", subTitle: "아이콘", star: false),
        SearchModel(image: "leaf", title: "타파", subTitle: "아이유", star: false),
        SearchModel(image: "leaf", title: "파하", subTitle: "잔나비", star: false),
        SearchModel(image: "leaf", title: "하가", subTitle: "잔나비", star: false)
    ]
    
    @State var searchText = ""
    
    var filteredDatas: [SearchModel] {
        return searchText.isEmpty ? data : data.filter{ $0.title.contains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            List(filteredDatas, id: \.id) { data in
            NavigationLink {
              ProfileSettingView()
            } label: {
                HStack {
                    Image(systemName: data.image)
                        .frame(width: 50, height: 50)
                    
                    VStack {
                        Text(data.title)
                            .font(.title3)
                        Text(data.subTitle)
                            .bold()
                    }
                    
                    Spacer()
                    Image(systemName: "star")
                        .foregroundStyle(.orange)
                }
            }
          }
          .listStyle(.plain)
          .navigationTitle("Search Test")
        }
        .searchable(
          text: $searchText,
          placement: .navigationBarDrawer,
          prompt: "Search.."
        )
    }
}

#Preview {
    SearchTableView()
}
