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
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(named: Colors.labelColourful), for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let resendEmailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resend Email", for: .normal)
        button.setTitleColor(UIColor(named: Colors.labelColourful), for: .normal)
        button.addTarget(self, action: #selector(resendEmailButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
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
        button.setTitleColor(UIColor(named: Colors.labelColourful), for: .normal)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
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
            make.top.equalTo(100)
            make.height.equalTo(197)
            make.width.equalTo(186)
        }
    }
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(iconImage)
//        view.addSubview(mailLabel)
//        view.addSubview(mailTextField)
//        view.addSubview(mailView)
//        view.addSubview(passLabel)
//        view.addSubview(passwordTextField)
//        view.addSubview(passView)
//        view.addSubview(passReplyLabel)
//        view.addSubview(passReplyTextField)
//        view.addSubview(passReplyView)
//        view.addSubview(forgotPasswordButton)
//        view.addSubview(resendEmailButton)
//        view.addSubview(loginButton)
//        view.addSubview(infoSignUpLabel)
//        view.addSubview(signUpButton)
    }
}
