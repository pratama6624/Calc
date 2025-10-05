//
//  CurrencyAPIService.swift
//  Calc
//
//  Created by Pratama One on 05/10/25.
//

import Foundation

// API from forexrateapi.com

struct CurrencyResponse: Codable {
    let success: Bool
    let base: String
    let timestamp: Int
    let rates: [String: Double]
}

final class CurrencyAPIService {
    private let apiKey = "a591de6a0378a90833db49b90d106729"
    private let baseURL = "https://api.forexrateapi.com/v1/latest"
    
    func fetchRates(base: String = "USD", completion: @escaping (Result<[String: Double], Error>) -> Void) {
        let currencies = "EUR,GBP,JPY,IDR,SGD,AUD,CAD,CHF,CNY,HKD,INR,KRW,MYR,NZD,PHP,THB,VND"
        
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)&base=\(base)&currencies=\(currencies)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded.rates))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
