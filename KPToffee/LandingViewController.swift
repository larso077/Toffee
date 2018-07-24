//
//  LandingViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/26/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var things: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // set the height of the table view
        
    }
}
