//
//  RetailLocationsTableViewController.swift
//  KPToffee
//
//  Created by UWP_MU-eg9rvp on 8/7/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation

class RetailLocationsViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        tableView.tableFooterView = UIView()
    }
    
}

