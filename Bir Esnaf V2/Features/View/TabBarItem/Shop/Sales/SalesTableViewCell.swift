//
//  SalesTableViewCell.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class SalesTableViewCell: UITableViewCell {

    var prodName = UILabel()
    var totalPriceTitle = UILabel()
    var totalPrice = UILabel()
    var dateTitle = UILabel()
    var date = UILabel()
    var productPriceTitle = UILabel()
    var productPrice = UILabel()
    var quantityOrPieceTitle = UILabel()
    var quantityOrPiece = UILabel()
    var view = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: Colors.cell)
        
        addSubview(prodName)
        addSubview(totalPriceTitle)
        addSubview(totalPrice)
        addSubview(dateTitle)
        addSubview(date)
        addSubview(productPriceTitle)
        addSubview(productPrice)
        addSubview(quantityOrPieceTitle)
        addSubview(quantityOrPiece)
        addSubview(view)
        
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(sale: Sale) {
        prodName.text = sale.prodName
        totalPriceTitle.text = "Total Price:" // toplam tutar
        totalPrice.text = sale.totalPrice
        dateTitle.text = "Date:"
        date.text = sale.saleDate
        productPriceTitle.text = "Product Price:"  // satış toplamı
        productPrice.text = sale.productPrice
        quantityOrPieceTitle.text = "Quantity/Piece:"  // miktar adet
        quantityOrPiece.text = sale.quantityOrPiece
    }
    
    
    func configuration() {
        prodName.textColor = UIColor(named: Colors.label)
        prodName.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        prodName.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(10)
            make.trailing.equalTo(10)
        }
        
        totalPriceTitle.textColor = UIColor(named: Colors.label)
        totalPriceTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        totalPriceTitle.snp.makeConstraints { make in
            make.top.equalTo(prodName.snp.bottom).offset(10)
            make.leading.equalTo(15)
        }
        
        totalPrice.textColor = UIColor(named: Colors.label)
        totalPrice.font = UIFont.systemFont(ofSize: 15, weight: .light)
        totalPrice.snp.makeConstraints { make in
            make.leading.equalTo(productPrice.snp.leading)
            make.centerY.equalTo(totalPriceTitle)
        }
        
        dateTitle.textColor = UIColor(named: Colors.label)
        dateTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(totalPriceTitle.snp.bottom).offset(10)
            make.leading.equalTo(15)
        }
        
        date.textColor = UIColor(named: Colors.label)
        date.font = UIFont.systemFont(ofSize: 15, weight: .light)
        date.snp.makeConstraints { make in
            make.leading.equalTo(productPrice.snp.leading)
            make.centerY.equalTo(dateTitle)
        }
        
        productPriceTitle.textColor = UIColor(named: Colors.label)
        productPriceTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        productPriceTitle.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(10)
            make.leading.equalTo(15)
        }
        
        productPrice.textColor = UIColor(named: Colors.label)
        productPrice.font = UIFont.systemFont(ofSize: 15, weight: .light)
        productPrice.snp.makeConstraints { make in
            make.leading.equalTo(productPriceTitle.snp.trailing).offset(12)
            make.centerY.equalTo(productPriceTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        quantityOrPieceTitle.textColor = UIColor(named: Colors.label)
        quantityOrPieceTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        quantityOrPieceTitle.snp.makeConstraints { make in
            make.top.equalTo(productPriceTitle.snp.bottom).offset(10)
            make.leading.equalTo(15)
        }
        
        quantityOrPiece.textColor = UIColor(named: Colors.label)
        quantityOrPiece.font = UIFont.systemFont(ofSize: 15, weight: .light)
        quantityOrPiece.snp.makeConstraints { make in
            make.leading.equalTo(productPrice.snp.leading)
            make.centerY.equalTo(quantityOrPieceTitle)
        }
        
        view.backgroundColor = UIColor(named: Colors.blue)
        view.snp.makeConstraints { make in
            make.top.equalTo(160)
            make.leading.equalTo(15)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
    }
    
}
