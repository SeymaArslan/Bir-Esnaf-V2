//
//  ProductViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit
import Combine
import FirebaseAuth

class ProductViewController: UIViewController {

    private var viewModel = ProductViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var tableView = UITableView()
    
    struct Cells {
        static let prodCell = "ProductCell"
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
            viewModel.fetchProducts(for: uid)
        }

        setupBindings()
    }
    
    
    //MARK: - Button Actions
    @objc func addButtonTap() {
        let addProdVC = AddProductViewController()
        present(addProdVC, animated: true)
    }
    
    
    //MARK: - Views
    func createAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates() // set delegates
        tableView.rowHeight = 123 // set row height
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: Cells.prodCell) // register cells
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
        let alertController = UIAlertController(title: "You are about to delete the product", message: "Click Ok to continue", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Ok", style: .destructive) { action in
            self.deleteProduct(at: indexPath)
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }
    
    func deleteProduct(at indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            viewModel.deleteProduct(product.prodId)
        }
        self.viewModel.products.remove(at: indexPath.row)
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
    
    
    //MARK: - Functions
    private func setupBindings() {
        viewModel.$products
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}


//MARK: - Extensions
extension ProductViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.prodCell) as! ProductTableViewCell
        let product = viewModel.products[indexPath.row]
        cell.set(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = viewModel.products[indexPath.row]
        let updateProd = UpdateProductViewController()
        updateProd.selectedProduct = selectedProduct
        updateProd.viewModel = viewModel
        present(updateProd, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAct = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAct])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let refreshControl = scrollView.refreshControl, refreshControl.isRefreshing {
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                viewModel.fetchProducts(for: uid)
            }
            setupBindings()
            refreshControl.endRefreshing()
        }
    }
    
}
