//
//  KPShoppingCartCell.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/18/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class KPShoppingCartCell: UITableViewCell {
    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductSalePrice: UILabel!
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        let currentQuantity = Int(lblQuantity.text!)
        
        if currentQuantity! <= 99 {
            lblQuantity.text = "\(currentQuantity! + 1)"
        }
        
    }
    
    
    
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        let currentQuantity = Int(lblQuantity.text!)
        
        if currentQuantity! >= 1 {
            lblQuantity.text = "\(currentQuantity! - 1)"
            
        }
    }
    
}



