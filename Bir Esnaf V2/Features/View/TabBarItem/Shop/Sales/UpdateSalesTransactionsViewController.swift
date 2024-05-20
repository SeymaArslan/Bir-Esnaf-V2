//
//  UpdateSalesTransactionsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class UpdateSalesTransactionsViewController: UIViewController {
    
    var selectedSale: Sale?
    var data: [String] = ["Test1", "Test2", "Test3", "Test4", "Test5", "Test6",  "Test7",  "Test8",  "Test9", "Test10"]
    
    //MARK: - Create UI
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
    
    private let productTitle: UILabel = {
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
        label.textColor = UIColor(named: Colors.labelColourful)
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let prodPrice: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Product Price"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
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
    
    private let updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let datePicker = UIDatePicker()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
        setupToolBar()
        setupBackgroundTap()

        
        fetchData()
        addDelegate()
        configuration()
    }
    
    
    //MARK: - Delegates
    func addDelegate() {
        prodPicker.delegate = self
        prodPicker.dataSource = self
    }
    
    
    //MARK: - Button Actions
    @objc func updateButtonPressed() {
        print("updateButtonPressed")
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
        
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(20)
        }
        
        prodPicker.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom)
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
        
        updateButton.snp.makeConstraints { make in
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
        view.addSubview(productTitle)
        view.addSubview(prodPicker)
        view.addSubview(prodPriceTitle)
        view.addSubview(prodPrice)
        view.addSubview(quantityOrPieceTitle)
        view.addSubview(quantityOrPiece)
        view.addSubview(totalPriceTitle)
        view.addSubview(totalPrice)
        view.addSubview(dateTitle)
        view.addSubview(date)
        view.addSubview(updateButton)
    }
    
    
    //MARK: - Data Operations
    func fetchData() {
        if let sale = selectedSale {
            prodPrice.text = sale.productPrice
            quantityOrPiece.text = sale.quantityOrPiece
            totalPrice.text = sale.totalPrice
            date.text = sale.saleDate
        }
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
    
}


extension UpdateSalesTransactionsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

extension UpdateSalesTransactionsViewController: UITextFieldDelegate {
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
