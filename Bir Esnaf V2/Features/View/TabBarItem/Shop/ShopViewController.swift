//
//  ShopViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class ShopViewController: UIViewController {

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.background)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.logoCalculate)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let purchaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Purchase Transactions", for: .normal)
        button.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(purchaseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let salesButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sales Transactions", for: .normal)
        button.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(salesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let saleResultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sales Results", for: .normal)
        button.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(saleResultButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    func configure() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(iconImage)
        view.addSubview(purchaseButton)
        view.addSubview(salesButton)
        view.addSubview(saleResultButton)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.height.equalTo(197)
            make.width.equalTo(186)
        }
        
        purchaseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImage.snp.bottom).offset(100)
            make.height.equalTo(55)
            make.width.equalTo(200)
        }
        
        salesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(purchaseButton.snp.bottom).offset(40)
            make.height.equalTo(55)
            make.width.equalTo(185)
        }
        
        saleResultButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(salesButton.snp.bottom).offset(40)
            make.height.equalTo(55)
            make.width.equalTo(185)
        }
    }
    
    
    //MARK: - Button Actions
    @objc func purchaseButtonPressed() {
        let purchasePage = PurchaseTransactionsViewController()
        navigationController?.pushViewController(purchasePage, animated: true)
    }
    
    @objc func salesButtonPressed() {
        let salesPage = SalesTransactionsViewController()
        navigationController?.pushViewController(salesPage, animated: true)
    }
    
    @objc func saleResultButtonPressed() {
        let salesResultPage = SalesResultsViewController()
        salesResultPage.modalPresentationStyle = .fullScreen
        present(salesResultPage, animated: true, completion: nil)
    }
    
}
