//
//  MediaMessageViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/5/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class MediaMessageViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UITextView!

    var media: MediaInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let safeMedia = media {
            titleLabel.text = safeMedia.mediaTitle
            messageLabel.text = safeMedia.messageText
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
