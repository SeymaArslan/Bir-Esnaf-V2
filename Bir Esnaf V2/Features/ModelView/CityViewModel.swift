//
//  ProvinceViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 10.06.2024.
//

import Foundation
import Combine

class CityViewModel: ObservableObject {
    
    @Published var provinces: [Province] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProvinces() {
        CityService.shared.getCities()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching provinces: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { provinceData in
                if let provinces = provinceData.province {
                    self.provinces = provinces
                } else {
                    print("Failed to fetch provinces")
                }
            }
            .store(in: &cancellables)
    }
    
}
