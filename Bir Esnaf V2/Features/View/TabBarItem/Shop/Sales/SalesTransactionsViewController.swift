//
//  SalesTransactionsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class SalesTransactionsViewController: UIViewController {

    private var viewModel = SaleTransactionsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var tableView = UITableView()
    
    struct Cells {
        static let saleCell = "SaleCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLeftButton()
        setTableViewDelegates()
        configureTableView()
        createAddButton()
        createRefresh()
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.fetchSales(for: uid)
        }
        
        setupBindings()
    }
    
    
    //MARK: - Button Actions
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonTap() {
        let addPurTransVC = AddSalesTransactionsViewController()
        present(addPurTransVC, animated: true)
    }
    
    
    //MARK: - UIs
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 162
        tableView.register(SalesTableViewCell.self, forCellReuseIdentifier: Cells.saleCell)
        tableView.backgroundColor = UIColor(named: Colors.background)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureLeftButton() {
        navigationItem.hidesBackButton = false
        navigationItem.title = "Sales Transactions"
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(self.backButtonPressed))]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: Colors.blue)
    }

    func createAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: Colors.blue)
    }
    

    //MARK: - Helpers
    func showDeleteWarning(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "You are about to delete the Sale Transaction", message: "Click Ok to continue", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { action in
            self.deleteSalesTransaction(at: indexPath)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func deleteSalesTransaction(at indexPath: IndexPath) {
        let sales = viewModel.sales[indexPath.row]
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.deleteSale(sales.saleId!, userMail: uid)
        }
        self.viewModel.sales.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic )
    }
    
    func createRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: Any) {
        if let refreshControl = sender as? UIRefreshControl, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    
    //MARK: - Functions
    private func setupBindings() {
        viewModel.$sales
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}


//MARK: - Extensions
extension SalesTransactionsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.saleCell) as! SalesTableViewCell
        let sale = viewModel.sales[indexPath.row]
        cell.set(sale: sale)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSale = viewModel.sales[indexPath.row]
        let updateSaleVC = UpdateSalesTransactionsViewController()
        updateSaleVC.selectedSale = selectedSale
        present(updateSaleVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let refreshControl = scrollView.refreshControl, refreshControl.isRefreshing {
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                viewModel.fetchSales(for: uid)
            }
            refreshControl.endRefreshing()
        }
    }
}
