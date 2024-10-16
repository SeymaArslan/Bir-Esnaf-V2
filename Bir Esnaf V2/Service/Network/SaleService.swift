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
    
    func countSaleForSaleResults(userMail: String) -> AnyPublisher<SaleData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/countSale.php") else {
            fatalError("Invalid url.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postStr = "userMail=\(userMail)"
        request.httpBody = postStr.data(using: .utf8)
        
        print("Request Body: \(postStr)")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                guard !result.data.isEmpty else {
                    throw URLError(.dataNotAllowed)
                }
                
                return result.data
            }
            .decode(type: SaleData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func updateSale(saleId: String, userMail: String, prodName: String, salePrice: Double, saleTotal: Double, saleTotalPrice: Double, saleDate: String) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/updateSale.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&saleId=\(saleId)&prodName=\(prodName)&salePrice=\(salePrice)&saleTotal=\(saleTotal)&saleTotalPrice=\(saleTotalPrice)&saleDate=\(saleDate)"
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
    
    func addSale(userMail: String, prodName: String, salePrice: Double, saleTotal: Double, saleTotalPrice: Double, saleDate: String) -> AnyPublisher<Bool,Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/addSale.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&salePrice=\(salePrice)&saleTotal=\(saleTotal)&saleTotalPrice=\(saleTotalPrice)&saleDate=\(saleDate)"
        
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
  
    func fetchProductListForSale(for userMail: String) -> AnyPublisher<ProductData, Error> {
        
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/fetchProdListForSale.php") else {
            fatalError("Invalid URL")
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
            .decode(type: ProductData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
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
