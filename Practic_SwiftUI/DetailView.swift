//
//  DetailView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var marketLike: MarketLike
    
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
    DetailView(marketLike: .constant(MarketLike(
        market: Market(
            market: "marketEX",
            koreanName: "koreanNameEX",
            englishName: "EnglishNameEX"),
        like: false)))
}
