//
//  CompanyService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 28.05.2024.
//

import Foundation
import Combine

class CompanyService {
    
    static let shared = CompanyService()
    
    private init() {}
    
    func fetchCompanies(for userMail: String) -> AnyPublisher<[CompanyBank], Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/companyListWithUser.php") else {
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
            .decode(type: CompanyBankData.self, decoder: JSONDecoder())
            .map { $0.companyBank ?? [] }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
