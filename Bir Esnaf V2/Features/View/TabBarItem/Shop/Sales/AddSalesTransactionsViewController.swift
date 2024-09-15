//
//  AddSalesTransactionsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class AddSalesTransactionsViewController: UIViewController {
    
    var productViewModel = ProductViewModel()
    var shopViewModel = ShopViewModel()
    
    var prodPriceAddShop: String?
    var prodTotalAddShop: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    var prodSelect = String()
    
    var viewModel = SaleTransactionsViewModel()
    
    //MARK: - Create UIs
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
    
    private let prodTitle: UILabel = {
        let label = UILabel()
        label.text = "Products"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: Colors.blue)
        return label
    }()
    
    private let prodPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let prodPriceTitle: UILabel = {
        let label = UILabel()
        label.text = "Product Price:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Colors.blue)
        return label
    }()
    
    private let prodPrice: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Product Price"
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(calculate), for: .editingChanged)
        return textField
    }()
    
    private let quantityOrPieceTitle: UILabel = {
        let label = UILabel()
        label.text = "Quantity/Piece:"
        label.textColor = UIColor(named: Colors.labelColourful)
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let quantityOrPiece: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Quantity/Piece"
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(calculate), for: .editingChanged)
        return textField
    }()
    
    private let totalPriceTitle: UILabel = {
        let label = UILabel()
        label.text = "Total Price:"
        label.textColor = UIColor(named: Colors.labelColourful)
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let totalPrice: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Total Price"
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let dateTitle: UILabel = {
        let label = UILabel()
        label.text = "Date:"
        label.textColor = UIColor(named: Colors.labelColourful)
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let date: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date"
        textField.textColor = UIColor(named: Colors.label)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        setupToolBar()
        setupBackgroundTap()
        
        addDelegate()
        configuration()
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.fetchProductListForSale(for: uid)
        }
        
        setupBindings()
    }
    
    
    
    //MARK: - Delegates
    func addDelegate() {
        prodPicker.delegate = self
        prodPicker.dataSource = self
    }
    
    
    //MARK: - Button Actions
    @objc func saveButtonPressed() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            
            guard let salePrice = prodPrice.text?.replacingOccurrences(of: ",", with: "."),
                  let saleTotal = quantityOrPiece.text?.replacingOccurrences(of: ",", with: "."),
                  let saleTotalPrice = totalPrice.text?.replacingOccurrences(of: ",", with: "."),
                  let date = date.text else {
                return
            }
            
            if let doubleSalePrice = Double(salePrice), let doubleSaleTotal = Double(saleTotal), let doubleSaleTotalPrice = Double(saleTotalPrice), let prodTotal = prodTotalAddShop, let prodPrice = prodPriceAddShop {
                if let doubleProdT = Double(prodTotal), let doubleProdP = Double(prodPrice) {
                    if doubleProdT >= doubleSaleTotal {
                        
                        viewModel.addSale(userMail: uid, prodName: prodSelect, salePrice: doubleSalePrice, saleTotal: doubleSaleTotal, saleTotalPrice: doubleSaleTotalPrice, saleDate: date)
                        countProfitAmount(prodSelect: prodSelect, prodPrice: doubleProdP, prodTotal: doubleProdT, salePrice: doubleSalePrice, saleTotal: doubleSaleTotal)
                        dismiss(animated: true, completion: nil)
                    }
                }

            }
        }
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - SnapKit Func
    func configuration() {
        addSubviews()
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        prodTitle.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(20)
        }
        
        prodPicker.snp.makeConstraints { make in
            make.top.equalTo(prodTitle.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        prodPriceTitle.snp.makeConstraints { make in
            make.top.equalTo(prodPicker.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        prodPrice.snp.makeConstraints { make in
            make.leading.equalTo(quantityOrPiece.snp.leading)
            make.centerY.equalTo(prodPriceTitle)
            textFeildConst(make: make)
        }
        
        quantityOrPieceTitle.snp.makeConstraints { make in
            make.top.equalTo(prodPriceTitle.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        quantityOrPiece.snp.makeConstraints { make in
            make.leading.equalTo(quantityOrPieceTitle.snp.trailing).offset(10)
            make.centerY.equalTo(quantityOrPieceTitle)
            textFeildConst(make: make)
        }
        
        totalPriceTitle.snp.makeConstraints { make in
            make.top.equalTo(quantityOrPieceTitle.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        totalPrice.snp.makeConstraints { make in
            make.leading.equalTo(quantityOrPiece.snp.leading)
            make.centerY.equalTo(totalPriceTitle)
            textFeildConst(make: make)
        }
        
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(totalPriceTitle.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        date.snp.makeConstraints { make in
            make.leading.equalTo(quantityOrPiece.snp.leading)
            make.centerY.equalTo(dateTitle)
            textFeildConst(make: make)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(47)
            make.width.equalTo(103)
        }
        
    }
    
    func textFeildConst(make: ConstraintMaker) {
        make.trailing.lessThanOrEqualToSuperview().inset(10)
        make.width.equalTo(200)
    }
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(closeButton)
        view.addSubview(prodTitle)
        view.addSubview(prodPicker)
        view.addSubview(prodPriceTitle)
        view.addSubview(prodPrice)
        view.addSubview(quantityOrPieceTitle)
        view.addSubview(quantityOrPiece)
        view.addSubview(totalPriceTitle)
        view.addSubview(totalPrice)
        view.addSubview(dateTitle)
        view.addSubview(date)
        view.addSubview(saveButton)
    }
    
    
    //MARK: - Input Accessories
    @objc func doneButtonClicked() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeStyle = .none
        date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Ekle", style: .plain, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        date.inputAccessoryView = toolbar
        date.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    
    //MARK: - Func
    @objc func calculate() {
        guard let price = Double(prodPrice.text ?? "Null"), let total = Double(quantityOrPiece.text ?? "Null") else {
            totalPrice.text = "0 ₺"
            return
        }
        let result = price * total
        totalPrice.text = "\(result) ₺" 
    }
    
    func countProfitAmount(prodSelect: String, prodPrice: Double, prodTotal: Double, salePrice: Double, saleTotal: Double) {
        let priceDifference = salePrice - prodPrice // kar için
        let totalRemainingProduct = prodTotal - saleTotal // Product güncelleme için prodTotal toplam ürün miktarı saleTotal satılan
        let amount = priceDifference * saleTotal  // satış kar
        if totalRemainingProduct > 0 {
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                shopViewModel.addSaleForShopping(userMail: uid, productName: prodSelect, totalProfitAmount: amount)
                productViewModel.updateForSalesProduct(userMail: uid, prodName: prodSelect, prodTotal: totalRemainingProduct)
            }
        }
        if totalRemainingProduct == 0 {
            let alert = UIAlertController(title: "Error", message: "The sold item \(prodSelect) is out of stock", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                shopViewModel.addSaleForShopping(userMail: uid, productName: prodSelect, totalProfitAmount: amount)
                productViewModel.updateForSalesProduct(userMail: uid, prodName: prodSelect, prodTotal: totalRemainingProduct)
            }
       }
    }
    
    func setupBindings() {
        viewModel.$products
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.prodPicker.reloadAllComponents()
                if let firstProduct = self?.viewModel.products.first {
                    self?.prodSelect = firstProduct.prodName!
                    self?.prodPriceAddShop = firstProduct.prodPrice
                    self?.prodTotalAddShop = firstProduct.prodTotal
                }
            }
            .store(in: &cancellables)
    }
    
}


extension AddSalesTransactionsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.products.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.products[row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == prodPicker {
            let selectedProduct = viewModel.products[row]
            prodSelect = selectedProduct.prodName!
            prodPriceAddShop = selectedProduct.prodPrice
            prodTotalAddShop = selectedProduct.prodTotal
        }
    }
}

extension AddSalesTransactionsViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        
        prodPrice.inputAccessoryView = bar
        quantityOrPiece.inputAccessoryView = bar
        totalPrice.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}

extension AddSalesTransactionsViewController {
    
}
