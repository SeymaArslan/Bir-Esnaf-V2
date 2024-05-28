//
//  Product.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct ProductData: Codable {
    let product: [Product]
    let success: Int
}

struct Product: Identifiable, Codable {
    var id: String { prodId }  
    let prodId: String
    let userMail: String
    let prodName: String
    let prodTotal: String
    let prodPrice: String
}
