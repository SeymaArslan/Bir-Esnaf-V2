//
//  ProvinceService.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 10.06.2024.
//

import Foundation
import Combine

class CityService {
    
    static let shared = CityService()

    
    func getCities() -> AnyPublisher<ProvinceData, Error> {
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/getCity.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: ProvinceData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
