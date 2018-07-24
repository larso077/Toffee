//
//  MessageCenter.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/5/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class MessageCenter {
    public static func showMessage(rootViewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        rootViewController.present(alert, animated: true, completion: nil)
    }
    
    public static func showMessage(rootViewController: UIViewController, message: String, completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
