//
//  CustomerServiceTableViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/23/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class CustomerServiceTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var phoneNumberCell: UITableViewCell!
    @IBOutlet weak var emailAddressCell: UITableViewCell!
    @IBOutlet weak var addressCell: UITableViewCell!
    
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
        
        setCellValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setCellValues() {
//        let userDefaults = UserDefaults.standard
        
//        phoneNumberCell.textLabel?.text = userDefaults.string(forKey: defaultKeys.contactPhoneNumber)
        phoneNumberCell.textLabel?.text = "262-886-3920"
//        emailAddressCell.textLabel?.text = userDefaults.string(forKey: defaultKeys.contactEmailAddress)
        emailAddressCell.textLabel?.text = "INFO@KPTOFFEE.COM"
//        addressCell.textLabel?.text = userDefaults.string(forKey: defaultKeys.contactAddress)
        addressCell.textLabel?.text = "9602 DURAND AVENUE, SUITE 100 STURTEVANT, WI 53177"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            callPhoneNumber()
        } else if indexPath.row == 1 {
            sendEmail()
        } else {
            openMaps()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func callPhoneNumber() {
        guard let phoneNumber = phoneNumberCell.textLabel?.text else {
            return
        }
        
        guard let phoneURL = URL(string: "tel://\(getConvertPhoneNumberString(phoneNumber))") else {
            return
        }
        
        openURL(phoneURL)
    }
    
    fileprivate func getConvertPhoneNumberString(_ phoneNumberString: String) -> String {
        let numbersOnly = phoneNumberString.filter { "0123456789".contains($0) }
        
        return String(numbersOnly)
    }
    
    fileprivate func sendEmail() {
        guard let emailAddress = emailAddressCell.textLabel?.text else {
            return
        }
        
        guard let emailAddressURL = URL(string: "mailto://\(emailAddress)") else {
            print(emailAddress)
            
            return
        }
        
        openURL(emailAddressURL)
    }
    
    fileprivate func openMaps() {
        let baseURL: String = "http://maps.apple.com/?q="
        
        guard let address = addressCell.textLabel?.text else {
            print("here")
            return
        }
        
        guard let encodedString = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("there")
            return
        }
        
        guard let addressURL = URL(string: "\(baseURL)\(encodedString)") else {
            print("anotherone")
            return
        }
        
        openURL(addressURL)
    }
    
    fileprivate func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !KPAuthentication.shared.isLoggedIn(), identifier == "showCartForCustomerServiceSegue" {
            showLogin()
            return false
        }
        
        return true
    }
}

extension CustomerServiceTableViewController : KPLoginable {
    func showLogin() {
        performSegue(withIdentifier: "showLoginForCustomerServiceSegue", sender: self)
    }
}





















