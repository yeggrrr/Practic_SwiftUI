//
//  ProfileSettingView.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/2/24.
//

import SwiftUI

struct MBTI: Hashable, Identifiable {
    let id = UUID()
    let mbti: String
}

struct ProfileSettingView: View {
    @State private var riceText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.fixed(70), spacing: 5, alignment: .trailing), count: 4)
    let mbti = [
        MBTI(mbti: "E"),
        MBTI(mbti: "I"),
        MBTI(mbti: "S"),
        MBTI(mbti: "N"),
        MBTI(mbti: "F"),
        MBTI(mbti: "T"),
        MBTI(mbti: "P"),
        MBTI(mbti: "J")
    ]
    
    var body: some View {
        
            VStack {
                Image(.profile0)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 50))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.blue, lineWidth: 3)
                    )
                    .padding(20)
                
                TextField("닉네임을 입력해주세요 :)", text: $riceText)
                    .padding(.horizontal)
                    .padding()
                
                HStack(alignment: .top) {
                    Text("MBTI")
                        .frame(alignment: .leading)
                        .bold()
                        .padding()
                    
                    HStack {
                        Spacer()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(mbti, id: \.id) { item in
                            
                            ZStack {
                                Button(action: {
                                    print("클릭됨!")
                                }, label: {
                                    Text(item.mbti)
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(.black, lineWidth: 1)
                                        )
                                })
                                
                                
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink {
                    SecondProfileSettingView()
                } label: {
                    Text("완료")
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(.capsule)
                        .padding()
                        
                }
            }
            .navigationTitle("PROFILE SETTING")
    }
}

#Preview {
    ProfileSettingView()
}
