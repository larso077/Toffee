//
//  MediaVideoViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/21/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class MediaVideoViewController: UIViewController {
    @IBOutlet weak var videoWebView: UIWebView!
    @IBOutlet weak var txtPersonalMessage: UITextView!

    var media: MediaInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let safeMedia = media, let videoURL = safeMedia.videoSrc else {
            print("there was no media sent in")
            return
        }
        
        videoWebView.allowsInlineMediaPlayback = true
        navigationItem.title = safeMedia.mediaTitle
        loadVideo(urlString: videoURL)
        loadMessage(message: safeMedia.messageText)
    }
    
    fileprivate func loadVideo(urlString: String) {
        guard let url = URL(string: urlString) else {
            // do something here
            return
        }
        
        videoWebView.loadRequest(URLRequest(url: url))
    }
    
    fileprivate func loadMessage(message: String?) {
        txtPersonalMessage.text = message ?? "Enjoy the toffee!"
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
