//
//  ProductQuantity.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/7/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class ProductQuantity {
    var product: Product
    var quantity: Int
    
    var total: Float {
        get {
            var value: Float = 0
            
            if quantity > 0 {
                value = product.price * Float(quantity)
            }
            
            return value
        }
    }
    
    var saleTotal: Float {
        get {
            var value: Float = 0
            
            if quantity > 0 {
                value = product.salePrice * Float(quantity)
            }
            
            return value
        }
    }
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}
