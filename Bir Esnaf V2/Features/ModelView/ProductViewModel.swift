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
    
    @Published var productData: ProductData?
    @Published var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    

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
                if productData.success == 1 {
                    self.products = productData.product
                } else {
                    print("Failed to fetch products")
                }
            }
            .store(in: &cancellables)
    }
    

    func addProduct(_ product: Product) {
        ProductService.shared.addProduct(product)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error adding product: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                }
            })
            .store(in: &cancellables)
    }

    func updateProduct(_ product: Product) {
        ProductService.shared.updateProduct(product)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error updating product: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                }            })
            .store(in: &cancellables)
    }

    func deleteProduct(_ productId: String) {
        ProductService.shared.deleteProduct(productId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error deleting product: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                }
            })
            .store(in: &cancellables)
    }
    
}


 
