//
//  SettingsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
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
    
    private let separatingViewST: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        return view
    }()
    
    private let separatingViewLD: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        return view
    }()
    
    private let shareFriendsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share With Your Friends", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(shareFriendButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let termsAndConditionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms And Conditions", for: .normal)
        button.setTitleColor(UIColor(named: Colors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(termsAndConditionsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Account", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(deleteAccountButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: Colors.background)
        
        configuration()
    }
    
    
    //MARK: - Snapkit Func
    func configuration() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(shareFriendsButton)
        view.addSubview(separatingViewST)
        view.addSubview(termsAndConditionsButton)
        view.addSubview(separatingViewLD)
        view.addSubview(logOutButton)
        view.addSubview(deleteAccountButton)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shareFriendsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(180)
        }
        
        separatingViewST.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shareFriendsButton.snp.bottom).offset(20)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shareFriendsButton.snp.bottom).offset(40)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsAndConditionsButton.snp.bottom).offset(180)
        }
        
        separatingViewLD.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logOutButton.snp.bottom).offset(20)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logOutButton.snp.bottom).offset(40)
        }
        
        
    }

    
    //MARK: - Button Actions
    @objc func shareFriendButtonPressed() {
        print("shareFriendButtonPressed")
    }
    
    @objc func termsAndConditionsButtonPressed() {
        print("termsAndConditionsButtonPressed")
    }
    
    @objc func logOutButtonPressed() {
        print("termsAndConditionsButtonPressed")
    }
    
    @objc func deleteAccountButtonPressed() {
        print("deleteAccountButtonPressed")
    }
    
}
