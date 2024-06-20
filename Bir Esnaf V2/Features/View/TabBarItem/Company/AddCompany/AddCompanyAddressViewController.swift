//
//  AddCompanyAddressViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class AddCompanyAddressViewController: UIViewController {
    
    private let provinceVM = CityViewModel()
    private let districtVM = DistrictViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var provinceSelect: String?
    var districtSelect: String?
    
    var addCompName: String?
    var addCompPhone: String?
    var addCompMail: String?
    
    
    
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
    
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: Colors.labelColourful)
        label.text = "Address"
        return label
    }()
    
    private let provincePicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let districtTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.labelColourful)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "District"
        return label
    }()
    
    private let districtPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let ASBNTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.labelColourful)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Avenue/Street/Building/Number"
        return label
    }()
    
    private let ASBNTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: Colors.label)
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.placeholder = "Avenue/Street/Building/Number"
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
        
        
        addDelegate()
        configuration()
        
        provinceVM.fetchProvinces()
        
        setupBindings()
    }
    
    
    //MARK: - Delegates
    func addDelegate() {
        provincePicker.delegate = self
        provincePicker.dataSource = self
        
        districtPicker.delegate = self
        districtPicker.dataSource = self
    }
    
    
    //MARK: - Actions
    @objc func nextButtonPressed() {
        let addCompBank = AddCompanyBankInfoViewController()
        addCompBank.selectedDistrict = districtSelect
        addCompBank.selectedProvince = provinceSelect
        addCompBank.asbn = ASBNTextField.text
        addCompBank.addCompName = addCompName
        addCompBank.addCompPhone = addCompPhone
        addCompBank.addCompMail = addCompMail
        addCompBank.modalPresentationStyle = .fullScreen
        present(addCompBank, animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Snapkit Func
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
        
        addressTitle.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(20)
        }
        
        provincePicker.snp.makeConstraints { make in
            make.top.equalTo(addressTitle.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        districtTitle.snp.makeConstraints { make in
            make.top.equalTo(provincePicker.snp.bottom)
            make.leading.equalTo(20)
        }
        
        districtPicker.snp.makeConstraints { make in
            make.top.equalTo(districtTitle.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        ASBNTitle.snp.makeConstraints { make in
            make.top.equalTo(580)
            make.leading.equalTo(20)
        }
        
        ASBNTextField.snp.makeConstraints { make in
            make.top.equalTo(ASBNTitle.snp.bottom).offset(11)
            make.leading.equalTo(21)
            make.width.equalTo(355)
            make.height.equalTo(34)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(ASBNTextField.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
    }
    
    func addSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(contentView)
        view.addSubview(addressTitle)
        view.addSubview(provincePicker)
        view.addSubview(districtTitle)
        view.addSubview(districtPicker)
        view.addSubview(ASBNTitle)
        view.addSubview(ASBNTextField)
        view.addSubview(nextButton)
        view.addSubview(closeButton)
    }
    
    
    //MARK: - Func
    func setDefaultDistrictsIfNeeded(for provinceId: String?) {
        guard let provinceId = provinceId else { return }
        if districtVM.defaultDistricts.isEmpty {
            districtVM.fetchDistricts(for: provinceId)
            
        } else {
            districtVM.districts = districtVM.defaultDistricts
        }

    }
    
    func setupBindings() {
        
        provinceVM.$provinces
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.provincePicker.reloadAllComponents()
                if let firstProvince = self?.provinceVM.provinces.first {
                    self?.setDefaultDistrictsIfNeeded(for: firstProvince.pId)
                    self!.provinceSelect = firstProvince.province  // tamam
                }
            }
            .store(in: &cancellables)
        
        districtVM.$districts
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.districtPicker.reloadAllComponents()
                if let firstDistrict = self?.districtVM.districts.first?.district {
                    self?.districtSelect = firstDistrict
                }
            }
            .store(in: &cancellables)
    }
    
}



//MARK: - Extensions
extension AddCompanyAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == provincePicker {
            return provinceVM.provinces.count
        } else if pickerView == districtPicker {
            return districtVM.districts.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == provincePicker {
            return provinceVM.provinces[row].province
        } else if pickerView == districtPicker {
            //return String(districtVM.districts.count)
            return districtVM.districts[row].district
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == provincePicker {
            let selectedProvince = provinceVM.provinces[row]
            provinceSelect = selectedProvince.province
            districtVM.fetchDistricts(for: selectedProvince.pId!)
            if let test = provinceSelect {
                print("province select = \(test)")
            }
        }

        if pickerView == districtPicker {
            let selectedDistrict = districtVM.districts[row]
            districtSelect = selectedDistrict.district
            if let test2 = districtSelect {
                print("district select = \(test2)")
            }
        }
    }
    
}
