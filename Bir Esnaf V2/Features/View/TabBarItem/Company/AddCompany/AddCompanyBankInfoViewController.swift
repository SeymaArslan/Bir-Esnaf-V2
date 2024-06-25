//
//  AddCompanyBankInfoViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class AddCompanyBankInfoViewController: UIViewController {
    
    var viewModel = CompanyViewModel()
    
    var selectedProvince: String?
    var selectedDistrict: String?
    var asbn: String?
    
    var addCompName: String?
    var addCompPhone: String?
    var addCompMail: String?
    
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
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
    

    //MARK: - Button Actions
    @objc func cancelButtonTapped() {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @objc func saveButtonPressed() {
        addComp()
    }
    

    //MARK: - Func
    func addComp() {
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            guard let district = selectedDistrict,
                    let province = selectedProvince,
                    let compName = addCompName,
                    let compMail = addCompMail,
                    let compPhone = addCompPhone,
                    let asbn = asbn,
                    let bankName = bankNameTextField.text,
                    let branchName = branchNameTextField.text,
                    let branchCode = branchCodeTextField.text,
                    let accountType = accountTypeTextField.text,
                    let accountName = accountNameTextField.text,
                    let accountNumber = accountNumTextField.text,
                    let iban = ibanTextField.text else {
                return
            }
            
            let newCompany = CompanyBank(cbId: UUID().uuidString, userMail: uid, compName: compName, compPhone: compPhone, compMail: compMail, province: province, district: district, asbn: asbn, bankName: bankName, bankBranchName: branchName, bankBranchCode: branchCode, bankAccountType: accountType, bankAccountName: accountName, bankAccountNum: accountNumber, bankIban: iban, count: nil)
            viewModel.addCompany(newCompany)
            self.view.window?.rootViewController?.dismiss(animated: true)
        }
        
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
        
        saveButton.snp.makeConstraints { make in
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
        view.addSubview(saveButton)
    }

    func textFieldConstraints(make: ConstraintMaker) {
        make.leading.equalTo(21)
        make.width.equalTo(355)
        make.height.equalTo(34)
    }

}
