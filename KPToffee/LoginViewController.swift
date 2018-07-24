//
//  LoginViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/26/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var txtEmail: KPTextField!
    @IBOutlet weak var txtPassword: KPTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnForgotPassword.titleLabel?.font = UIFont.italicSystemFont(ofSize: 15)
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        // setup the outside tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
   
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        runLogin()
    }
    
    private func runLogin() {
        dismissKeyboard()
        signIn()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else {
            resignFirstResponder()
            runLogin()
        }
        
        return false
    }
    
    fileprivate func signIn() {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), email.isValidEmailAddress() else {
            MessageCenter.showMessage(rootViewController: self, message: "Please enter a valid email")
            return
        }
        
        guard let password = txtPassword.text, password.isValidPassword() else {
            MessageCenter.showMessage(rootViewController: self, message: "Please enter a valid password")
            return
        }
        
        LoadingHandler.shared.showOverlayModal(viewController: self)
        KPAuthentication.shared.login(email: email, password: password) { (success) in
            LoadingHandler.shared.hideOverlayModal(viewController: self)
            
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                MessageCenter.showMessage(rootViewController: self, message: "Invalid Credentials")
            }
        }
    }
}
