//
//  District.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct DistrictData: Codable {
    let districts: [District]?
    let success: Int?

    enum CodingKeys: String, CodingKey {
        case districts = "district"
        case success
    }
}

struct District: Codable {
    let dId: String?
    let district: String?
    let provinceId: String?
}
