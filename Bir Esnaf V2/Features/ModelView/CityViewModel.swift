//
//  ProvinceViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 10.06.2024.
//

import Foundation
import Combine

class CityViewModel: ObservableObject {
    
    @Published var provinceData: ProvinceData?
    @Published var provinces: [Province] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProvinces() {
        CityService.shared.getProvinces()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching provinces: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { provinceData in
                if provinceData.success == 1 {
                    self.provinces = provinceData.province ?? []
                } else {
                    print("Failed to fetch Provinces")
                }
            }
            .store(in: &cancellables)
    }
    
}
