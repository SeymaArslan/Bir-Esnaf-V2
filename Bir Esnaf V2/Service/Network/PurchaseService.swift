//
//  PurchaseService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 25.06.2024.
//

import Foundation
import Combine

class PurchaseService {
    
    static let shared = PurchaseService()
    
    private init() {  }
    

    
    func fetchPurchase(for userMail: String) -> AnyPublisher<PurchaseData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/getBuyList.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let post = "userMail=\(userMail)"
        request.httpBody = post.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: PurchaseData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
