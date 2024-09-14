//
//  ProductService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 28.05.2024.
//

import Foundation
import Combine

class ProductService {
    
    struct DeleteResponse: Codable {
        let success: Int
        let message: String
    }
    
    static let shared = ProductService()
    
    private init() {}
    
    func updateForSalesProduct(userMail: String, prodName: String, prodTotal: Double) -> AnyPublisher<Bool,Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/productUpdateWithSales.php") else {
            fatalError("Invalid URL.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&prodTotal=\(prodTotal)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Bool in
                guard let httpResult = result.response as? HTTPURLResponse, httpResult.statusCode == 200 else {
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
    
    func fetchProducts(for userMail: String) -> AnyPublisher<ProductData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/getAllProduct.php") else {
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
            .decode(type: ProductData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func addProduct(userMail: String, prodName: String, prodTotal: Double, prodPrice: Double) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/addProduct.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&prodTotal=\(prodTotal)&prodPrice=\(prodPrice)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Bool in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                guard let json = try JSONSerialization.jsonObject(with: result.data, options: []) as? [String: Any],
                      let success = json["success"] as? Int else {
                    throw URLError(.cannotParseResponse)
                }
                return success == 1
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func updateProduct(userMail: String, prodId: String, prodName: String, prodTotal: Double, prodPrice: Double) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/updateProduct.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodId=\(prodId)&prodName=\(prodName)&prodTotal=\(prodTotal)&prodPrice=\(prodPrice)"
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

    
    
    func deleteProduct(_ productId: String, userMail: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/deleteProduct.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "prodId=\(productId)&userMail=\(userMail)"
        request.httpBody = postString.data(using: .utf8)
        
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
    
    
    
}



