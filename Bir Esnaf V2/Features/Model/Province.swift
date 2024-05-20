//
//  Province.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct ProvinceData: Codable {
    let province: [Province]
}

struct Province: Codable {
    let pId: String
    let province: String
}
