//
//  UpdatePurchaseTransactionsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class UpdatePurchaseTransactionsViewController: UIViewController {

    var selectedPurchase: Purchase?
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
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let compName: UILabel = {
        let label = UILabel()
        label.text = "Companies"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: Colors.blue)
        return label
    }()
    
    private let compPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let companyProdTitle: UILabel = {
        let label = UILabel()
        label.text = "Product Name:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let companyProdTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Product Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let unitPriceTitle: UILabel = {
        let label = UILabel()
        label.text = "Unit Price:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let unitPriceTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Unit Price"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let amountTitle: UILabel = {
        let label = UILabel()
        label.text = "Amount:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let totalCostLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Cost:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let totalCostTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Total Cost"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let dateTitle: UILabel = {
        let label = UILabel()
        label.text = "Date:"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Date"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
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
        
        fetchData()
        
        createDatePicker()
        setupToolBar()
        setupBackgroundTap()
        
        addDelegate()
        configuration()
    }
    
    
    //MARK: - Delegates
    func addDelegate() {
        compPicker.delegate = self
        compPicker.dataSource = self
        
        companyProdTextField.delegate = self
    }
    
    
    //MARK: - Button Actions
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateButtonPressed() {
        print("updateButtonPressed")
    }
    
    
    //MARK: - Snapkit Function
    func configuration() {
        addSubview()
        
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
        
        compName.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(20)
        }
        
        compPicker.snp.makeConstraints { make in
            make.top.equalTo(compName.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        companyProdTitle.snp.makeConstraints { make in
            make.top.equalTo(compPicker.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        companyProdTextField.snp.makeConstraints { make in
            make.leading.equalTo(companyProdTitle.snp.trailing).offset(12)
            make.centerY.equalTo(companyProdTitle)
            textFeildConst(make: make)
        }
        
        unitPriceTitle.snp.makeConstraints { make in
            make.top.equalTo(companyProdTitle.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        unitPriceTextField.snp.makeConstraints { make in
            make.leading.equalTo(companyProdTitle.snp.trailing).offset(12)
            make.centerY.equalTo(unitPriceTitle)
            textFeildConst(make: make)
        }
        
        amountTitle.snp.makeConstraints { make in
            make.top.equalTo(unitPriceTitle.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.leading.equalTo(companyProdTitle.snp.trailing).offset(12)
            make.centerY.equalTo(amountTitle)
            textFeildConst(make: make)
        }
        
        totalCostLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTitle.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        totalCostTextField.snp.makeConstraints { make in
            make.leading.equalTo(companyProdTitle.snp.trailing).offset(12)
            make.centerY.equalTo(totalCostLabel)
            textFeildConst(make: make)
        }
        
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(totalCostLabel.snp.bottom).offset(22)
            make.leading.equalTo(20)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.leading.equalTo(companyProdTitle.snp.trailing).offset(12)
            make.centerY.equalTo(dateTitle)
            textFeildConst(make: make)
        }
        
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(103)
        }
    }
    
    func textFeildConst(make: ConstraintMaker) {
        make.trailing.lessThanOrEqualToSuperview().inset(10)
        make.width.equalTo(200)
    }
    
    func addSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(closeButton)
        view.addSubview(compName)
        view.addSubview(compPicker)
        view.addSubview(companyProdTitle)
        view.addSubview(companyProdTextField)
        view.addSubview(unitPriceTitle)
        view.addSubview(unitPriceTextField)
        view.addSubview(amountTitle)
        view.addSubview(amountTextField)
        view.addSubview(totalCostLabel)
        view.addSubview(totalCostTextField)
        view.addSubview(dateTitle)
        view.addSubview(dateTextField)
        view.addSubview(updateButton)
    }
    
    
    //MARK: - Input Accessories
    @objc func doneButtonClicked() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeStyle = .none
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Ekle", style: .plain, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    
    //MARK: - Data Operations
    func fetchData() {
        if let pured = selectedPurchase {
            companyProdTextField.text = pured.productName
            unitPriceTextField.text = pured.price
            amountTextField.text = pured.total
            totalCostTextField.text = pured.totalPrice
            dateTextField.text = pured.buyDate
        }
    }
     
}


//MARK: - Extensions
extension UpdatePurchaseTransactionsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}



extension UpdatePurchaseTransactionsViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        
        unitPriceTextField.inputAccessoryView = bar
        amountTextField.inputAccessoryView = bar
        totalCostTextField.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        companyProdTextField.endEditing(true)
        return true
    }
}
