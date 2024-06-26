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
    
    @Published var purchaseData: PurchaseData?
    @Published var purchases: [Purchase] = []
    
    private var cancellables = Set<AnyCancellable>()
    
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
