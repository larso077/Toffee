//
//  RetailLocationsTableViewController.swift
//  KPToffee
//
//  Created by UWP_MU-eg9rvp on 8/7/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation

class RetailLocationsViewController: UITableViewController, UpdateBadgeDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    func updateQuantity(_ quantity: Int?) {
        drawBadge(quantity: quantity)
    }
    
    func drawBadge(quantity: Int?) {
        let notificationButton = BasketBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(named: "shopping bag")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        var num = quantity
        if num == nil { num = 0 }
        notificationButton.badge = "\(num ?? 0)"
        notificationButton.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: notificationButton)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc func goToCart() {
        if KPAuthentication.shared.isLoggedIn() {
            performSegue(withIdentifier: "showCartForLocationsSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "showLoginForLocationsSegue", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let theShoppingCart = KPShoppingCart.instance
        let quantity = theShoppingCart.productCount
        
        drawBadge(quantity: quantity)
    }
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

