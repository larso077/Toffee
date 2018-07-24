//
//  CheckoutMediaView.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/13/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation
import AVFoundation
import MobileCoreServices
import Photos
import AssetsLibrary

public class CheckoutMediaView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI Stuff
    
    @IBOutlet weak var btnRemoveMedia: UIButton!
    @IBOutlet weak var btnNextStep: UIButton!
    @IBOutlet weak var btnAddRemoveVideo: UIButton!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var mediaTitleTextField: KPTextField!
    @IBOutlet weak var mediaMessageTextView: UITextView!
    
    // private instance variables
    
    var videoURL: String?
    var imageURL: String?
    var hasVideo: Bool = false
    var hasImage: Bool = false
    
    // methods
    
    @IBAction func addRemoveButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "How would you like to add media?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Take New", style: .default, handler: { (UIAlertAction) in
           self.requestImagePicker(successCallback: self.presentMediaRecorder)
        }))
        
        alert.addAction(UIAlertAction(title: "Choose from Existing", style: .default, handler: { (UIAlertAction) in
            self.requestImagePicker(successCallback: self.presentMediaPicker)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func removeMediaPressed(_ sender: UIButton) {
        imgThumbnail.image = UIImage(named: "photo-grey.png")
        showRemoveButton(false)
    }
    
    func getMediaInformation() -> MediaInfo {
        let info = MediaInfo(mediaId: 0)
        
        info.mediaTitle = mediaTitleTextField.text
        info.messageText = mediaMessageTextView.text
        info.actualImage = imgThumbnail.image
        
        if hasImage {
            info.photoSrc = imageURL
        } else {
            info.videoSrc = videoURL
        }
        
        return info
    }
    
    func requestImagePicker(successCallback: @escaping () -> Void) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            successCallback()
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted :Bool) -> Void in
                if granted == true {
                    successCallback()
                }
            })
        }
    }
    
    func presentMediaRecorder() {
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            let picker = UIImagePickerController()
            
            picker.videoQuality = .typeHigh
            picker.sourceType = .camera
            picker.delegate = self
            picker.mediaTypes = [String(describing: kUTTypeImage), String(describing: kUTTypeMovie)]
            picker.cameraCaptureMode = .video
            
            UIApplication.topViewController()?.present(picker, animated: true, completion: nil)
        }
    }
    
    func presentMediaPicker() {
        let picker = UIImagePickerController()
        
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        picker.mediaTypes = [String(describing: kUTTypeImage), String(describing: kUTTypeMovie)]
        picker.modalPresentationStyle = .popover
        picker.delegate = self
        
        UIApplication.topViewController()?.present(picker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        picker.dismiss(animated: true, completion: nil)

        if mediaType == kUTTypeMovie {
            guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(CheckoutMediaView.video(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        } else if mediaType == kUTTypeImage, let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if picker.sourceType == .camera  {
                UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(CheckoutMediaView.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            
            imgThumbnail.image = pickedImage
            showRemoveButton(true)
            hasImage = true
            hasVideo = false
            
            if let localURL = (info[UIImagePickerControllerMediaURL] ?? info[UIImagePickerControllerReferenceURL]) as? NSURL {
                imageURL = localURL.path!
            }
        }
    }

    @objc public func video(_ videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        videoURL = String(describing: videoPath)
        
        showVideoPreview()
        showRemoveButton(true)
        hasVideo = true
        hasImage = false
    }
    
    @objc public func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        // not used, but here in case we need it later
    }
    
    private func showRemoveButton(_ show: Bool) {
        btnRemoveMedia.isHidden = !show
        
        if !show {
            hasVideo = false
            hasImage = false
            
            btnAddRemoveVideo.setTitle("Add photo or video", for: .normal)
        } else {
            btnAddRemoveVideo.setTitle("Change the photo or video", for: .normal)
        }
    }
    
    private func showVideoPreview() {
        let asset = AVURLAsset(url: URL(fileURLWithPath: videoURL!))
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let image = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            
            imgThumbnail.image = UIImage(cgImage: image, scale: 1, orientation: .right)
        } catch {
            print(error)
        }
    }
}
