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
}

struct District: Codable {
    let dId: String?
    let district: String?
    let provinceId: String?
}
