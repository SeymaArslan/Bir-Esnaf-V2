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
    
    struct DeleteResponse: Codable {
        let success: Int
        let message: String
    }
    
    func deleteSale(_ saleId: String, userMail: String) -> AnyPublisher<Bool,Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/deleteSale.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "userMail=\(userMail)&saleId=\(saleId)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: DeleteResponse.self, decoder: JSONDecoder())
            .map {   $0.success == 1   }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
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
