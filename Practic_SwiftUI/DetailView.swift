//
//  DetailView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import SwiftUI

struct DetailView: View {
    let marketLike: MarketLike
    
    var body: some View {
        VStack {
            Text(marketLike.market.koreanName)
                .fontWeight(.bold)
            Text(marketLike.market.market)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    DetailView(
        marketLike: MarketLike(
            market: Market(
                market: "market1",
                koreanName: "koreanName1",
                englishName: "englishName1"),
            like: false))
}
