//
//  CheckoutValidationValueSet.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/11/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class CheckoutValidationValueSet {
    public var isValid: Bool = false
    public var message: String = ""
    public var stepNumber: Int
    
    init(stepNumber: Int) {
        self.stepNumber = stepNumber
    }
}
