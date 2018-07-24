//
//  Product.swift
//  KPToffee
//
//  Created by Erik Fisch on 4/29/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class Product {
    var productId: Int = 0
    var name: String = ""
    var productDescription: String = ""
    var salePrice: Float = 0
    var price: Float = 0
    var SKU: String = ""
    var orderNum: Int = 0
    var stockCount: Int = 0
    var stockUnlimited: Bool = false
    var isFeatured: Bool = false
    var isActive: Bool = false
    
    var images: [String] = []
    
    public init() {
        
    }
}
