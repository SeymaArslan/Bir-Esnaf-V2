//
//  DistrictViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 10.06.2024.
//

import Foundation
import Combine

class DistrictViewModel: ObservableObject {
    @Published var districts: [District] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchDistricts(for provinceId: String) {
        DistrictService.shared.getDistricts(for: provinceId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching districts: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { districtData in
                if districtData.success == 1 {
                    self.districts = districtData.districts ?? []
                } else {
                    print("Failed to fetch districts")
                }
            }
            .store(in: &cancellables)
    }
    
}
