//
//  Order.swift
//  KPToffee
//
//  Created by Erik Fisch on 4/29/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class Order {
    var orderId: Int = 0
    var customerId: String = ""
    var billingAddress: BillingAddress?
    var shippingAddress: Address?
    var subtotal: Float?
    var tax: Float?
    var orderDate: Date?
    var shipDate: Date?
    var shippingProvider: String?
    var trackingNumber: String?
    var paymentInfo: PaymentInformation?
    
    var products: [Product] = []
    
    // calculated
    var total: Float {
        get {
            return (subtotal ?? 0.0) + (tax ?? 0.0)
        }
    }
    
    public init() {
        
    }
}
