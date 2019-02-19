//
//  CreateAccountViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/26/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtFirstName: KPTextField!
    @IBOutlet weak var txtLastName: KPTextField!
    @IBOutlet weak var txtEmail: KPTextField!
    @IBOutlet weak var txtPassword: KPTextField!
    @IBOutlet weak var validatePassword: KPTextField!
    @IBOutlet weak var swSendOffers: UISwitch!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var passwordRequirements: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordRequirements.isHidden = false
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCreateAccount(_ sender: UIButton) {
        createAccount()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName {
            txtLastName.becomeFirstResponder()
        } else if textField == txtLastName {
            txtEmail.becomeFirstResponder()
        } else if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else if textField == txtPassword {
            resignFirstResponder()
            createAccount()
        }
        
        return false
    }
    
    private func createAccount() {
        dismissKeyboard()
        validateValuesAndSend()
    }
    
    private func validateValuesAndSend() {
        guard let firstName = txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines), firstName.count > 2 else {
            MessageCenter.showMessage(rootViewController: self, message: "Please enter a first name")
            return
        }
        
        guard let lastName = txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines), lastName.count > 2 else {
            MessageCenter.showMessage(rootViewController: self, message: "Please enter a last name")
            return
        }
        
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), email.isValidEmailAddress() else {
            MessageCenter.showMessage(rootViewController: self, message: "Please enter a valid email")
            return
        }
        
        guard let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), password.isValidPassword() else {
            MessageCenter.showMessage(rootViewController: self, message: "Please enter a valid password")
            return
        }
        
        guard let validPassword = validatePassword.text,
            validPassword == txtPassword.text else {
            MessageCenter.showMessage(rootViewController: self, message: "Please make sure both passwords match.")
            return
        }
        
        let sendOffers = swSendOffers.isOn
        
        LoadingHandler.shared.showOverlay(view: view)
        sendValuesToServer(firstName: firstName, lastName: lastName, email: email, password: password, sendOffers: sendOffers)
    }
    
    private func sendValuesToServer(firstName: String, lastName: String, email: String, password: String, sendOffers: Bool) {
        let urlString = "/API/Customer/CustomerCreate.ashx"
        
        KPService.getJSON(withURLString: urlString, params: [
                "FirstName": firstName,
                "LastName": lastName,
                "EmailAddress": email,
                "Password": password,
                "Subscribe": sendOffers.description
            ]) { (values, error) in
                LoadingHandler.shared.hideOverlayView()
                
                if let safeError = error {
                    MessageCenter.showMessage(rootViewController: self, message: safeError)
                    return
                }

                MessageCenter.showMessage(rootViewController: self, message: "Account created. An email has been sent with a link to complete the account creation!") {_ in
                    self.dismiss(animated: true, completion: nil)
                }
        }
    }
}
