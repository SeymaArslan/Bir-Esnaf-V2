//
//  AddCompanyInfoViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class AddCompanyInfoViewController: UIViewController {

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
    
    private let compNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        label.text = "Company Name"
        return label
    }()
    
    private let compNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.placeholder = "Company Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        label.text = "Phone"
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .numberPad
        textField.placeholder = "Phone"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let mailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        label.text = "Email"
        return label
    }()
    
    private let mailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .emailAddress
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    
    }
    
    //MARK: - Button Actions
    @objc func nextButtonPressed() {
        print("nextButtonPressed")
        let addCompAddress = AddCompanyAddressViewController()
        addCompAddress.addCompName = compNameTextField.text
        addCompAddress.addCompPhone = phoneTextField.text
        addCompAddress.addCompMail = mailTextField.text
        addCompAddress.modalPresentationStyle = .fullScreen
        present(addCompAddress, animated: true, completion: nil)
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func configuration() {
        addSubview()
        
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
        
        compNameLabel.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(20)
        }
        
        compNameTextField.snp.makeConstraints { make in
            make.top.equalTo(compNameLabel.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        phoneTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(compNameTextField.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTitleLabel.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        mailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        mailTextField.snp.makeConstraints { make in
            make.top.equalTo(mailTitleLabel.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
        }
    }
    
    func addSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(compNameLabel)
        view.addSubview(compNameTextField)
        view.addSubview(phoneTitleLabel)
        view.addSubview(phoneTextField)
        view.addSubview(mailTitleLabel)
        view.addSubview(mailTextField)
        view.addSubview(nextButton)
        view.addSubview(closeButton)
    }

}
