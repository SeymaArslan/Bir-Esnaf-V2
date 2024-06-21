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
    @Published var companyData: CompanyBankData?
    @Published var companies: [CompanyBank] = []
    private var cancellables = Set<AnyCancellable>()

    func addCompany(_ company: CompanyBank) {
        CompanyService.shared.addCompany(userMail: company.userMail!, compName: company.compName!, compPhone: company.compPhone!, compMail: company.compMail!, province: company.province!, district: company.district!, asbn: company.asbn!, bankName: company.bankName!, bankBranchName: company.bankBranchName!, bankBranchCode: company.bankBranchCode!, bankAccountType: company.bankAccountType!, bankAccountName: company.bankAccountName!, bankAccountNum: Int(company.bankAccountNum!)!, bankIban: company.bankIban!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error adding company: \(error)")
                case .finished:
                    print("Finished adding company")
                }
            }, receiveValue: { success in
                if success {
                    print("Company added successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchCompanies(for: uid)
                    }
                } else {
                    print("Failed to add company")
                }
            })
            .store(in: &cancellables)

    }
    
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
                if let success = companyData.success, success == 1 {
                    self.companies = companyData.companyBank ?? []
                } else {
                    print("Failed to fetch companies")
                }
            }
            .store(in: &cancellables)
    }
}
