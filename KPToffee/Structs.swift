//
//  Structs.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/6/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

struct defaultKeys {
    static let authToken = "authTokenKey"
    static let firstName = "firstNameKey"
    static let lastName = "lastNameKey"
    static let emailAddress = "emailAddressKey"
    static let subscibed = "subscribedKey"
    static let eula = "eulaKey"
    static let privacyPolicy = "privacyPolicyKey"
    static let headerImage = "headerImageKey"
    static let contactPhoneNumber = "contactPhoneNumber"
    static let contactEmailAddress = "contactEmailAddress"
    static let contactAddress = "contactAddress"
}

struct stateInfo {
    static var states = [State]()
    
    static func getStateById(_ stateId: Int) -> State? {
        return stateInfo.states.first(where: { (state) -> Bool in
            state.stateId == stateId
        })
    }
}
