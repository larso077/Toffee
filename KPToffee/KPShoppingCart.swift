//
//  KPShoppingCart.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/7/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class KPShoppingCart {
    static let instance = KPShoppingCart() // singleton
    
    var products: [ProductQuantity]? = []
    
    var subtotal: Float {
        get {
            var total: Float = 0
            
            if let safeProducts = products {
                total = safeProducts.reduce(total, { $0 + $1.saleTotal })
            }
            
            return total
        }
    }
    
    var tax: Float {
        get {
            var value: Float = 0
            
            if subtotal != value {
                value = subtotal * 0.055
            }
            
            return value
        }
    }
    
    var total: Float {
        get {
            return subtotal + tax
        }
    }
    
    // public accessor methods
    
    func addProduct(product: Product, quantity: Int) {
        let results = products?.filter { $0.product.productId == product.productId }
        
        if let safeResults = results {
            if !safeResults.isEmpty {
                safeResults[0].quantity += quantity
            } else {
                products?.append(ProductQuantity(product: product, quantity: quantity))
            }
        }
    }
    
    func removeProduct(product: Product, quantity: Int) {
        let results = products?.filter { $0.product.productId == product.productId }
        
        if let safeResults = results {
            let currentProduct = safeResults[0]
            
            currentProduct.quantity -= quantity
            
            if currentProduct.quantity <= 0 {
                let index = products?.index(where: { (item) -> Bool in
                    item.product.productId == product.productId
                })
                
                if let safeIndex = index {
                    products?.remove(at: safeIndex)
                }
            }
        }
    }
}

































