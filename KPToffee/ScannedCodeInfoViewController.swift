//
//  ScannedCodeInfoViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/29/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class ScannedCodeInfoViewController: UIViewController, UpdateBadgeDelegate {
    @IBOutlet var lblScannedCodeInfo: UILabel!
    
    
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
            performSegue(withIdentifier: "showCartForScanCodeSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "showLoginForScanCodeSegue", sender: self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let theShoppingCart = KPShoppingCart.instance
        let quantity = theShoppingCart.productCount
        
        drawBadge(quantity: quantity)
    }
    
    // public variables
    var passedString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let safeText = passedString {
            lblScannedCodeInfo.text = safeText  
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
