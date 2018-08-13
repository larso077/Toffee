//
//  YourAccountViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 4/2/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class YourAccountViewController: UIViewController, UpdateBadgeDelegate {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    
    override func viewDidLoad() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



