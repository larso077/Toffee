//
//  ResetPasswordViewController.swift
//  KPToffee
//
//  Created by UWP_MU-ny6a89 on 7/24/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

// Need server access to continue...

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var txtNewPassword: KPTextField!
    @IBOutlet weak var txtValidatePassword: KPTextField!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    @IBOutlet weak var passwordRequirements: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func resetPasswordButton(_ sender: Any) {
       resetPassword()
    }
    private func resetPassword(){
        dismissKeyboard()
        validateValuesAndSend()
    }
    private func validateValuesAndSend(){
        guard let newPassword = txtNewPassword.text, newPassword.isValidPassword() else {            MessageCenter.showMessage(rootViewController: self, message: "Please enter a valid password")
            passwordRequirements.isHidden = false
            return
        }
        guard let validPassword = txtValidatePassword.text, validPassword == newPassword else {
            MessageCenter.showMessage(rootViewController: self, message: "Please make sure both passwords match")
            return
        }
    }
    
    
}
