//
//  NavigationLazyView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/5/24.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    
    let build: () -> Content
    
    var body: some View {
        build()
    }
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
        print("NavigationLazyView Init")
    }
}
