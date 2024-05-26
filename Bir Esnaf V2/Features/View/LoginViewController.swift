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
        label.isHidden = true
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
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
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
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor(named: Colors.labelColourful)
        return label
    }()
    
    private let passReplyTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.placeholder = "Repeat Password"
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let passReplyView: UIView = {
        let view = UIView()
        view.isHidden = true
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
        button.isHidden = true
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
    
    
    //MARK: - Vars
    var isLogin = true
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        updateUIFor(login: true)
        setupTextFieldDelegates()
        setupBackgroundTap()
    }
    
    
    //MARK: - Button Actions
    @objc func loginButtonPressed() {
        print("bastım")
        if isDataInputedFor(type: isLogin ? "login" : "register") {
            isLogin ? loginUser() : registerUser()
        } else {
            showError(message: "All Fields are required")
        }
    }
    
    @objc func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Login")
        isLogin.toggle()
    }
    
    @objc func resendEmailButtonPressed() {
        if isDataInputedFor(type: "password") {
            resendVerificationEmail()
        } else {
            showError(message: "Email is required.")
        }
    }
    
    @objc func forgotPasswordButtonPressed() {
        if isDataInputedFor(type: "password") {
            resetPassword()
        } else {
            showError(message: "Email is required.")
        }
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
            make.leading.equalTo(65)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(infoSignUpLabel.snp.trailing).inset(65)
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
    }
    
    func textFieldConfig(make: ConstraintMaker) {
        make.leading.equalTo(1)
        make.trailing.equalTo(1)
        make.width.equalTo(361)
    }
    
    func labelConfig(make: ConstraintMaker) {
        make.leading.equalTo(1)
        make.trailing.equalTo(1)
        make.width.equalTo(361)
        make.height.equalTo(24)
    }
    
    func viewConfig(make: ConstraintMaker) {
        make.leading.equalTo(1)
        make.trailing.equalTo(1)
        make.height.equalTo(2)
        make.width.equalTo(355)
    }
    
    
    //MARK: - Setup
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(textField: textField)
    }
    
    private func setupTextFieldDelegates() {
        mailTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        passReplyTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        
    }
    
    //MARK: - Animations
    private func updateUIFor(login: Bool) {
        loginButton.setTitle(login ? "LOGIN" : "REGISTER", for: .normal)
        signUpButton.setTitle(login ? "SignUp" : "Login", for: .normal)
        infoSignUpLabel.text = login ? "Don't have an account?" : "Have an account?"
        
        UIView.animate(withDuration: 0.5) {
            self.passReplyTextField.isHidden = login
            self.passReplyView.isHidden = login
//            self.passReplyLabel.isHidden = login
        }
    }
    
    private func updatePlaceholderLabels(textField: UITextField) {
        switch textField {
        case mailTextField:
            mailLabel.isHidden = !textField.hasText
        case passwordTextField:
            passLabel.isHidden = !textField.hasText
        default:
            passReplyLabel.isHidden = !textField.hasText
        }
    }
    
    
    //MARK: - Helpers
    private func loginUser() {
        FirebaseUserListener.shared.loginUserWithEmail(email: mailTextField.text!, password: passwordTextField.text!) { error, isEmailVerified in
            if error == nil {
                if isEmailVerified {
                    self.goToApp()
                } else {
                    self.showError(message: "Please verify email.")
                    self.resendEmailButton.isHidden = false
                }
            } else {
                self.showError(message: error!.localizedDescription)
            }
        }
    }
    
    private func registerUser() {
        if passwordTextField.text! == passReplyTextField.text! {
            FirebaseUserListener.shared.registerUserWith(email: mailTextField.text!, password: passwordTextField.text!) { error in
                DispatchQueue.main.async {
                    if error == nil {
                        self.showSuccess(message: "Verification email sent.")
                        self.resendEmailButton.isHidden = false
                    } else {
                        self.showError(message: error!.localizedDescription)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.showError(message: "The Passwords don't match")
            }
            print("Passwords do not match: \(passwordTextField.text!) != \(passReplyTextField.text!)")
        }
    }
    
    private func resetPassword() {
        FirebaseUserListener.shared.resetPasswordFor(email: mailTextField.text!) { error in
            if error == nil {
                self.showSuccess(message: "Reset link send to email.")
            } else {
                self.showError(message: error!.localizedDescription)
            }
        }
    }
    
    
    private func resendVerificationEmail() {
        FirebaseUserListener.shared.resendVerificationEmail(email: mailTextField.text!) { error in
            if error == nil {
                self.showSuccess(message: "New verification email sent.")
            } else {
                self.showSuccess(message: error!.localizedDescription)
            }
        }
    }
    
    
    private func isDataInputedFor(type: String) -> Bool {
        switch type {
        case "login":
            return mailTextField.text != "" && passwordTextField.text != ""
        case "register":
            return mailTextField.text != "" && passwordTextField.text != "" && passReplyTextField.text != ""
        default:
            return mailTextField.text != ""
        }
    }
    
    
    private func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    private func showSuccess(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }

    
    //MARK: - Navigation
    private func goToApp() {
        let homeVC = HomeTabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
    
}
