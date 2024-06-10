//
//  CompanyTableViewCell.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class CompanyTableViewCell: UITableViewCell {

    var companyTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: Colors.cell)
        
        addSubview(companyTitle)
        
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(company: CompanyBank) {
        companyTitle.text = company.compName
    }
    
    func configureTitle() {
        companyTitle.textColor = UIColor(named: Colors.label)
        companyTitle.font = UIFont.systemFont(ofSize: 18)
        companyTitle.numberOfLines = 2
        companyTitle.textAlignment = .center
//        companyTitle.adjustsFontSizeToFitWidth = true
        companyTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
}
 
