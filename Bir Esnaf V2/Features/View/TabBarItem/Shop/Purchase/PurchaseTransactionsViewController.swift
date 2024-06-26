//
//  PurchaseTransactionsViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//  Alım işlemleri 

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class PurchaseTransactionsViewController: UIViewController {

    private var viewModel = PurchaseTransactionsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var tableView = UITableView()
    
    struct Cells {
        static let purCell = "PurchaseCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLeftBarButton()
        setTableViewDelegates()
        configureTableView()
        createAddButton()
        createRefresh()
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.fetchPurchases(for: uid)
        }
        
        setupBindings()
    }
    

    //MARK: - Button Actions
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonTap() {
        let addPurTransVC = AddPurchaseTransactionsViewController()
        present(addPurTransVC, animated: true)
    }
    
    
    //MARK: - UIs
    private func configureLeftBarButton() {
        navigationItem.hidesBackButton = false
        navigationItem.title = "Purchase Transactions"
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(self.backButtonPressed))]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: Colors.blue)
    }
    
    func createAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: Colors.blue)
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates() // set delegates
        tableView.rowHeight = 130 // set row height
        tableView.register(PurchaseTableViewCell.self, forCellReuseIdentifier: Cells.purCell) // register cells
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
        let alertController = UIAlertController(title: "You are about to delete the Purchase Transaction", message: "Click Ok to continue", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Ok", style: .destructive) { action in
            self.deletePurchaseTransaction(at: indexPath)
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }
    
    func deletePurchaseTransaction(at indexPath: IndexPath) {
        let purchase = viewModel.purchases[indexPath.row]
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.deletePurchase(purchase.buyId!, userMail: uid)
        }
        self.viewModel.purchases.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
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
                viewModel.fetchPurchases(for: uid)
            }
            refreshControl.endRefreshing()
        }
    }
    
    
    //MARK: - Functions
    private func setupBindings() {
        viewModel.$purchases
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}


//MARK: - Extensions
extension PurchaseTransactionsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.purCell) as! PurchaseTableViewCell
        let purchase = viewModel.purchases[indexPath.row]
        cell.set(purchase: purchase)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPurchase = viewModel.purchases[indexPath.row]
        let updatePurchase = UpdatePurchaseTransactionsViewController()
        updatePurchase.selectedPurchase = selectedPurchase
        present(updatePurchase, animated: true)
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
                viewModel.fetchPurchases(for: uid)
            }
            refreshControl.endRefreshing()
        }
    }
    
}
