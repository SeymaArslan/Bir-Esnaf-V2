//
//  ShopViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 23.07.2024.
//

import Foundation
import Combine
import FirebaseAuth

class ShopViewModel: ObservableObject {
    
    @Published var firstShop: Shop?
    @Published var totalProfit: String = "0 ₺"
    @Published var selectedShop: Shop?
    
    @Published var productSalesProfitAmountList: [Shop] = []
    
    @Published var selectedProduct: Shop?
    
    @Published var sumShopList: [Shop] = []
    @Published var fetchShopList: [Shop] = []
    
    @Published var shopData: ShopData?
    @Published var shops: [Shop] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func sumAllSellProducts(for userMail: String) {
        ShopService.shared.sumAllSellProducts(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching sum products: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { shopsData in
                if let success = shopsData.success, success == 1 {
                    self.shops = shopsData.shop ?? []
                } else {
                    print("Failed to fetch shops")
                }
            }
            .store(in: &cancellables)
    }
    
    // ShopService sınıfındaki fonksiyon
    func productSalesProfitAmount(for userMail: String, productName: String) {
        ShopService.shared.productSalesProfitAmount(for: userMail, productName: productName)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to fetch product sales profit amount: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] shopsData in
                self?.selectedShop = shopsData.shop?.first
            }
            .store(in: &cancellables)
    }
    
    
    func getAllShops(for userMail: String) {
        ShopService.shared.getAllShops(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching shops: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { shopsData in
                if let success = shopsData.success, success == 1 {
                    self.shops = shopsData.shop ?? []
                    self.selectedProduct = self.shops.first
                } else {
                    print("Failed to fetch shops")
                }
            }
            .store(in: &cancellables)
    }
    
}
