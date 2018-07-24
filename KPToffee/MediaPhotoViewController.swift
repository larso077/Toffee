//
//  MediaPhotoViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/21/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class MediaPhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtPersonalMessage: UITextView!

    var media: MediaInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let safeMedia = media else {
            dismiss(animated: true, completion: nil)
            return
        }

        navigationItem.title = safeMedia.mediaTitle
        loadPhoto(urlString: safeMedia.photoSrc)
        loadMessage(message: safeMedia.messageText)
    }
    
    fileprivate func loadPhoto(urlString: String?) {
        imageView.contentMode = .scaleAspectFit
        
        if let photoURL = urlString {
            imageView.downloadedFrom(link: photoURL)
        } else {
            imageView.image = UIImage(named: "close.png")
        }
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
