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
    
    @Published var productData: ProductData?
    @Published var products: [Product] = []
    
    @Published var saleData: SaleData?
    @Published var sales: [Sale] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProductListForSale(for userMail: String) {
        SaleService.shared.fetchProductListForSale(for: userMail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching product list for sale transactions: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { productData in
                if let success = productData.success, success == 1 {
                    self.products = productData.product ?? []
                } else {
                    print("Failed to fetch products")
                }
            })
            .store(in: &cancellables)
    }
    
    func deleteSale(_ saleId: String, userMail: String) {
        SaleService.shared.deleteSale(saleId, userMail: userMail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error deleting sale: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    print("Sale deleted successfully")
                    if let currentId = Auth.auth().currentUser {
                        let uid = currentId.uid
                        self.fetchSales(for: uid)
                    }
                } else {
                    print("Failed to delete sale.")
                }
            })
            .store(in: &cancellables)
    }
    
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
