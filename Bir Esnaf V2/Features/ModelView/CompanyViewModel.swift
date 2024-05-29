//
//  CompanyViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 29.05.2024.
//

import Foundation
import Combine
import FirebaseAuth

class CompanyViewModel: ObservableObject {
    @Published var companyData: CompanyData?
    @Published var companies: [Company] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCompanies(for userMail: String) {
        CompanyService.shared.fetchCompanies(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching companies: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { companyData in
                if companyData.success == 1 {
                    self.companies = companyData.company
                } else {
                    print("Failed to fetch companies")
                }
            }
            .store(in: &cancellables)
    }
    
}
