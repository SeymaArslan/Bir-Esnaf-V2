//
//  SalesTransactionsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 16.07.2024.
//

import Foundation
import Combine
import FirebaseAuth

class SaleTransactionsViewModel: ObservableObject {
    
    @Published var saleData: SaleData?
    @Published var sales: [Sale] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchSales(for userMail: String) {
        SaleService.shared.fetchSale(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching sales: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { salesData in
                if let success = salesData.success, success == 1 {
                    self.sales = salesData.sale ?? []
                } else {
                    print("Failed to fetch sales")
                }
            }
            .store(in: &cancellables)
    }
    
}
