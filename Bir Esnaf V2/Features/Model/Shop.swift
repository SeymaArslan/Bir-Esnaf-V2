//
//  Shop.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct ShopData: Codable {
    let shop: [Shop]?
    let success: Int?
}

struct Shop: Identifiable, Codable {
    var id: String { shopId ?? UUID().uuidString }
    let shopId: String?
    let userMail: String?
    let prodName: String?
    let totalProfitAmount: String?
    let count: String?
}
