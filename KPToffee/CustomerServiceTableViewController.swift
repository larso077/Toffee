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
        let userDefaults = UserDefaults.standard
        
        phoneNumberCell.textLabel?.text = userDefaults.string(forKey: defaultKeys.contactPhoneNumber)
        emailAddressCell.textLabel?.text = userDefaults.string(forKey: defaultKeys.contactEmailAddress)
        addressCell.textLabel?.text = userDefaults.string(forKey: defaultKeys.contactAddress)
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





















