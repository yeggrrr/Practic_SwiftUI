//
//  CoinView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import SwiftUI

struct MarketLike: Hashable, Identifiable {
    let id = UUID()
    let market: Market
    var like: Bool
}

struct CoinView: View {
    @State private var searchText = ""
    @State private var market: [MarketLike] = []
    @State private var filteredMarket: [MarketLike] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                BannerView()
                LazyVStack {
                    ForEach(filteredMarket, id: \.id) { item in
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
            .navigationTitle("My Money")
        }
        .task {
            UpbitAPI.fetchAllMarket { marketData in
                market = marketData.map { MarketLike(market: $0, like: false) }
            }
            
            do {
                let result = try await
                UpbitAPI.fetchAllMarket()
                market = result.map { MarketLike(market: $0, like: false) }
                filteredMarket = market
            } catch {
                print("error: \(error)")
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer,
            prompt: "Search.."
        )
        .onChange(of: searchText, onSearchTextChanged)
    }
    
    private func onSearchTextChanged() {
        filteredMarket = searchText.isEmpty ? market : market.filter {
            $0.market.koreanName.contains(searchText)
        }
    }
    
    private func likeAction(marketLike: MarketLike) {
        var index = 0
        for i in 0..<market.count {
            if market[i].market == marketLike.market {
                index = i
                break
            }
        }
        market[index].like.toggle()
    }
}

// MARK: BannerView
extension CoinView {
    private struct BannerView: View {
        @State private var banner = Banner()
        
        var body: some View {
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
    }
}

// MARK: RowView
extension CoinView {
    private struct RowView: View {
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
}

#Preview {
    CoinView()
}
