//
//  AddProductViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class AddProductViewController: UIViewController {
    
    var viewModel = ProductViewModel()
    
    //MARK: - Create UI
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    private let prodNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let prodNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let costTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let costTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let amountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: Colors.blue)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Snapkit Func
    func configuration() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(prodNameLabel)
        view.addSubview(prodNameTextField)
        view.addSubview(costTitleLabel)
        view.addSubview(costTextField)
        view.addSubview(amountTitleLabel)
        view.addSubview(amountTextField)
        view.addSubview(saveButton)
        view.addSubview(closeButton)
        
        prodNameLabel.text = "Product Name"
        costTitleLabel.text = "Cost"
        amountTitleLabel.text = "Amount"
        
        prodNameTextField.placeholder = "Product Name"
        costTextField.placeholder = "0 ₺"
        amountTextField.placeholder = "0 Pieces/Kg"
        
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
        
        prodNameLabel.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(20)
        }
        
        prodNameTextField.snp.makeConstraints { make in
            make.top.equalTo(prodNameLabel.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        costTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(prodNameTextField.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        costTextField.snp.makeConstraints { make in
            make.top.equalTo(costTitleLabel.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        amountTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(costTextField.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(amountTitleLabel.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
    //MARK: - Button Actions
    @objc func saveButtonPressed(_ sender: UIButton) {
        print("Button pressed")
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            guard let productName = prodNameTextField.text,
                  let productTotal = costTextField.text?.replacingOccurrences(of: ",", with: "."),
                  let productPrice = amountTextField.text?.replacingOccurrences(of: ",", with: "."),
                  let doubleTotal = Double(productTotal),
                  let doublePrice = Double(productPrice) else {
                return
            }

            let newProduct = Product(prodId: UUID().uuidString, userMail: uid, prodName: productName, prodTotal: productTotal, prodPrice: productPrice, count: nil)
            viewModel.addProduct(newProduct)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
}


//MARK: - Extensions
