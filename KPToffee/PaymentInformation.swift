//
//  PaymentInformation.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/11/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class PaymentInformation: CustomStringConvertible {
    var cardNumber: String
    var expirationDate: String
    var cvv: Int
    
    public var description: String {
        return "Card #: \(cardNumber)\rExpiration: \(expirationDate)\rCVV: \(cvv)"
    }
    
    public var expirationMonth: Int {
        if expirationDate.count > 0 {
            return Int(expirationDate.prefix(2)) ?? 0
        } else {
            return 0
        }
    }
    
    public var expirationYear: Int {
        if expirationDate.count > 0 {
            return Int(expirationDate.suffix(4)) ?? 0
        } else {
            return 0
        }
    }
    
    init(cardNumber: String, expirationDate: String, cvv: Int) {
        self.cardNumber = cardNumber
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
}
