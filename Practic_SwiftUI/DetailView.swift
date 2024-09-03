//
//  DetailView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import SwiftUI

struct DetailView: View {
    let market: Market
    
    var body: some View {
        VStack {
            Text(market.koreanName)
                .fontWeight(.bold)
            Text(market.market)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    DetailView(
        market: Market(
            market: "market1",
            koreanName: "koreanName1",
            englishName: "englishName1"))
}
