//
//  CheckoutValuesHolder.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/10/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public protocol CheckoutValuesHolder {
    func getValues() -> CheckoutValueSet
    func validate() -> CheckoutValidationValueSet
}
