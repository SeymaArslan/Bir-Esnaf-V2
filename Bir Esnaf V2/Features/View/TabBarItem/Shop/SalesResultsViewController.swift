//
//  SalesResultsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class SalesResultsViewController: UIViewController {

    var data: [String] = ["Test1", "Test2", "Test3", "Test4", "Test5", "Test6",  "Test7",  "Test8",  "Test9", "Test10"]
    
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
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: Colors.blue)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let prodSoldTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: Colors.blue)
        label.text = "Products Sold"
        return label
    }()
    
    private let prodSoldPicker: UIPickerView = {
      let picker = UIPickerView()
        
        return picker
    }()
    
    private let pickerPATitleview: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: Colors.blue)
        return view
    }()
    
    private let prodSalesProfitAmountTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.label)
        label.text = "Product Sales Profit Amount:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let prodSalesProfitAmount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.orange)
        label.text = "0 ₺"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let totalProfitAmountTitle: UILabel = {
        let label = UILabel()
        label.text = "Total Profit Amount Title:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(named: Colors.label)
        return label
    }()
    
    private let totalProfitAmount: UILabel = {
        let label = UILabel()
        label.text = "0 ₺"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(named: Colors.orange)
        return label
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(UIColor(named: Colors.orange), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let calDelView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: Colors.blue)
        return view
    }()
    
    private let deleteListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete List", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(deleteListButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addDelegates()
        configuration()
    }
    
    //MARK: - Delegates
    func addDelegates() {
        prodSoldPicker.delegate = self
        prodSoldPicker.dataSource = self
    }
    

//MARK: - Button Actions
    @objc func deleteListButtonPressed() {
        print("deleteListButtonPressed")
    }
    
    @objc func calculateButtonPressed() {
        print("calculateButtonPressed")
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Snapkit Functions
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
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        prodSoldTitle.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(20)
        }
        
        prodSoldPicker.snp.makeConstraints { make in
            make.top.equalTo(prodSoldTitle.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        pickerPATitleview.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(prodSoldPicker.snp.bottom).offset(10)
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        prodSalesProfitAmountTitle.snp.makeConstraints { make in
            make.top.equalTo(pickerPATitleview.snp.bottom).offset(30)
            make.leading.equalTo(50)
        }
        
        prodSalesProfitAmount.snp.makeConstraints { make in
            make.leading.equalTo(prodSalesProfitAmountTitle.snp.trailing).offset(10)
            make.centerY.equalTo(prodSalesProfitAmountTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        totalProfitAmountTitle.snp.makeConstraints { make in
            make.leading.equalTo(prodSalesProfitAmountTitle.snp.leading)
            make.top.equalTo(prodSalesProfitAmountTitle.snp.bottom).offset(20)
        }

        
        totalProfitAmount.snp.makeConstraints { make in
            make.leading.equalTo(totalProfitAmountTitle.snp.trailing).offset(10)
            make.centerY.equalTo(totalProfitAmountTitle)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(prodSalesProfitAmount.snp.leading)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.top.equalTo(totalProfitAmountTitle.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(27)
        }
        
        calDelView.snp.makeConstraints { make in
            make.top.equalTo(calculateButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(325)
        }
        
        deleteListButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calDelView.snp.bottom).offset(130)
            make.height.equalTo(30)
            make.width.equalTo(180)
        }
    }
    
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(closeButton)
        view.addSubview(prodSoldTitle)
        view.addSubview(prodSoldPicker)
        view.addSubview(pickerPATitleview)
        view.addSubview(prodSalesProfitAmountTitle)
        view.addSubview(prodSalesProfitAmount)
        view.addSubview(totalProfitAmountTitle)
        view.addSubview(totalProfitAmount)
        view.addSubview(calculateButton)
        view.addSubview(calDelView)
        view.addSubview(deleteListButton)
    }
    
}


extension SalesResultsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
