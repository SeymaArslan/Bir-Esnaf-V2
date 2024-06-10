//
//  CompanyDetailViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class CompanyDetailViewController: UIViewController {

    var viewModel = CompanyViewModel()
    var selectedCompany: CompanyBank?
    
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
    
    private let compNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Company Name:"
        return label
    }()
    
    private let compName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 2
        label.textAlignment = .left // test et
        return label
    }()
    
    private let phoneTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Phone:"
        return label
    }()
    
    private let phone: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let mailTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Email:"
        return label
    }()
    
    private let mail: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let separatingViewMA: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Colors.blue)
        return view
    }()
    
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Address:"
        return label
    }()
    
    private let address: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 3
        label.textAlignment = .left // test et
        return label
    }()
    
    private let separateingViewAB: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Colors.blue)
        return view
    }()
    
    private let bankInfoTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.text = "Banka Bilgileri"
        return label
    }()
    
    private let bankNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Bank Name:"
        return label
    }()
    
    private let bankName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let ibanTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "IBAN:"
        return label
    }()
    
    private let iban: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let accountNumberTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Account No:"
        return label
    }()
    
    private let accountNumber: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let accountNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Account Name:"
        return label
    }()
    
    private let accountName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let branchCodeTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Branch Code"
        return label
    }()
    
    private let branchCode: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let branchNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Branch Name"
        return label
    }()
    
    private let branchName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.setTitleColor(UIColor(named: Colors.background), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(named: Colors.blue)
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        button.configuration?.cornerStyle = .large
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLeftBarButton()
        configuration()
    }
    
    
    //MARK: - Button Actions
    @objc func updateButtonPressed() {
        print("updateButtonPressed")
        let updateCompInfo = UpdateCompanyInfoViewController()
        updateCompInfo.selectedCompany = selectedCompany
        updateCompInfo.modalPresentationStyle = .fullScreen
        present(updateCompInfo, animated: true, completion: nil)
    }
    
    
    //MARK: - Helpers
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureLeftBarButton() {
        navigationItem.hidesBackButton = false
        navigationItem.title = "Company"
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(self.backButtonPressed))]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "customColor2")
    }
    
    
    //MARK: - Snapkit
    func configuration() {
        addSubview()
        fetchComp()

        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        compNameTitle.snp.makeConstraints { make in
            make.top.equalTo(110)
            make.leading.equalTo(16)
            make.width.equalTo(130)
        }
        
        compName.snp.makeConstraints { make in
            make.leading.equalTo(compNameTitle.snp.trailing).offset(10)
            make.centerY.equalTo(compNameTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        phoneTitle.snp.makeConstraints { make in
            make.top.equalTo(155)
            make.leading.equalTo(17)
        }
        
        phone.snp.makeConstraints { make in
            make.leading.equalTo(phoneTitle.snp.trailing).offset(10)
            make.centerY.equalTo(phoneTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)   // test et hepsinde de
            make.leading.equalTo(compName.snp.leading)
        }
        
        mailTitle.snp.makeConstraints { make in
            make.top.equalTo(185)
            make.leading.equalTo(17)
        }
        
        mail.snp.makeConstraints { make in
            make.leading.equalTo(mailTitle.snp.trailing).offset(10)
            make.centerY.equalTo(mailTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        separatingViewMA.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mailTitle.snp.bottom).offset(35)   // mail or mailTitle?
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        addressTitle.snp.makeConstraints { make in
            make.top.equalTo(280)
            make.leading.equalTo(17)
            //make.centerX.equalTo(separatingViewMA.snp.bottom)  // test et
            //make.centerX.equalTo(separateingViewAB.snp.top)
        }
        
        address.snp.makeConstraints { make in
            make.leading.equalTo(addressTitle.snp.trailing).offset(10)
            make.centerY.equalTo(addressTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        separateingViewAB.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(addressTitle.snp.bottom).offset(50)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        bankInfoTitle.snp.makeConstraints { make in
            make.top.equalTo(380)
            make.leading.equalTo(16)
        }
        
        bankNameTitle.snp.makeConstraints { make in
            make.top.equalTo(415)
            make.leading.equalTo(17)
        }
        
        bankName.snp.makeConstraints { make in
            make.leading.equalTo(bankNameTitle.snp.trailing).offset(10)
            make.centerY.equalTo(bankNameTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        ibanTitle.snp.makeConstraints { make in
            make.top.equalTo(455)
            make.leading.equalTo(16)
        }
        
        iban.snp.makeConstraints { make in
            make.leading.equalTo(ibanTitle.snp.trailing).offset(10)
            make.centerY.equalTo(ibanTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        accountNumberTitle.snp.makeConstraints { make in
            make.top.equalTo(495)
            make.leading.equalTo(16)
        }
        
        accountNumber.snp.makeConstraints { make in
            make.leading.equalTo(accountNumberTitle.snp.trailing).offset(10)
            make.centerY.equalTo(accountNumberTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        accountNameTitle.snp.makeConstraints { make in
            make.top.equalTo(525)
            make.leading.equalTo(16)
        }
        
        accountName.snp.makeConstraints { make in
            make.leading.equalTo(accountNameTitle.snp.trailing).offset(10)
            make.centerY.equalTo(accountNameTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        branchCodeTitle.snp.makeConstraints { make in
            make.top.equalTo(555)
            make.leading.equalTo(16)
        }
        
        branchCode.snp.makeConstraints { make in
            make.leading.equalTo(branchCodeTitle.snp.trailing).offset(10)
            make.centerY.equalTo(branchCodeTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        branchNameTitle.snp.makeConstraints { make in
            make.top.equalTo(585)
            make.leading.equalTo(16)
        }
        
        branchName.snp.makeConstraints { make in
            make.leading.equalTo(branchNameTitle.snp.trailing).offset(10)
            make.centerY.equalTo(branchNameTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(compName.snp.leading)
        }
        
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(branchNameTitle.snp.bottom).offset(85)
            make.centerX.equalToSuperview()
            make.width.equalTo(113)
            make.height.equalTo(35)
        }
    }
    
    
    //MARK: - Function
    func addSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(compNameTitle)
        view.addSubview(compName)
        view.addSubview(phoneTitle)
        view.addSubview(phone)
        view.addSubview(mailTitle)
        view.addSubview(mail)
        view.addSubview(separatingViewMA)
        view.addSubview(addressTitle)
        view.addSubview(address)
        view.addSubview(separateingViewAB)
        view.addSubview(bankInfoTitle)
        view.addSubview(bankNameTitle)
        view.addSubview(bankName)
        view.addSubview(ibanTitle)
        view.addSubview(iban)
        view.addSubview(accountNumberTitle)
        view.addSubview(accountNumber)
        view.addSubview(accountNameTitle)
        view.addSubview(accountName)
        view.addSubview(branchCodeTitle)
        view.addSubview(branchCode)
        view.addSubview(branchNameTitle)
        view.addSubview(branchName)
        view.addSubview(updateButton)
    }
    
    func fetchComp() {
        if let comp = selectedCompany {
            compName.text = comp.compName
            phone.text = comp.compPhone
            mail.text = comp.compMail
            if let asbn = comp.asbn, let quarter = comp.quarter, let district = comp.district, let province = comp.province {
                address.text = quarter + " " + asbn + " " + district + " " + province
            }
//            address.text = comp.asbn + " " + comp.district + " " + comp.province
            bankName.text = comp.bankName
            iban.text = comp.bankIban
            accountNumber.text = comp.bankAccountNum
            accountName.text = comp.bankAccountName
            branchCode.text = comp.bankBranchCode
            branchName.text = comp.bankBranchName
        }
    }
    
}
