//
//  CheckoutValueSet.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/10/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class CheckoutValueSet {
    var name: String
    var values: [String: String?]?
    
    init(name: String, values: [String: String?]?) {
        self.name = name
        self.values = values
    }
    
    public func getFormattedString() -> NSAttributedString {
        let aString = NSMutableAttributedString(string: "")
        guard let values = values else {
            return NSAttributedString(string: "No Values", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        }
        
        for value in values {
            let header = NSAttributedString(string: value.key, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
            let actualValue = NSAttributedString(string: ":\r\r\(value.value!)\r\r", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
            
            aString.append(header)
            aString.append(actualValue)
        }
        
        return aString
    }
    
    public func getRegularString() -> String {
        let values = self.values!
        var thing = ""
        
        for value in values {
            thing.append("\(value.value!)\r")
        }
        
        return thing
    }
}
