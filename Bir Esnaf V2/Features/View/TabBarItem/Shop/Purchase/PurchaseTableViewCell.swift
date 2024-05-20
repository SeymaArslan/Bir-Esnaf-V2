//
//  PurchaseTableViewCell.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class PurchaseTableViewCell: UITableViewCell {

    var compName = UILabel()
    var prodName = UILabel()
    var totalTitle = UILabel()
    var total = UILabel()
    var dateTitle = UILabel()
    var date = UILabel()
    var view = UIView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: Colors.cell)
        
        addSubview(compName)
        addSubview(prodName)
        addSubview(totalTitle)
        addSubview(total)
        addSubview(dateTitle)
        addSubview(date)
        addSubview(view)
        
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(purchase: Purchase) {
        compName.text = purchase.compName
        prodName.text = purchase.productName
        totalTitle.text = "Total:"
        total.text = purchase.totalPrice
        dateTitle.text = "Date:"
        date.text = purchase.buyDate
    }

    func configuration() {
        compName.textColor = UIColor(named: Colors.label)
        compName.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        compName.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(10)
            make.trailing.equalTo(10)
        }
        
        prodName.textColor = UIColor(named: Colors.label)
        prodName.font = UIFont.systemFont(ofSize: 16, weight: .light)
        prodName.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.leading.equalTo(15)
        }

        totalTitle.textColor = UIColor(named: Colors.label)
        totalTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        totalTitle.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(15)
        }
        
        total.textColor = UIColor(named: Colors.label)
        total.font = UIFont.systemFont(ofSize: 15, weight: .light)
        total.snp.makeConstraints { make in
            make.leading.equalTo(totalTitle.snp.trailing).offset(10)
            make.centerY.equalTo(totalTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        dateTitle.textColor = UIColor(named: Colors.label)
        dateTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(95)
            make.leading.equalTo(15)
        }
        
        date.textColor = UIColor(named: Colors.label)
        date.font = UIFont.systemFont(ofSize: 15, weight: .light)
        date.snp.makeConstraints { make in
            make.leading.equalTo(dateTitle.snp.trailing).offset(10)
            make.centerY.equalTo(dateTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        view.backgroundColor = UIColor(named: Colors.blue)
        view.snp.makeConstraints { make in
            make.top.equalTo(125)
            make.leading.equalTo(15)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
    }

    
}
