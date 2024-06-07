//
//  Product.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

//struct ProductData: Codable {
//    let product: [Product]
//    let success: Int
//}
//
//struct Product: Identifiable, Codable {
//    var id: String { prodId }  
//    let prodId: String
//    let userMail: String
//    let prodName: String
//    let prodTotal: String
//    let prodPrice: String
//    let count: String
//}


struct ProductData: Codable {
    let product: [Product]?
    let success: Int?
}

struct Product: Identifiable, Codable, Equatable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.prodName == rhs.prodName
    }
    
    var id: String { prodId ?? UUID().uuidString }// prodId opsiyonel olduğu için default bir değer sağlıyoruz
    let prodId: String?
    let userMail: String?
    let prodName: String?
    let prodTotal: String?
    let prodPrice: String?
    let count: String?
}



