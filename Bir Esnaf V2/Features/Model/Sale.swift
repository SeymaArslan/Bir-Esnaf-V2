//
//  Sale.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct SaleData: Codable {
    let sale: [Sale]?
    let count: String?
    let success: Int?
}

struct Sale: Identifiable, Codable {
    var id: String { saleId ?? UUID().uuidString }
    let saleId: String?
    let userMail: String?
    let prodName: String?
    let salePrice: String?
    let saleTotal: String?
    let saleTotalPrice: String?
    let saleDate: String?
    let count: String?
}
