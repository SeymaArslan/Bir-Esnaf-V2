//
//  DistrictService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 10.06.2024.
//

import Foundation
import Combine

class DistrictService {
    static let shared = DistrictService()
    
    func getDistricts(for provinceId: String) -> AnyPublisher<DistrictData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/getDistrict.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let post = "pId=\(provinceId)"
        request.httpBody = post.data(using: .utf8)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: DistrictData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
