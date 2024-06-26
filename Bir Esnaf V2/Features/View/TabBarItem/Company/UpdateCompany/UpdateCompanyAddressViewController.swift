//
//  UpdateCompanyAddressViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class UpdateCompanyAddressViewController: UIViewController {
    
    private var provinceVM = CityViewModel()
    private var districtVM = DistrictViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var provinceSelect: String?
    var provinceSelected: String?
    var districtSelect: String?
    var districtSelected: String?
    
    var upCompName: String?
    var upCompPhone: String?
    var upCompMail: String?
    
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
        label.textColor = UIColor(named: Colors.blue)
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
        label.textColor = UIColor(named: Colors.blue)
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
        fetchData()
        
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
        print("nextButtonPressed")
        let updateBank = UpdateCompanyBankInfoViewController()
        updateBank.selectedCompany = selectedCompany
        updateBank.upSelectedDistrict = districtSelect
        updateBank.upSelectedProvince = provinceSelect
        updateBank.upAsbn = ASBNTextField.text
        updateBank.upCompName = upCompName
        updateBank.upCompPhone = upCompPhone
        updateBank.upCompMail = upCompMail
        updateBank.modalPresentationStyle = .fullScreen
        present(updateBank, animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        self.view.window?.rootViewController?.dismiss(animated: true)
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
            make.top.equalTo(320)
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
    func fetchData() {
        if let comp = selectedCompany {
            ASBNTextField.text = comp.asbn
            provinceSelected = comp.province
            districtSelected = comp.district
        }
        
    }
    
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
                
                if let provinceSelected = self?.provinceSelected,
                   let provinceIndex = self?.provinceVM.provinces.firstIndex(where: { $0.province == provinceSelected }) {
                    self?.provincePicker.selectRow(provinceIndex, inComponent: 0, animated: false)
                    self?.districtVM.fetchDistricts(for: self?.provinceVM.provinces[provinceIndex].pId)
                } else if let firstProvince = self?.provinceVM.provinces.first {
                    self?.setDefaultDistrictsIfNeeded(for: firstProvince.pId)
                    self?.provinceSelect = firstProvince.province
                }
            }
            .store(in: &cancellables)
        
        districtVM.$districts
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.districtPicker.reloadAllComponents()
                
                if let districtSelected = self?.districtSelected,
                   let districtIndex = self?.districtVM.districts.firstIndex(where: { $0.district == districtSelected }) {
                    self?.districtPicker.selectRow(districtIndex, inComponent: 0, animated: false)
                    self?.districtSelect = districtSelected
                } else if let firstDistrict = self?.districtVM.districts.first?.district {
                    self?.districtSelect = firstDistrict
                }
            }
            .store(in: &cancellables)
    }
    
}


//MARK: - Extensions
extension UpdateCompanyAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        }

        if pickerView == districtPicker {
            let selectedDistrict = districtVM.districts[row]
            districtSelect = selectedDistrict.district
        }
    }
}
