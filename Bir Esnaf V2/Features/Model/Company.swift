//
//  Company.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import Foundation

struct CompanyBankData: Codable {
    let companyBank: [CompanyBank]?
    let count: String?
    let success: Int?
}

struct CompanyBank: Identifiable, Codable, Equatable {
    
    static func == (lhs: CompanyBank, rhs: CompanyBank) -> Bool {
        return lhs.compName == rhs.compName
    }
    
    var id: String { cbId ?? UUID().uuidString }// prodId opsiyonel olduğu için default bir değer sağlıyoruz

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
