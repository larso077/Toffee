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
}
