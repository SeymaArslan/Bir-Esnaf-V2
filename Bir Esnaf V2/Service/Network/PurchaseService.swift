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
    
    struct DeleteResponse: Codable {
        let success: Int
        let message: String
    }
    
    
    func addPurchase(userMail: String, compName: String, productName: String, price: Double, total: Double, totalPrice: Double, buyDate: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/addBuy.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&compName=\(compName)&productName=\(productName)&price=\(price)&total=\(total)&totalPrice=\(totalPrice)&buyDate=\(buyDate)"
        
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Bool in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                guard let json = try JSONSerialization.jsonObject(with: result.data, options: []) as? [String: Any], let success = json["success"] as? Int else {
                    throw URLError(.cannotParseResponse)
                }
                return success == 1
            }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        func fetchCompListForBuy(for userMail: String) -> AnyPublisher<CompanyBankData, Error> {
            guard let url = URL(string: "https://lionelo.tech/birEsnaf/fetchCompListForBuy.php") else {
                fatalError("Invalid Url")
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
                .decode(type: CompanyBankData.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    
    func deletePurchase(_  buyId: String, userMail: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/deleteBuy.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postStr = "userMail=\(userMail)&buyId=\(buyId)"
        request.httpBody = postStr.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: DeleteResponse.self, decoder: JSONDecoder())
            .map { $0.success == 1 }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
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
