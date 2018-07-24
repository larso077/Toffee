//
//  PrivacyPolicyViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/5/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Privacy Policy"
        textView.text = UserDefaults.standard.string(forKey: defaultKeys.privacyPolicy)
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
