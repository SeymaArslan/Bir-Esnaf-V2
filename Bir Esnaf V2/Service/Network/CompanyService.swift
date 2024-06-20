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
    
    func addCompany(userMail: String, compName: String, compPhone: String, compMail: String, province: String, district: String, asbn: String, bankName: String, bankBranchName: String, bankBranchCode: String, bankAccountType: String, bankAccountName: String, bankAccountNum: Int, bankIban: String) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "https://lionelo.tech/birEsnaf/addCompany.php") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&compName=\(compName)&compPhone=\(compPhone)&compMail=\(compMail)&province=\(province)&district=\(district)&asbn=\(asbn)&bankName=\(bankName)&bankBranchName=\(bankBranchName)&bankBranchCode=\(bankBranchCode)&bankAccountType=\(bankAccountType)&bankAccountName=\(bankAccountName)&bankAccountNum=\(bankAccountNum)&bankIban=\(bankIban)"
        
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