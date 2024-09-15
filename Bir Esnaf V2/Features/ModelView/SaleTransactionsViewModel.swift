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
    
    func updateSale(_ sale: Sale) {
        SaleService.shared.updateSale(saleId: sale.saleId!, userMail: sale.userMail!, prodName: sale.prodName!, salePrice: Double(sale.salePrice!) ?? 0.0, saleTotal: Double(sale.saleTotal!) ?? 0.0, saleTotalPrice: Double(sale.saleTotalPrice!) ?? 0.0, saleDate: sale.saleDate!) 
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error update sale: \(error)")
                case .finished:
                    print("Finished update sale")
                }
            }, receiveValue: { success in
                if success {
                    print("Sale update successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchSales(for: uid)
                    }
                } else {
                    print("Failed to update sale")
                }
            })
            .store(in: &cancellables)
    }
    
    func addSale(userMail: String, prodName: String, salePrice: Double, saleTotal: Double, saleTotalPrice: Double, saleDate: String) {
        SaleService.shared.addSale(userMail: userMail, prodName: prodName, salePrice: salePrice, saleTotal: saleTotal, saleTotalPrice: saleTotalPrice, saleDate: saleDate)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error adding sale transactions: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    print("Sale added successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchSales(for: uid)
                    }
                } else {
                    print("failed to add sale")
                }
            })
            .store(in: &cancellables)
    }
    
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
