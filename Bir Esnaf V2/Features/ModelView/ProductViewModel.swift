//
//  ProductViewModel.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 28.05.2024.
//

import Foundation
import Combine
import FirebaseAuth

class ProductViewModel: ObservableObject {
    
    @Published var productData: ProductData?
    @Published var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    

    func fetchProducts(for userMail: String) {
        ProductService.shared.fetchProducts(for: userMail)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching products: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { productData in
                if let success = productData.success, success == 1 {
                    self.products = productData.product ?? []
                } else {
                    print("Failed to fetch products")
                }
            }
            .store(in: &cancellables)
    }

    func addProduct(_ product: Product) {
        ProductService.shared.addProduct(userMail: product.userMail!, prodName: product.prodName!, prodTotal: Double(product.prodTotal!) ?? 0.0, prodPrice: Double(product.prodPrice!) ?? 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error adding product: \(error)")
                case .finished:
                    print("Finished adding product")
                }
            }, receiveValue: { success in
                if success {
                    print("Product added successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to add product")
                }
            })
            .store(in: &cancellables)
    }
    
    func updateProduct(_ product: Product) {
        ProductService.shared.updateProduct(userMail: product.userMail!, prodId: product.prodId!, prodName: product.prodName!, prodTotal: Double(product.prodTotal!) ?? 0.0, prodPrice: Double(product.prodPrice!) ?? 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error update product: \(error)")
                case .finished:
                    print("Finished update product")
                }
            }, receiveValue: { success in
                if success {
                    print("Product update successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to update product")
                }
            })
            .store(in: &cancellables)
    }

    func deleteProduct(_ productId: String, userMail: String) {
        ProductService.shared.deleteProduct(productId, userMail: userMail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error deleting product: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    print("Product deleted successfully")
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        self.fetchProducts(for: uid)
                    }
                } else {
                    print("Failed to delete product")
                }
            })
            .store(in: &cancellables)
    }
    
    
}


 
/*
 old web servis
 <?php
 $response = array();

 if (isset($_POST['userMail']) && isset($_POST['prodId'])) {
     $userMail = $_POST['userMail'];
     $prodId = $_POST['prodId'];

     //DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE değişkenleri alınır.
     require_once __DIR__ . '/db_config.php';
     
     // Bağlantı oluşturuluyor.
     $baglanti = mysqli_connect(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
     
     // Bağlanti kontrolü yapılır.
     if (!$baglanti) {
         die("Hatalı bağlantı : " . mysqli_connect_error());
     }
     $sqlsorgu = "DELETE FROM product WHERE product.prodId = '$prodId' AND product.userMail = '$userMail'";
     
     if (mysqli_query($baglanti, $sqlsorgu)) {
         
         $response["success"] = 1;
         $response["message"] = "successfully ";
         echo json_encode($response);
     } else {
         
         $response["success"] = 0;
         $response["message"] = "No product found";
         echo json_encode($response);
     }
     //bağlantı koparılır.
     mysqli_close($baglanti);
 } else {
     $response["success"] = 0;
     $response["message"] = "Required field(s) is missing";
     echo json_encode($response);
 }
 ?>

 
 */
