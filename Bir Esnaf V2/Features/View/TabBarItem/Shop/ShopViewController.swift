//
//  ShopViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import Combine

class ShopViewController: UIViewController {
    var firstShopList = [Shop]()
    
    var countShop: String?
    var shopList = [Shop]()

    var countSale: String?
    var saleList = [Sale]()
    var saleViewModel = SaleTransactionsViewModel()
    
    var countProduct: String?
    var prodList = [Product]()
    var productViewModel = ProductViewModel()
    
    var countCompany: String?
    var compList = [CompanyBank]()
    var companyViewModel = CompanyViewModel()
    
    var shopViewModel = ShopViewModel()
    
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
        button.isEnabled = true
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
        
        getFirstShop()
        
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
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            companyViewModel.countCompanyForPurchase(for: uid)
            compList = companyViewModel.countCompany
            if let count = self.compList.first?.count {
                self.countCompany = count
                guard let countCompanySafe = (self.countCompany) else {
                    return
                }
                if let intCountCompany = Int(countCompanySafe) {
                    if intCountCompany < 1 {
                        self.purchaseButton.isEnabled = false
                        let alert = UIAlertController(title: "Insufficient Company", message: "Add company to activate the 'Purchase Transactions' feature", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "I understand", style: .cancel, handler: nil))
                    } else {
                        self.purchaseButton.isEnabled = true
                        let purchasePage = PurchaseTransactionsViewController()
                        navigationController?.pushViewController(purchasePage, animated: true)
                    }
                }
            }
        }
    }
    
    @objc func salesButtonPressed() {
        if let currentUser = Auth.auth().currentUser {
            let userMail = currentUser.uid
            productViewModel.countProductForSale(for: userMail)
            prodList = productViewModel.countProduct
            if let count = self.prodList.first?.count {
                self.countProduct = count
                guard let countProductSafe = (self.countProduct) else {
                    return
                }
                if let intCountProduct = Int(countProductSafe) {
                    if intCountProduct < 1 {
                        self.salesButton.isEnabled = false
                        let alert = UIAlertController(title: "Insufficient Product", message: "Add product to activate the 'Sale Transactions' feature", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "I understand", style: .cancel, handler: nil))
                    } else {
                        self.salesButton.isEnabled = true
                        let salesPage = SalesTransactionsViewController()
                        navigationController?.pushViewController(salesPage, animated: true)
                    }
                }
                
            }
        }
    }
    
    @objc func saleResultButtonPressed() {
        if let currentUser = Auth.auth().currentUser {
            let userMail = currentUser.uid
            saleViewModel.countSaleForSaleResults(for: userMail)
            saleList = saleViewModel.countSale
            
            shopViewModel.countShopForSaleResults(for: userMail)
            shopList = shopViewModel.countShop
            
            if let cSale = self.saleList.first?.count, let cShop = self.shopList.first?.count {
                self.countSale = cSale
                self.countShop = cShop
                guard let countSaleSafe = (self.countSale), let countShopSafe = (self.countShop) else {
                    return
                }
                if let intCountSale = Int(countSaleSafe), let intCountShop = Int(countShopSafe) {
                    if intCountSale < 1 || intCountShop < 1 {
                        self.saleResultButton.isEnabled = false
                        let alert = UIAlertController(title: "Insufficient Sale", message: "Add sale to activate the 'Sale Result Transactions' feature", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "I understand", style: .cancel, handler: nil))
                    } else {
                        self.saleResultButton.isEnabled = true
                        let salesResultsPage = SalesResultsViewController()
                        if let data = shopViewModel.fetchFirstShopList.first?.totalProfitAmount {
                            salesResultsPage.prodProfitAmount = data
                        }
                        salesResultsPage.modalPresentationStyle = .fullScreen
                        present(salesResultsPage, animated: true, completion: nil)
                    }
                }
                
            }
            
            
        }
    }
    
    
    //MARK: - Functions
    private func getFirstShop() {
        if let currentUser = Auth.auth().currentUser {
            let userMail = currentUser.uid
            shopViewModel.getFirstSale(userMail: userMail)
            if let data = shopViewModel.fetchFirstShopList.first {
                print(data)
            } else {
                print("Yok")
            }
        }
    }
    
}
