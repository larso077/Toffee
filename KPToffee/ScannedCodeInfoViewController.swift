//
//  ScannedCodeInfoViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/29/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class ScannedCodeInfoViewController: UIViewController {
    @IBOutlet var lblScannedCodeInfo: UILabel!
    
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
