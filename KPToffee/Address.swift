//
//  Address.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/16/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class Address {
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

    convenience init(values: [String: Any?]) {
        self.init(
            firstName: values["FirstName"] as? String ?? "",
            lastName: values["LastName"] as? String ?? "",
            street: values["Street"] as? String ?? "",
            city: values["City"] as? String ?? "",
            stateId: values["StateId"] as! Int,
            zipcode: values["ZipCode"] as? Int ?? 0
        )
    }
}
