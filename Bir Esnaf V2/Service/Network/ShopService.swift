//
//  ShopService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 23.07.2024.
//

import Foundation
import Combine

class ShopService {
    
    static let shared = ShopService()
    
    private init() {}
    
    struct DeleteResponse: Codable {
        let success: Int
        let message: String
    }
    
    func countShopForSaleResults(userMail: String) -> AnyPublisher<ShopData, Error> {
        guard let url = URL(string: "") else {
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
            .decode(type: ShopData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func addShop(userMail: String, prodName: String, totalProfitAmount: Double) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/fetchProdListForSale.php") else {
            fatalError("Invalid url.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&totalProfitAmount=\(totalProfitAmount)"
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
    
    func getFirstSale(for userMail: String) -> AnyPublisher<ShopData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/getFirstSaleDataInShop.php") else {
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
            .decode(type: ShopData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func clearAllListInShop(userMail: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/clearAllListInShop.php") else {
            fatalError("Invalid Error")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Conten-Type")
        let postString = "userMail=\(userMail)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            })
            .decode(type: DeleteResponse.self, decoder: JSONDecoder())
            .map {   $0.success == 1   }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func sumAllSellProducts(for userMail: String) -> AnyPublisher<ShopData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/sumAllSellProd.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postStr = "userMail=\(userMail)"
        request.httpBody = postStr.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: ShopData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    

    func productSalesProfitAmount(for userMail: String, productName: String) -> AnyPublisher<ShopData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/fetchShop.php") else {
            fatalError("Invalid url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(productName)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: ShopData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getAllShops(for userMail: String) -> AnyPublisher<ShopData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/pullSalesForPickerView.php") else {
            fatalError("Invalid url")
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
            .decode(type: ShopData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
