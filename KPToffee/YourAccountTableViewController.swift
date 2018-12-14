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
    @IBOutlet weak var signInOutCell: UITableViewCell!
    
    func updateQuantity(_ quantity: Int?) {
        drawBadge(quantity: quantity)
    }
    
    func drawBadge(quantity: Int?) {
        let notificationButton = BasketBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(named: "shopping-basket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.imageView?.tintColor = UIColor(rgb: 0x522100)
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
        if KPAuthentication.shared.isLoggedIn(){
            signInOutCell.textLabel?.text = "Sign Out"
            tableView.reloadData()
        }else{
            signInOutCell.textLabel?.text = "Sign In"
            tableView.reloadData()
        }
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
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row{
            case 0: if KPAuthentication.shared.isLoggedIn(){
                self.performSegue(withIdentifier: "showPastOrdersSegue", sender: nil)}else{
                self.performSegue(withIdentifier: "showLoginForAccountSegue", sender: nil)
                }
            case 1: if KPAuthentication.shared.isLoggedIn(){
                self.performSegue(withIdentifier: "showMyGiftListSegue", sender: nil)
            }else{
                self.performSegue(withIdentifier: "showLoginForAccountSegue", sender: nil)
                }
            case 2: if KPAuthentication.shared.isLoggedIn(){
                self.performSegue(withIdentifier: "modalSavedItems", sender: nil)
            }else{
                self.performSegue(withIdentifier: "showLoginForAccountSegue", sender: nil)
                }
            default:
                print("tableView did an oopsie, this should never print")
            }
        }
        if indexPath.section == 1{
            switch indexPath.row{
            case 0: self.performSegue(withIdentifier: "showPrivacyPolicy", sender: nil)
            case 1: print("where the heck is the user agreement?")
            case 2: self.performSegue(withIdentifier: "showCustomerService", sender: nil)
            default: print("this should never happen, debug")
        }
        }
        if indexPath.section == 2 {
            if KPAuthentication.shared.isLoggedIn(){
                
                //When log out is pressed presents a confimation page
                let alertVC = UIAlertController(title: "Logout", message: "Are your sure your want to logout?", preferredStyle: .actionSheet)
                //Allows user to cancel logout
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                // Handle logging out inside the closure
                let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
                    print("Logging out")
                    KPAuthentication.shared.logout()
                    self.signInOutCell.textLabel?.text = "Sign In"
                    self.welcomeBackLabel.text = "Signed Out"
                }
                
                //Adds the acitons to preform based on the click
                alertVC.addAction(logoutAction)
                alertVC.addAction(cancelAction)
                self.present(alertVC, animated: true, completion: nil)
                tableView.reloadData()
            }else{
                performSegue(withIdentifier: "showLoginForAccountSegue", sender: nil)
            }
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
























