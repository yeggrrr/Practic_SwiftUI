//
//  ContentView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView() {
            VStack {
                Image(.launch)
                    .padding(70)
                Image(.launchPoster)
                Spacer()
                NavigationLink {
                    ProfileSettingView()
                } label: {
                    Text("시작하기")
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(.capsule)
                        .padding()
                        
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
