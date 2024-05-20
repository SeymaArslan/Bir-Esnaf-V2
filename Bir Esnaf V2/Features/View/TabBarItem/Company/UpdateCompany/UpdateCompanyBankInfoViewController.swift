//
//  UpdateCompanyBankInfoViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class UpdateCompanyBankInfoViewController: UIViewController {

    // Vars
    var selectedCompany: Company?
    
    // UIs
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
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: Colors.blue)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let bankTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Bank Information"
        return label
    }()
    
    private let bankNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Bank Name"
        return label
    }()
    
    private let bankNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Bank Name"
        return textField
    }()
    
    private let branchNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Bank Branch Name"
        return label
    }()
    
    private let branchNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Bank Branch Name"
        return textField
    }()
    
    private let branchCodeTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Branch Code"
        return label
    }()
    
    private let branchCodeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Bank Code"
        return textField
    }()
    
    private let accountTypeTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Account Type (₺/$)"
        return label
    }()
    
    private let accountTypeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Account Type (₺/$)"
        return textField
    }()
    
    
    private let accountNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Account Name"
        return label
    }()
    
    private let accountNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Account Name"
        return textField
    }()
    
    private let accountNumTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Account Number"
        return label
    }()
    
    private let accountNumTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Account Number"
        return textField
    }()
    
    private let ibanTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "IBAN"
        return label
    }()
    
    private let ibanTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "IBAN"
        return textField
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        fetchData()
    }
    
    
    //MARK: - Helpers
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateButtonPressed() {
        print("updateButtonPressed")
    }
    

    //MARK: - SnapKit Functions
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
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-15)
        }
        
        bankTitle.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(20)
        }
        
        bankNameTitle.snp.makeConstraints { make in
            make.top.equalTo(bankTitle.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        bankNameTextField.snp.makeConstraints { make in
            make.top.equalTo(bankNameTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        branchNameTitle.snp.makeConstraints { make in
            make.top.equalTo(bankNameTextField.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        branchNameTextField.snp.makeConstraints { make in
            make.top.equalTo(branchNameTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        branchCodeTitle.snp.makeConstraints { make in
            make.top.equalTo(branchNameTextField.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        branchCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(branchCodeTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        accountTypeTitle.snp.makeConstraints { make in
            make.top.equalTo(branchCodeTextField.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        accountTypeTextField.snp.makeConstraints { make in
            make.top.equalTo(accountTypeTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        accountNameTitle.snp.makeConstraints { make in
            make.top.equalTo(accountTypeTextField.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        accountNameTextField.snp.makeConstraints { make in
            make.top.equalTo(accountNameTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        accountNumTitle.snp.makeConstraints { make in
            make.top.equalTo(accountNameTextField.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        accountNumTextField.snp.makeConstraints { make in
            make.top.equalTo(accountNumTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        ibanTitle.snp.makeConstraints { make in
            make.top.equalTo(accountNumTextField.snp.bottom).offset(20)
            make.leading.equalTo(21)
        }
        
        ibanTextField.snp.makeConstraints { make in
            make.top.equalTo(ibanTitle.snp.bottom).offset(11)
            textFieldConstraints(make: make)
        }
        
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(ibanTextField.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
    }
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(closeButton)
        view.addSubview(bankTitle)
        view.addSubview(bankNameTitle)
        view.addSubview(bankNameTextField)
        view.addSubview(branchNameTitle)
        view.addSubview(branchNameTextField)
        view.addSubview(branchCodeTitle)
        view.addSubview(branchCodeTextField)
        view.addSubview(accountTypeTitle)
        view.addSubview(accountTypeTextField)
        view.addSubview(accountNameTitle)
        view.addSubview(accountNameTextField)
        view.addSubview(accountNumTitle)
        view.addSubview(accountNumTextField)
        view.addSubview(ibanTitle)
        view.addSubview(ibanTextField)
        view.addSubview(updateButton)
    }

    func textFieldConstraints(make: ConstraintMaker) {
        make.leading.equalTo(21)
        make.width.equalTo(355)
        make.height.equalTo(34)
    }
    
    
    //MARK: - Data Processing Operations
    func fetchData() {
        if let comp = selectedCompany {
            bankNameTextField.text = comp.bankName
            branchNameTextField.text = comp.bankBranchName
            branchCodeTextField.text = comp.bankBranchCode
            accountTypeTextField.text = comp.bankAccountType
            accountNameTextField.text = comp.bankAccountName
            accountNumTextField.text = comp.bankAccountNum
            ibanTextField.text = comp.bankIban
        }
    }
    
    
}
