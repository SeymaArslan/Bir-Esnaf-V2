//
//  ProductTableViewCell.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class ProductTableViewCell: UITableViewCell {

    var productTitle = UILabel()
    var view = UIView()
    var costTitle = UILabel()
    var cost = UILabel()
    var amountTitle = UILabel()
    var amount = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
        contentView.backgroundColor = UIColor(named: Colors.cell)
        
        addSubview(productTitle)
        addSubview(view)
        addSubview(costTitle)
        addSubview(cost)
        addSubview(amountTitle)
        addSubview(amount)
        
        configureProdTitle()
        configureView()
        configureCost()
        configureAmount()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(product: Product) {
        productTitle.text = product.prodName
        costTitle.text = "Cost:"
        cost.text = product.prodPrice
        if let price = product.prodPrice {
            cost.text = price + " ₺"
        }
        amountTitle.text = "Amount:"
        amount.text = product.prodTotal
    }
    
    func configureProdTitle() {
        productTitle.textColor = UIColor(named: Colors.label)
        productTitle.numberOfLines = 0
        productTitle.adjustsFontSizeToFitWidth = true
        productTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(10)
            make.trailing.equalTo(10)
        }
    }
    
    func configureView() {
        view.backgroundColor = UIColor(named: Colors.blue)
        view.snp.makeConstraints { make in
            make.top.equalTo(45)
            make.leading.equalTo(10)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
    }
    
    
    func configureCost() {
        costTitle.textColor = UIColor(named: Colors.label)
        costTitle.font = UIFont.systemFont(ofSize: 16, weight: .light)
        costTitle.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.equalTo(17)
        }
        
        cost.textColor = UIColor(named: Colors.label)
        cost.font = UIFont.systemFont(ofSize: 16, weight: .light)
        cost.snp.makeConstraints { make in
//            make.top.equalTo(25)    // özel bir şey yaparsan kullan eşit olmasını istemediğinde mesela..
            make.leading.equalTo(costTitle.snp.trailing).offset(10) // costTitle'ın hemen yanına yerleştir
            make.centerY.equalTo(costTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10) // Sağ kenara kısmen yaklaştır
        }
    }
    
    func configureAmount() {
        amountTitle.textColor = UIColor(named: Colors.label)
        amountTitle.font = UIFont.systemFont(ofSize: 16, weight: .light)
        amountTitle.snp.makeConstraints { make in
            make.top.equalTo(85)
            make.leading.equalTo(17)
        }
        
        amount.textColor = UIColor(named: Colors.label)
        amount.font = UIFont.systemFont(ofSize: 16, weight: .light)
        amount.snp.makeConstraints { make in
            make.leading.equalTo(amountTitle.snp.trailing).offset(10)
            make.centerY.equalTo(amountTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
    }
}
