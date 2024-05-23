//
//  ProductViewController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {

    var tableView = UITableView()
    var products: [Product] = []
    
    struct Cells {
        static let prodCell = "ProductCell"
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewDelegates()
        products = fetchData()
        configureTableView()
        createAddButton()
        createRefresh()
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
        tableView.rowHeight = 120 // set row height
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
    
    
    //MARK: - Functions

    
}


//MARK: - Extensions
extension ProductViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.prodCell) as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.set(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        let updateProd = UpdateProductViewController()
        updateProd.selectedProduct = selectedProduct
        present(updateProd, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAct = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
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


extension ProductViewController {
    func fetchData() -> [Product] {
        let data = Product(prodId: "1", userMail: "deneme", prodName: "deneme", prodTotal: "50", prodPrice: "0 ₺", count: "2")
        let data2 = Product(prodId: "2", userMail: "deneme2", prodName: "deneme2", prodTotal: "100", prodPrice: "55 ₺", count: "deneme2")
        let data3 = Product(prodId: "3", userMail: "deneme3", prodName: "deneme3", prodTotal: "30", prodPrice: "120 ₺", count: "deneme3")
        return [data, data2, data3]
    }
}
