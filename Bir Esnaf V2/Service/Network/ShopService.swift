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
