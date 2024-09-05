//
//  CoinView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import SwiftUI

struct MarketLike {
    let market: Market
    var like: Bool
}

struct CoinView: View {
    @State private var searchText = ""
    @State private var banner = Banner()
    @State private var market: [MarketLike] = []
    
    var filteredData: [MarketLike] {
        return searchText.isEmpty ? market : market.filter {
            $0.market.koreanName.contains(searchText)
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
                market = marketData.map { MarketLike(market: $0, like: false) }
            }
            
            do {
                let result = try await
                UpbitAPI.fetchAllMarket()
                market = result.map { MarketLike(market: $0, like: false)}
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
    
    func likeAction(marketLike: MarketLike) {
        var index = 0
        for i in 0..<market.count {
            if market[i].market == marketLike.market {
                index = i
                break
            }
        }
        market[index].like.toggle()
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
    
    struct RowView: View {
        let marketLike: MarketLike
        let likeAction: () -> Void
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(marketLike.market.koreanName)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Text(marketLike.market.market)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text(marketLike.market.englishName)
                    .foregroundStyle(.black)
                    .padding()
                Button(action: {
                    likeAction()
                }, label: {
                    Image(systemName: marketLike.like ? "heart.fill" : "heart")
                })
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(filteredData, id: \.market) { item in
                NavigationLink(
                    destination: {
                        NavigationLazyView(DetailView(marketLike: item))
                    },
                    label: {
                        NavigationLazyView(RowView(
                            marketLike: item,
                            likeAction: { likeAction(marketLike: item) }))
                    })
            }
        }
    }
}

#Preview {
    CoinView()
}
