//
//  State.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/11/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class State {
    var stateId: Int
    var stateName: String
    var stateAbbreviation: String
    
    init(stateId: Int, stateName: String, stateAbbreviation: String) {
        self.stateId = stateId
        self.stateName = stateName
        self.stateAbbreviation = stateAbbreviation
    }
}
