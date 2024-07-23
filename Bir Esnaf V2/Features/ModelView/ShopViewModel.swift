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
    
    @Published var shopData: ShopData?
    @Published var shops: [Shop] = []
    
    private var cancellables = Set<AnyCancellable>()
    
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
                } else {
                    print("Failed to fetch shops")
                }
            }
            .store(in: &cancellables)
    }
    
}

