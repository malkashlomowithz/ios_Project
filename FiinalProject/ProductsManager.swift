//
//  ProductsManager.swift
//  FiinalProject
//
//  Created by Malky on 28/06/2022.
//

import SwiftUI

class ProductsManager: ObservableObject , Identifiable {
    
    @Published var products = [Product]()
    @Published var categoryArray: Set<String>  = []
    @Published var categorizedProducts = [Product]()
    @Published var savedProduct = UserDefaults.standard.stringArray(forKey: "savedIttems") ?? [String]()
    @Published var hasProductsToShow = false
    
    init() {
        if let token = UserDefaults.standard.string(forKey: "token") {
            fetchAllProducts(token: token)
        }
    }
    func fetchAllProducts(token: String) {
        
        let url = URL(string:"https://balink-ios-learning.herokuapp.com/api/v1/products")!
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil {
                
                if let safeDate = data {
                    
                    let decodeer = JSONDecoder()
                    
                    do {
                        let decodedProducts = try decodeer.decode(Array<Product>.self, from: safeDate)
                        
                            DispatchQueue.main.async {
                            
                            self.products = decodedProducts
                            
                            print(self.products)
                            
                            for product in self.products {
                                self.categoryArray.insert(product.type)
                            }
                        }
                    } catch {
                        print("error", error)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - save products functions
    
    func saveProduct(title: String) {
        
        let userDefaults = UserDefaults.standard
        
        var array = userDefaults.stringArray(forKey: "savedIttems") ?? [String]()
        
        if array.contains(title) {
            
            array = array.filter(){$0 != title}
            
        } else {
            array.append(title)
        }
        userDefaults.set(array , forKey: "savedIttems")
        savedProduct = array
    }
    
    func deleteProducts(product: String) {
        
        let userDefaults = UserDefaults.standard
        
        var array = userDefaults.stringArray(forKey: "savedIttems") ?? [String]()
        
        array = array.filter(){$0 != product}
        
        userDefaults.set(array , forKey: "savedIttems")
        savedProduct = array
        
    }
    
}
