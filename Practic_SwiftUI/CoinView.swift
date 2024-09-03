//
//  CoinView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import SwiftUI

struct CoinView: View {
    @State private var searchText = ""
    @State private var banner = Banner()
    @State private var market: Markets = []
    
    var filteredData: [Market] {
        return searchText.isEmpty ? market : market.filter {
            $0.koreanName.contains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                bannerView()
                listView()
            }
            .navigationTitle("My Money")
        }
        .task {
            UpbitAPI.fetchAllMarket { marketData in
                market = marketData
            }
            
            do {
                let result = try await
                UpbitAPI.fetchAllMarket()
                market = result
            } catch {
                print("error: \(error)")
            }
        }
        .searchable(
          text: $searchText,
          placement: .navigationBarDrawer,
          prompt: "Search.."
        )
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(banner.color)
                .overlay(alignment: .leading) {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .scaleEffect(2)
                        .offset(x: -50)
                }
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.callout)
                Text(banner.totalFormat)
                    .font(.title).bold()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    func rowView(_ item: Market) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.koreanName)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Text(item.market)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(item.englishName)
                .foregroundStyle(.black)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(filteredData, id: \.self) { item in
                NavigationLink(
                    destination: { DetailView(market: item) },
                    label: { rowView(item) })
            }
        }
    }
}

#Preview {
    CoinView()
}
