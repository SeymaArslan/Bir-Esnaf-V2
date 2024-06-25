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
