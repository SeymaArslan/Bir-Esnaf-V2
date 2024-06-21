//
//  CompanyViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class CompanyViewController: UIViewController {

    private var viewModel = CompanyViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var tableView = UITableView()
    
    struct Cells {
        static let compCell = "CompanyCell"
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewDelegates()
        configureTableView()
        createAddButton()
        createRefresh()
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.fetchCompanies(for: uid)
        }
        
        setupBindings()
    }
    
    @objc func addButtonTap() {
        let addCompInfo = AddCompanyInfoViewController()
        addCompInfo.viewModel = viewModel
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
        tableView.rowHeight = 70 // set row height
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
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                viewModel.fetchCompanies(for: uid)
            }
            refreshControl.endRefreshing()
        }
    }
    
    //MARK: - Functions
    private func setupBindings() {
        viewModel.$companies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}


//MARK: - Extensions
extension CompanyViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.compCell) as! CompanyTableViewCell
        let company = viewModel.companies[indexPath.row]
        cell.set(company: company)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCompany = viewModel.companies[indexPath.row]
        let compDetail = CompanyDetailViewController()
        compDetail.selectedCompany = selectedCompany
        compDetail.viewModel = viewModel
        navigationController?.pushViewController(compDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAct = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAct])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let refreshControl = scrollView.refreshControl, refreshControl.isRefreshing {
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                viewModel.fetchCompanies(for: uid)
            }
            setupBindings()
            refreshControl.endRefreshing()
        }
    }
}
