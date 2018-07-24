//
//  ReviewCheckoutSectionViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/10/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class ReviewCheckoutSectionViewController: UIViewController {
    var checkoutValueSet: CheckoutValueSet?
    
    @IBOutlet weak var txtReviewInfo: UITextView!
    @IBOutlet weak var lblTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        showValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showValues() {
        guard let valueSet = checkoutValueSet else {
            // do some sort of error reporting
            dismiss(animated: true, completion: nil)
            
            return
        }
        
        lblTitle.text = valueSet.name
        txtReviewInfo.attributedText = valueSet.getFormattedString()
    }
}
