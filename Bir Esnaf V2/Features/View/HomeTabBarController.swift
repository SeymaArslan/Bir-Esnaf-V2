//
//  HomeTabBarController.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 20.05.2024.
//

import UIKit
import SnapKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()

        self.tabBar.tintColor = UIColor(named: Colors.orange)
        self.navigationItem.titleView?.tintColor = UIColor(named: Colors.blue) // olmadı
    }
    
    
    private func setupTabs() {
        
        let productTableVC = self.createNavigationVC(with: "Product", and: UIImage(systemName: "square.3.layers.3d.down.left"), vc: ProductViewController())
        let companyTableVC = self.createNavigationVC(with: "Company", and: UIImage(systemName: "person.line.dotted.person"), vc: CompanyViewController())
        let shopVC = self.createNavigationVC(with: "Shop", and: UIImage(systemName: "cart.fill"), vc: ShopViewController())
        let settingVC = self.createNavigationVC(with: "Setting", and: UIImage(systemName: "gearshape"), vc: SettingsViewController())
        
        self.setViewControllers([productTableVC, companyTableVC, shopVC, settingVC], animated: true)
    }
    
    private func createNavigationVC(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: Colors.blue)!]
        return nav
    }

}
