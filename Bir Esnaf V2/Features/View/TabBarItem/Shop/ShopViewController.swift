//
//  ShopViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//           NOT :  TEST EDERKEN HATA ALIRSAN UPDATESALERESULTSBUTTONSTATE FONKSİYONUNA BİR BAK. %% Ve kullandım belki de || veya kullanmam gerek uykum geldi :/

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
    
    private var cancellables = Set<AnyCancellable>()
    
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
//        button.isEnabled = true
        return button
    }()
    
    private let salesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sale Transactions", for: .normal)
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
        
        bindViewModel()
        companyViewModel.countCompanyForPurchase(for: Auth.auth().currentUser?.uid ?? "")
        productViewModel.countProductForSale(for: Auth.auth().currentUser?.uid ?? "")
        saleViewModel.countSaleForSaleResults(for: Auth.auth().currentUser?.uid ?? "")
        shopViewModel.countShopForSaleResults(for: Auth.auth().currentUser?.uid ?? "")
        
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
        let purchasePage = PurchaseTransactionsViewController()
        navigationController?.pushViewController(purchasePage, animated: true)
    }
    
    @objc func salesButtonPressed() {
        let salesPage = SalesTransactionsViewController()
        navigationController?.pushViewController(salesPage, animated: true)
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
    private func updateSaleResultsButtonState() {
        if let countSale = saleViewModel.countSale.first?.count, let intCountSale = Int(countSale), let countShop = shopViewModel.countShop.first?.count, let intCountShop = Int(countShop),
           intCountSale < 1 && intCountShop < 1 {
            self.saleResultButton.isEnabled = false
            self.saleResultButton.setTitleColor(UIColor.gray, for: .normal)
            let alert = UIAlertController(title: "Insufficient Sale", message: "Add sale to activate the 'Sales Results' feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I understand", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            self.saleResultButton.isEnabled = true
            self.saleResultButton.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        }
    }
    
    private func updateSaleButtonState() {
        if let count = productViewModel.countProduct.first?.count, let intCountProduct = Int(count), intCountProduct < 1 {
            self.salesButton.isEnabled = false
            self.salesButton.setTitleColor(UIColor.gray, for: .normal)
            let alert = UIAlertController(title: "Insufficient Product", message: "Add product to activate the 'Sale Transactions' feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I understand", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            self.salesButton.isEnabled = true
            self.salesButton.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        }
    }
    
    private func updatePurchaseButtonState() {
        if let count = companyViewModel.countCompany.first?.count, let intCountCompany = Int(count), intCountCompany < 1 {
            self.purchaseButton.isEnabled = false
            self.purchaseButton.setTitleColor(UIColor.gray, for: .normal) // Pasif durumu göstermek için gri renk
            let alert = UIAlertController(title: "Insufficient Company", message: "Add company to activate the 'Purchase Transactions' feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I understand", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            self.purchaseButton.isEnabled = true
            self.purchaseButton.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        }
    }
    
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
    
    
    //MARK: - Helpers
    private func bindViewModel() {
        companyViewModel.$countCompany
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updatePurchaseButtonState()
            }
            .store(in: &cancellables)
        
        productViewModel.$countProduct
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateSaleButtonState()
            }
            .store(in: &cancellables)
        
        saleViewModel.$countSale
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateSaleResultsButtonState()
            }
            .store(in: &cancellables)
        
        shopViewModel.$countShop
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateSaleResultsButtonState()
            }
            .store(in: &cancellables)
    }
    
}
