//
//  PurchaseTransactionsVM.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 25.06.2024.
//

import Foundation
import Combine
import FirebaseAuth

class PurchaseTransactionsViewModel: ObservableObject {
    
    @Published var companyData: CompanyBankData?
    @Published var companies: [CompanyBank] = []
    
    @Published var purchaseData: PurchaseData?
    @Published var purchases: [Purchase] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func addPurchase(_ purchase: Purchase) {
        PurchaseService.shared.addPurchase(userMail: purchase.userMail!, compName: purchase.compName!, productName: purchase.productName!, price: Double(purchase.price!) ?? 0.0, total: Double(purchase.total!) ?? 0.0, totalPrice: Double(purchase.totalPrice!) ?? 0.0, buyDate: purchase.buyDate!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error adding purchase transactions: \(error)")
                case .finished:
                    print("Finished adding purchase transactions")
                }
            }, receiveValue: { success in
                if success {
                    print("Purchase added successfully.")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchPurchases(for: uid)
                    }
                } else {
                    print("Failed to add purchase")
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchCompListForBuy(for userMail: String) {
        PurchaseService.shared.fetchCompListForBuy(for: userMail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching company list for purchase transactions: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { companyData in
                if let success = companyData.success, success == 1 {
                    self.companies = companyData.companyBank ?? []
                } else {
                    print("Failed to fetch companies")
                }
            })
            .store(in: &cancellables)
    }
    
    func deletePurchase(_ buyId: String, userMail: String) {
        PurchaseService.shared.deletePurchase(buyId, userMail: userMail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error deleting purchase: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    print("Purchase deleted successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchPurchases(for: uid)
                    }
                } else {
                    print("Failed to deleye purchase")
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchPurchases(for userMail: String) {
        PurchaseService.shared.fetchPurchase(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching purchases: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { purchaseData in
                if let success = purchaseData.success, success == 1 {
                    self.purchases = purchaseData.buy ?? []
                } else {
                    print("Failed to fetch purchases")
                }
            }
            .store(in: &cancellables)
    }
    
}
