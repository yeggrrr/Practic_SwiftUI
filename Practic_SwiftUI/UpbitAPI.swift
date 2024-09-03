//
//  UpbitAPI.swift
//  Practic_SwiftUI
//
//  Created by YJ on 9/3/24.
//

import Foundation

typealias Markets = [Market]

struct UpbitAPI {
    
    private init() { }

    static func fetchAllMarket(completion: @escaping ([Market]) -> Void) {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(Markets.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    static func fetchAllMarket() async throws -> Markets {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        let (data, response) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(Markets.self, from: data)

        return decodedData
    }
}

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
