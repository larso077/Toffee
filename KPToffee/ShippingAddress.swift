//
//  ShippingAddress.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/11/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class ShippingAddress: CustomStringConvertible {
    var firstName: String
    var lastName: String
    var street: String
    var city: String
    var state: State
    var zipcode: Int
    
    public var description: String {
        return "\(firstName) \(lastName)\r\(street)\r\(city), \(state.stateAbbreviation) \(zipcode)"
    }
    
    init(firstName: String, lastName: String, street: String, city: String, stateId: Int, zipcode: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = stateInfo.getStateById(stateId)!
        self.zipcode = zipcode
    }
}
