//
//  BillingAddress.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/11/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class BillingAddress: Address {
    var sameAsShipping: Bool = false
    
    override init(firstName: String, lastName: String, street: String, line2: String?, city: String, stateId: Int, zipcode: Int) {
        super.init(firstName: firstName, lastName: lastName, street: street, line2: line2, city: city, stateId: stateId, zipcode: zipcode)
    }
}
