//
//  Banner.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import Foundation
import SwiftUI

struct Banner: Hashable, Identifiable {
    let id = UUID()
    var total = Int.random(in: 1000...5000) * 150
    let color = Color.random()

    var totalFormat: String {
        return String(total.formatted()) + "원"
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1)
        )
    }
}
