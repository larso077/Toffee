//
//  PastOrderSingleDetailViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/11/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class PastOrderSingleDetailViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtValue: UITextView!

    var titleValue: String?
    var actualValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func showValues() {
        lblTitle.text = titleValue ?? "No Title"
        txtValue.text = actualValue ?? "No Value"
    }
}
