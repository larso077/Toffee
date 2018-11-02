//
//  ShoppingCartViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/7/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

protocol UpdateBadgeDelegate: class {
    func updateQuantity(_ quantity: Int?)
}

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblShipping: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    
    weak var delegate: UpdateBadgeDelegate?
    
    func quantityChanged() {
        let quantityTemp = KPShoppingCart.instance.productCount
        delegate?.updateQuantity(quantityTemp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        setCartValues()
    }
    
    fileprivate func setCartValues() {
        lblSubtotal.text = "$ \(KPShoppingCart.instance.subtotal.format(f: ".2"))"
        lblTax.text = "$ \(KPShoppingCart.instance.tax.format(f: ".2"))"
        lblShipping.text = "$ 0.00"
        lblTotal.text = "$ \(KPShoppingCart.instance.total.format(f: ".2"))"
        
        if let products = KPShoppingCart.instance.products, products.count > 0 {
            showNotEmptyCart()
        } else {
            showEmptyCart()
        }
    }
    
    fileprivate func showNotEmptyCart() {
        btnCheckout.isEnabled = true
        btnCheckout.backgroundColor = UIColor(rgb: 0xE6DCC5)
        btnCheckout.alpha = 1.0
        
        tableView.backgroundView = UIView()
    }
    
    fileprivate func showEmptyCart() {
        btnCheckout.isEnabled = false
        btnCheckout.backgroundColor = .lightGray
        btnCheckout.alpha = 0.5
        
        tableView.backgroundView = getEmptyCartBackground()
    }
    
    fileprivate func getEmptyCartBackground() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        label.text = "Your basket is currently empty!"
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount: Int = 0
        
        if let safeProducts = KPShoppingCart.instance.products {
            rowCount = safeProducts.count
        }
        
        return rowCount
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCartCell", for: indexPath) as! KPShoppingCartCell
        let currentProduct = KPShoppingCart.instance.products![indexPath.row]
        
        
        cell.lblProductTitle?.text = currentProduct.product.name
        cell.lblQuantity.text = "\(currentProduct.quantity)"
        cell.imgProductImage.downloadedFrom(link: currentProduct.product.images[0])
        
        if currentProduct.total != currentProduct.saleTotal {
            cell.lblProductPrice.attributedText = getStrikethroughText(text: "$\(currentProduct.total.format(f: ".2")) each")
            cell.lblProductSalePrice.text = "$\(currentProduct.saleTotal.format(f: ".2")) each"
        } else {
            cell.lblProductPrice.text = "$\(currentProduct.saleTotal.format(f: ".2"))"
            cell.lblProductSalePrice.text = ""
        }
        
        return cell
    }
    
    
    @IBAction func doIncreaseQuantity(_ sender: Any) { //increase button
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let cell = tableView.cellForRow(at: indexPath!) as! KPShoppingCartCell
        let currentProduct = KPShoppingCart.instance.products![(indexPath?.row)!]
        if indexPath != nil {
            if currentProduct.quantity < 99 {
                currentProduct.quantity += 1
                KPShoppingCart.instance.productCount += 1
                
            }
        }
        self.setCartValues()
        cell.lblProductPrice.text = "$\(currentProduct.saleTotal.format(f: ".2")) for \(currentProduct.quantity)"
    }
    
    @IBAction func doDecreaseQuantity(_ sender: Any) { //decrease button
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let currentProduct = KPShoppingCart.instance.products! [(indexPath?.row)!]
        let cell = tableView.cellForRow(at: indexPath!) as! KPShoppingCartCell
        if indexPath != nil {
            
            if currentProduct.quantity > 1 {
                currentProduct.quantity -= 1
                KPShoppingCart.instance.productCount -= 1
            }
        }
        self.setCartValues()
        cell.lblProductPrice.text = "$\(currentProduct.saleTotal.format(f: ".2")) for \(currentProduct.quantity)"
    }
    
    
    
    
    
    fileprivate func getStrikethroughText(text: String) -> NSAttributedString {
        let attString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, text.count)
        
        attString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: range)
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(rgb: 0x9B9B9B), range: range);
        
        return attString
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let product = KPShoppingCart.instance.products?[indexPath.row] {
                KPShoppingCart.instance.productCount -= product.quantity
                if KPShoppingCart.instance.productCount < 0
                {
                    KPShoppingCart.instance.productCount = 0
                }
                KPShoppingCart.instance.removeProduct(product: product.product, quantity: product.quantity)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.setCartValues()
            }
        }
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

