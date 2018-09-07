//
//  KPSavedForLater.swift
//  KPToffee
//
//  Created by UWP_MU-ny6a89 on 7/31/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation

public class KPSavedForLater {
    static let instance = KPSavedForLater()
    
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
    
    func addProduct(product: Product, quantity: Int) {
        let results = products?.filter { $0.product.productId == product.productId }
        
        if let safeResults = results {
            if safeResults.isEmpty {
                products?.append(ProductQuantity(product: product, quantity: quantity))
            } else {
                
            }
        }
    }
    
    func removeProduct(product: Product) {
        let results = products?.filter { $0.product.productId == product.productId }
        
        if let safeResults = results {
            let currentProduct = safeResults[0]
            
            if !safeResults.isEmpty {
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
