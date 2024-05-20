//
//  CompanyViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class CompanyViewController: UIViewController {

    var tableView = UITableView()
    var companies: [Company] = []
    
    struct Cells {
        static let compCell = "CompanyCell"
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewDelegates()
        configureTableView()
        companies = fetchData()
        createAddButton()
        createRefresh()
    }
    
    @objc func addButtonTap() {
        let addCompInfo = AddCompanyInfoViewController()
        addCompInfo.modalPresentationStyle = .fullScreen
        present(addCompInfo, animated: true, completion: nil)
    }

    
    //MARK: - Views
    func createAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates() // set delegates
        tableView.rowHeight = 75 // set row height
        tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: Cells.compCell) // register cells
        tableView.backgroundColor = UIColor(named: Colors.background)
        
        tableView.snp.makeConstraints { make in  // set constraints
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: - Helpers
    func showDeleteWarning(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "You are about to delete the company", message: "Click Ok to continue", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Ok", style: .destructive) { action in
            self.deleteProduct(at: indexPath)
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }
    
    
    func deleteProduct(at indexPath: IndexPath) {
        print("delete items")
    }
    
    func createRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: Any) {
        if let refreshControl = sender as? UIRefreshControl, refreshControl.isRefreshing {
            print("Get data function")
            refreshControl.endRefreshing()
        }
    }
    
}


//MARK: - Extensions
extension CompanyViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.compCell) as! CompanyTableViewCell
        let company = companies[indexPath.row]
        cell.set(company: company)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCompany = companies[indexPath.row]
        let compDetail = CompanyDetailViewController()
        compDetail.selectedCompany = selectedCompany
        navigationController?.pushViewController(compDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAct = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAct])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scroll")
        if let refreshControl = scrollView.refreshControl, refreshControl.isRefreshing {
            print("Get data function")
            refreshControl.endRefreshing()
        }
    }
}


extension CompanyViewController {
    func fetchData() -> [Company] {
        let data = Company(cId: "1", userMail: "@mail", compName: "Firma1", compPhone: "05745867", compMail: "@firma", province: "Ankara", district: "Çankaya", asbn: "Koru Mahallesi Yeşiltepe Evleri No: 23", bankName: "YapıKredi", bankBranchName: "Bahçelievler", bankBranchCode: "34234", bankAccountType: "Try", bankAccountName: "Firma1", bankAccountNum: "2342352", bankIban: "TR00 0000 0000 0000 0000 0000 00", count: "Firma1")
        let data2 = Company(cId: "2", userMail: "@mail", compName: "Firma2", compPhone: "453453625", compMail: "@firma2mail", province: "Bursa", district: "Osmangazi", asbn: "Paşa Mahallesi No: 22", bankName: "Garanti", bankBranchName: "Osmangazi", bankBranchCode: "34234", bankAccountType: "Try", bankAccountName: "Firma2", bankAccountNum: "2345234", bankIban: "TR00 0000 0000 0000 0000 0000 00", count: "Firma2")
        
        return [data, data2]
    }
}
