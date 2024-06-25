//
//  Puchase.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct PurchaseData: Codable {
    let buy: [Purchase]?
    let success: Int?
}

struct Purchase: Identifiable, Codable {
    var id: String { buyId ?? UUID().uuidString }
    let buyId: String?
    let userMail: String?
    let compName: String?
    let productName: String?
    let price: String?
    let total: String?
    let totalPrice: String?
    let buyDate: String?
    let count: String?
}
