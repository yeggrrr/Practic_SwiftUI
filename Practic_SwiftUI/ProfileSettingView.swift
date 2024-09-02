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
    let Index: Int
    var state: Bool
}

struct ProfileSettingView: View {
    @State private var riceText = ""
    
    var columns: [GridItem] = Array(repeating: .init(.fixed(70), spacing: 5, alignment: .trailing), count: 4)
    
    @State private var mbti = [
        MBTI(mbti: "E", Index: 0, state: false),
        MBTI(mbti: "I", Index: 1, state: false),
        MBTI(mbti: "S", Index: 2, state: false),
        MBTI(mbti: "N", Index: 3, state: false),
        MBTI(mbti: "F", Index: 4, state: false),
        MBTI(mbti: "T", Index: 5, state: false),
        MBTI(mbti: "P", Index: 6, state: false),
        MBTI(mbti: "J", Index: 7, state: false)
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
                                    mbti[item.Index].state.toggle()
                                }, label: {
                                    Text(item.mbti)
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(.black)
                                        .background(item.state ? .blue : .white)
                                        .clipShape(Circle(), style: FillStyle())
                                        .background(.white)
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
