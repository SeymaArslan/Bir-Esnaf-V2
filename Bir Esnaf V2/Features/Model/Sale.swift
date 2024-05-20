//
//  Sale.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct SaleData: Codable {
    let sale: [Sale]
}

struct Sale: Codable {
    let saleId: String
    let userMail: String
    let prodName: String
    let totalPrice: String // toplam fiyat
    let productPrice: String // satış fiyatı
    let quantityOrPiece: String // miktar/adet
    let saleDate: String
    let count: String
}
