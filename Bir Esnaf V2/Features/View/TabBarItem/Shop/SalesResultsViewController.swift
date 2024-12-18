//
//  SalesResultsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class SalesResultsViewController: UIViewController {
    
    var prodProfitAmount: String?
    
    private var sumShopList = [Shop]()
    private var fetchShopList = [Shop]()
    
    private var cancellables = Set<AnyCancellable>()
    
    var saleSelect: String?
    var viewModel = ShopViewModel()
    
    //MARK: - UIs
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
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: Colors.blue)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let prodSoldTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: Colors.blue)
        label.text = "Products Sold"
        return label
    }()
    
    private let prodSoldPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let pickerPATitleview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Colors.blue)
        return view
    }()
    
    private let prodSalesProfitAmountTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.text = "Product Sales Profit Amount:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let prodSalesProfitAmount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.orange)
        label.text = "0 ₺"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()  // ürünün toplam satış kar/zarar
    
    private let totalProfitAmountTitle: UILabel = {
        let label = UILabel()
        label.text = "Total Profit Amount Title:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(named: Colors.label)
        return label
    }()
    
    private let totalProfitAmount: UILabel = {
        let label = UILabel()
        label.text = "0 ₺"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(named: Colors.orange)
        return label
    }() // toplam satışların kar/zarar
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let calDelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Colors.blue)
        return view
    }()
    
    private let deleteListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete List", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(deleteListButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDelegates()
        configuration()
        
        setupBindings()
        setupInitialSelection()
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.getAllShops(for: uid)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getProfitFirstData()
    }
    
    //MARK: - Delegates
    func addDelegates() {
        prodSoldPicker.delegate = self
        prodSoldPicker.dataSource = self
    }
    
    
    //MARK: - Button Actions
    @objc func deleteListButtonPressed() {
        clearShopAndSaleList()
    }
    
    @objc func calculateButtonPressed() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.sumAllSellProducts(for: uid)
        }
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Snapkit Functions
    func configuration() {
        addSubviews()
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        prodSoldTitle.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(20)
        }
        
        prodSoldPicker.snp.makeConstraints { make in
            make.top.equalTo(prodSoldTitle.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        pickerPATitleview.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(prodSoldPicker.snp.bottom).offset(10)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        prodSalesProfitAmountTitle.snp.makeConstraints { make in
            make.top.equalTo(pickerPATitleview.snp.bottom).offset(30)
            make.leading.equalTo(50)
        }
        
        prodSalesProfitAmount.snp.makeConstraints { make in
            make.leading.equalTo(prodSalesProfitAmountTitle.snp.trailing).offset(10)
            make.centerY.equalTo(prodSalesProfitAmountTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        totalProfitAmountTitle.snp.makeConstraints { make in
            make.leading.equalTo(prodSalesProfitAmountTitle.snp.leading)
            make.top.equalTo(prodSalesProfitAmountTitle.snp.bottom).offset(20)
        }
        
        
        totalProfitAmount.snp.makeConstraints { make in
            make.leading.equalTo(totalProfitAmountTitle.snp.trailing).offset(10)
            make.centerY.equalTo(totalProfitAmountTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(prodSalesProfitAmount.snp.leading)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.top.equalTo(totalProfitAmountTitle.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(27)
        }
        
        calDelView.snp.makeConstraints { make in
            make.top.equalTo(calculateButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        deleteListButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calDelView.snp.bottom).offset(130)
            make.height.equalTo(30)
            make.width.equalTo(180)
        }
    }
    
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(closeButton)
        view.addSubview(prodSoldTitle)
        view.addSubview(prodSoldPicker)
        view.addSubview(pickerPATitleview)
        view.addSubview(prodSalesProfitAmountTitle)
        view.addSubview(prodSalesProfitAmount)
        view.addSubview(totalProfitAmountTitle)
        view.addSubview(totalProfitAmount)
        view.addSubview(calculateButton)
        view.addSubview(calDelView)
        view.addSubview(deleteListButton)
    }
    
    
    //MARK: - Functions
    private func getProfitFirstData() {
        prodSalesProfitAmount.text = prodProfitAmount
        prodSalesProfitAmount.textColor = (Double(prodProfitAmount!.replacingOccurrences(of: " ₺", with: "")) ?? 0) >= 0 ? UIColor(named: "customColor") : .red
    }
    
    private func clearShopAndSaleList() {
        let alertController = UIAlertController(title: "Satış sonuçları listesini temizlemek üzeresiniz, satışı yapılan tüm ürünlerin sonuçları silinecektir.", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Tamam", style: .destructive) { [weak self] _ in
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                self?.viewModel.clearAllListInShop(userMail: uid)
            }
        }
        alertController.addAction(okAct)
        present(alertController, animated: true)
    }
    
    func setupBindings() {
        viewModel.$shops
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.prodSoldPicker.reloadAllComponents()
                if let firstSoldProduct = self?.viewModel.shops.first {
                    self?.updateProfitAmount(for: firstSoldProduct)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$selectedShop
            .receive(on: RunLoop.main)
            .sink { [weak self] shop in
                if let selectedShop = shop {
                    self?.updateProfitAmount(for: selectedShop)
                }
            }
            .store(in: &cancellables)
        

        viewModel.$totalProfit
            .receive(on: RunLoop.main)
            .sink { [weak self] totalProfit in
                self?.totalProfitAmount.text = totalProfit
                self?.totalProfitAmount.textColor = (Double(totalProfit.replacingOccurrences(of: " ₺", with: "")) ?? 0) >= 0 ? UIColor(named: "customColor") : .red
            }
            .store(in: &cancellables)
    }
    
    func setupInitialSelection() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            if let firstProductName = viewModel.shops.first?.prodName {
                viewModel.productSalesProfitAmount(for: uid, productName: firstProductName)
            }
        }
    }
    
    private func updateProfitAmount(for shop: Shop) {
        if let totalProfit = shop.totalProfitAmount {
            prodSalesProfitAmount.text = totalProfit + " ₺"
            prodSalesProfitAmount.textColor = (Double(totalProfit) ?? 0) > 0 ? UIColor(named: "customColor") : .red
        }
    }

}


extension SalesResultsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.shops.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.shops[row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            let selectedShop = viewModel.shops[row]
            viewModel.productSalesProfitAmount(for: uid, productName: selectedShop.prodName ?? "")
        }
        
    }
}
