//
//  LoginViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
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
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.logoCalculate)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let mailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let mailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let mailView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let passView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let passReplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat Password"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let passReplyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat Password"
        return textField
    }()
    
    private let passReplyView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let resendEmailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resend Email", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.addTarget(self, action: #selector(resendEmailButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 26)
        config.title = "LOGIN"
        config.cornerStyle = .large
        config.baseBackgroundColor = UIColor(named: Colors.blue)
        config.attributedTitle = AttributedString("LOGIN", attributes: container)
        button.configuration = config
        button.setTitleColor(UIColor(named: Colors.labelColourful), for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let infoSignUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Have not account?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: Colors.label)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalCentering //.fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    
    //MARK: - Button Actions
    @objc func loginButtonPressed() {
        
    }
    
    @objc func signUpButtonPressed() {
        
    }
    
    @objc func resendEmailButtonPressed() {
        
    }
    
    @objc func forgotPasswordButtonPressed() {
        
    }
    
    
    //MARK: - Snapokit Functions
    func configure() {
        addSubviews()
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(80)
            make.height.equalTo(197)
            make.width.equalTo(186)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(iconImage.snp.bottom).offset(35)
        }
        
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(0)
            labelConfig(make: make)
        }
        
        mailTextField.snp.makeConstraints { make in
            make.top.equalTo(mailLabel.snp.bottom).offset(10)
            textFieldConfig(make: make)
        }
        
        mailView.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(10)
            viewConfig(make: make)
        }
        
        passLabel.snp.makeConstraints { make in
            make.top.equalTo(mailView.snp.bottom).offset(20)
            labelConfig(make: make)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passLabel.snp.bottom).offset(10)
            textFieldConfig(make: make)
        }
        
        passView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            viewConfig(make: make)
        }
        
        passReplyLabel.snp.makeConstraints { make in
            make.top.equalTo(passView.snp.bottom).offset(20)
            labelConfig(make: make)
        }
        
        passReplyTextField.snp.makeConstraints { make in
            make.top.equalTo(passReplyLabel.snp.bottom).offset(10)
            textFieldConfig(make: make)
        }
        
        passReplyView.snp.makeConstraints { make in
            make.top.equalTo(passReplyTextField.snp.bottom).offset(10)
            viewConfig(make: make)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(20)
            make.leading.lessThanOrEqualToSuperview().inset(2)
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
        
        resendEmailButton.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(20)
            make.leading.equalTo(forgotPasswordButton.snp.trailing).offset(50)
            make.width.equalTo(170)
            make.height.equalTo(30)
            make.centerY.equalTo(forgotPasswordButton)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(55)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(loginButton.snp.bottom).offset(70)
        }
        
        infoSignUpLabel.snp.makeConstraints { make in
            make.leading.equalTo(70)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(infoSignUpLabel.snp.trailing).inset(80)
        }
        
    }
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(iconImage)
        view.addSubview(infoStackView)
        infoStackView.addArrangedSubview(mailLabel)
        infoStackView.addArrangedSubview(mailTextField)
        infoStackView.addArrangedSubview(mailView)
        infoStackView.addArrangedSubview(passLabel)
        infoStackView.addArrangedSubview(passwordTextField)
        infoStackView.addArrangedSubview(passView)
        infoStackView.addArrangedSubview(passReplyLabel)
        infoStackView.addArrangedSubview(passReplyTextField)
        infoStackView.addArrangedSubview(passReplyView)
        view.addSubview(forgotPasswordButton)
        view.addSubview(resendEmailButton)
        view.addSubview(loginButton)
        view.addSubview(signUpStackView)
        signUpStackView.addArrangedSubview(infoSignUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
//        view.addSubview(infoSignUpLabel)
//        view.addSubview(signUpButton)
    }
    
    func textFieldConfig(make: ConstraintMaker) {
        make.leading.equalTo(0)
        make.trailing.equalTo(0)
        make.width.equalTo(361)
    }
    
    func labelConfig(make: ConstraintMaker) {
        make.leading.equalTo(0)
        make.trailing.equalTo(0)
        make.width.equalTo(361)
    }
    
    func viewConfig(make: ConstraintMaker) {
        make.leading.equalTo(0)
        make.trailing.equalTo(0)
        make.height.equalTo(2)
        make.width.equalTo(355)
    }
}
