//
//  RetailLocation.swift
//  KPToffee
//
//  Created by UWP_MU-gfkzby on 8/14/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation


public class RetailLocation {
    var name: String
    var address: String
    var city: String
    var state: String
    var zipcode: Int
    var lat: Double
    var lon: Double
    
    init(name: String, address: String, city: String, state: String, zipcode: Int, lat: Double, lon: Double) {
        self.name = name
        self.address = address
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.lon = lat
        self.lat = lon
    }
}
