//
//  LoginNavigationViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/26/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class LoginNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
    }
    
    @objc func showLoginController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true) { 
            // maybe do something after the fact?
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
