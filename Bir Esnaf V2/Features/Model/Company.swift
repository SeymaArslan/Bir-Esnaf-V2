//
//  Company.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct CompanyBankData: Codable {
    let companyBank: [CompanyBank]?
    let success: Int?
}

struct CompanyBank: Identifiable, Codable {
    var id: String { cbId ?? UUID().uuidString }
    let cbId: String?
    let userMail: String?
    let compName: String?
    let compPhone: String?
    let compMail: String?
    let province: String?  // il
    let district: String?  // ilce
    let asbn: String?  // avenue/street/building/number
    let bankName: String?
    let bankBranchName: String?
    let bankBranchCode: String?
    let bankAccountType: String?
    let bankAccountName: String?
    let bankAccountNum: String?
    let bankIban: String?
    let count: String?
}
