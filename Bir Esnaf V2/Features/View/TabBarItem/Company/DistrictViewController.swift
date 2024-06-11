//
//  DistrictViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 11.06.2024.
//

import UIKit
import SnapKit
import Combine

protocol DistrictViewControllerDelegate: AnyObject {
    func districtViewController(_ controller: DistrictViewController, didSelectDistrict district: District)
}

class DistrictViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var districtVM: DistrictViewModel!
    weak var delegate: DistrictViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    private let districtPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(districtPicker)
        
        districtPicker.dataSource = self
        districtPicker.delegate = self
        
        districtPicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func setupBindings() {
        districtVM.$districts
            .receive(on: RunLoop.main)
            .sink { [weak self] districts in
                print("Districts updated in DistrictViewController: \(districts)")
                self?.districtPicker.reloadAllComponents()
            }
            .store(in: &cancellables)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return districtVM.districts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return districtVM.districts[row].district ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDistrict = districtVM.districts[row]
        delegate?.districtViewController(self, didSelectDistrict: selectedDistrict)
    }
}
