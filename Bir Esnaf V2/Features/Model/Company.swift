//
//  Company.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct CompanyData: Codable {
    let company: [Company]
    let success: Int
}

struct Company: Identifiable, Codable {
    var id: String { cId }
    let cId: String
    let userMail: String
    let compName: String
    let compPhone: String
    let compMail: String
    let province: String   // il
    let district: String  // ilce
    let asbn: String // avenue/street/building/number
    let bankName: String
    let bankBranchName: String
    let bankBranchCode: String
    let bankAccountType: String
    let bankAccountName: String
    let bankAccountNum: String
    let bankIban: String
    let count: String
}

