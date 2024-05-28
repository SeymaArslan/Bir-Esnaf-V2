//
//  ProductService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 28.05.2024.
//

import Foundation
import Combine

class ProductService {
    static let shared = ProductService()
    
    private init() {}
    
    func fetchProducts(for userMail: String) -> AnyPublisher<ProductData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/getAllProduct.php") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let post = "userMail=\(userMail)"
        request.httpBody = post.data(using: .utf8)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in   // tryMap bloğunu kullanarak HTTP yanıtını kontrol ediyoruz ve yanıt başarılı olmadığında hata fırlatıyoruz. Bu sayede hataları daha etkin bir şekilde yakalayabiliriz.
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: ProductData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}


 
