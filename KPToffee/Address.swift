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
    var line2 : String?
    var state: State
    var zipcode: Int
    
    public var description: String {
        return "\(firstName) \(lastName)\r\(street)\r\(line2 ?? "")\r\(city), \(state.stateAbbreviation) \(zipcode)"
    }
    
    init(firstName: String, lastName: String, street: String, line2: String?, city: String, stateId: Int, zipcode: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.line2 = line2
        self.city = city
        self.state = stateInfo.getStateById(stateId)!
        self.zipcode = zipcode
    }
    
    convenience init(values: [String: Any?]) {
        self.init(
            firstName: values["FirstName"] as? String ?? "",
            lastName: values["LastName"] as? String ?? "",
            street: values["Street"] as? String ?? "",
            line2: values["Line 2"] as? String ?? "",
            city: values["City"] as? String ?? "",
            stateId: values["StateId"] as! Int,
            zipcode: values["ZipCode"] as? Int ?? 0
        )
    }
}
