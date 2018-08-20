//
//  YourAccountTableViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/4/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class YourAccountTableViewController: UITableViewController, UpdateBadgeDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var welcomeBackLabel: UILabel!

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
    
    func goToCart() {
                if KPAuthentication.shared.isLoggedIn() {
        performSegue(withIdentifier: "showCartForAccountSegue", sender: nil)
                    } else {
                    performSegue(withIdentifier: "showLoginForAccountSegue", sender: self)
                            }
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        let theShoppingCart = KPShoppingCart.instance
        let quantity = theShoppingCart.productCount
        
        drawBadge(quantity: quantity)
        
        if KPAuthentication.shared.isLoggedIn() {
            welcomeBackLabel.text = "Welcome back \(UserDefaults.standard.string(forKey: defaultKeys.firstName)!)!"
        } else {
            welcomeBackLabel.text = "Welcome!"
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if !KPAuthentication.shared.isLoggedIn() {
            return 2
        }
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1, indexPath.row == 2, let reveal = revealViewController(), let vc = storyboard?.instantiateViewController(withIdentifier: "CustomerServiceNavViewController") {
            reveal.pushFrontViewController(vc, animated: true)
        } else if indexPath.section == 2, let reveal = revealViewController(), let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsNavViewController") {
            
            KPAuthentication.shared.logout()
            reveal.pushFrontViewController(vc, animated: true)
        }
    }
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !KPAuthentication.shared.isLoggedIn() && (self.tableView.indexPathForSelectedRow?.section ?? 1 < 1 || identifier == "showCartForAccountSegue") {
            performSegue(withIdentifier: "showLoginForAccountSegue", sender: self)
            return false
        }
        
        return true
    }
}
























