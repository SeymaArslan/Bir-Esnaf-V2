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
    
    var defaultDistricts: [District] = []
    
    func setDefaultDistricts(_ districts: [District]) {
        self.defaultDistricts = districts
    }
    
    func fetchDistricts(for provinceId: String?) {
        guard let provinceId = provinceId else { return }
        DistrictService.shared.getDistricts(for: provinceId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching districts: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] districtData in
                if let districts = districtData.districts, districtData.success == 1 {
                    print("Districts received: \(districts)")
                    self?.districts = districts
                } else {
                    print("Failed to fetch districts")
                }
            }
            .store(in: &cancellables)
    }

}
