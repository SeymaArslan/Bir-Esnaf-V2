//
//  Product.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct ProductData {
    let product: [Product]
}

struct Product {
    let prodId: String
    let userMail: String
    let prodName: String
    let prodTotal: String
    let prodPrice: String
    let count: String
}
