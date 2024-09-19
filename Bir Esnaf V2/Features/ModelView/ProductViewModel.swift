//
//  ProductViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 28.05.2024.
//

import Foundation
import Combine
import FirebaseAuth

class ProductViewModel: ObservableObject {
    
    @Published var countProduct: [Product] = []
    
    @Published var productData: ProductData?
    @Published var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    
    func countProductForSale(for userMail: String) {
        ProductService.shared.countProductForSale(userMail: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error count product for sale: \(error)")
                case .finished:
                    print("Finished count company for sale")
                }
            } receiveValue: { prodData in
                if let success = prodData.success, success == 1 {
                    self.countProduct = prodData.product ?? []
                } else {
                    print("Failed to fetch product data")
                }
            }
            .store(in: &cancellables)
    }
    
    func updateForSalesProduct(userMail: String, prodName: String, prodTotal: Double) {
        ProductService.shared.updateForSalesProduct(userMail: userMail, prodName: prodName, prodTotal: prodTotal)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error update for sales product: \(error)")
                case .finished:
                    print("Finished update for sales product")
                }
            } receiveValue: { success in
                if success {
                    print("Product update successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to update product")
                }
            }
            .store(in: &cancellables)
        
    }

    func fetchProducts(for userMail: String) {
        ProductService.shared.fetchProducts(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching products: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { productData in
                if let success = productData.success, success == 1 {
                    self.products = productData.product ?? []
                } else {
                    print("Failed to fetch products")
                }
            }
            .store(in: &cancellables)
    }

    func addProduct(_ product: Product) {
        ProductService.shared.addProduct(userMail: product.userMail!, prodName: product.prodName!, prodTotal: Double(product.prodTotal!) ?? 0.0, prodPrice: Double(product.prodPrice!) ?? 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error adding product: \(error)")
                case .finished:
                    print("Finished adding product")
                }
            }, receiveValue: { success in
                if success {
                    print("Product added successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to add product")
                }
            })
            .store(in: &cancellables)
    }
    
    func updateProduct(_ product: Product) {
        ProductService.shared.updateProduct(userMail: product.userMail!, prodId: product.prodId!, prodName: product.prodName!, prodTotal: Double(product.prodTotal!) ?? 0.0, prodPrice: Double(product.prodPrice!) ?? 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error update product: \(error)")
                case .finished:
                    print("Finished update product")
                }
            }, receiveValue: { success in
                if success {
                    print("Product update successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to update product")
                }
            })
            .store(in: &cancellables)
    }

    func deleteProduct(_ productId: String, userMail: String) {
        ProductService.shared.deleteProduct(productId, userMail: userMail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error deleting product: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    print("Product deleted successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to delete product")
                }
            })
            .store(in: &cancellables)
    }
    
    
}
