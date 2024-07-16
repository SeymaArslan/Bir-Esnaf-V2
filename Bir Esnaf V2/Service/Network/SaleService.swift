//
//  SaleService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 16.07.2024.
//

import Foundation
import Combine

class SaleService {
    
    static let shared = SaleService()
    
    private init() {}
    
    
    func fetchSale(for userMail: String) -> AnyPublisher<SaleData, Error> {
        
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/saleList.php") else {
            fatalError("Invalid url.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: SaleData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
