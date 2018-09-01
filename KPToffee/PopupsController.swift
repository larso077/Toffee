//
//  PopupsController.swift
//  KPToffee
//
//  Created by UWP_MU-ny6a89 on 8/21/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation

public class PopupsController {
    public static let shared = PopupsController()
    
    
    var shouldShowCheckoutPopup: Bool = true
    func setShowCheckoutPopup(bool: Bool){
        shouldShowCheckoutPopup = bool
    }
    
    var shouldShowInitialPopup: Bool = true
    func setShowInitialPopup(bool: Bool){
        shouldShowInitialPopup = bool
    }
}
