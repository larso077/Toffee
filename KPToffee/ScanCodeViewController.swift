//
//  ScanCodeViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/26/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit
import AVFoundation

class ScanCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    // scanner stuff
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    // captured info
    var scannedInfo: String?
    var media: MediaInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        do {
            try setupScanner()
            
            createQRReaderFrame()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Start video capture.
        qrCodeFrameView?.frame = CGRect.zero
        captureSession?.startRunning()
    }
    
    private func setupScanner() throws {
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        let input: AnyObject! = try AVCaptureDeviceInput.init(device: captureDevice!)
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
    }
    
    private func createQRReaderFrame() {
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubview(toFront: qrCodeFrameView!)
    }
    
    private func clearQRCodeFrameView() {
        qrCodeFrameView?.frame = CGRect.zero
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            clearQRCodeFrameView()
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject!
        
        if metadataObj?.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj!) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if let mediaId = metadataObj?.stringValue {
                loadMedia(mediaId: mediaId)
            }
            
            captureSession?.stopRunning()
        }
    }
    
    fileprivate func loadMedia(mediaId: String) {
        var parameters: [String: String] = [
            "MediaId": mediaId
        ]
        
        if KPAuthentication.shared.isLoggedIn(), let safeToken = UserDefaults.standard.string(forKey: defaultKeys.authToken) {
            parameters["Token"] = safeToken
        }
        
        KPService.getJSON(withURLString: "/api/Media/GetMediaById.ashx", params: parameters) { (values, error) in
            if let safeError = error {
                MessageCenter.showMessage(rootViewController: self, message: safeError)
                return
            }
            
            guard let mediaId = values?["MediaId"] as? Int else {
                MessageCenter.showMessage(rootViewController: self, message: "Invalid QR Code")
                return
            }
            
            let title = (values?["MediaTitle"] ?? "Hello") as! String
            let message = (values?["MessageText"] ?? "No Message Text") as! String
            let mediaSource = (values?["MediaSrc"] ?? "") as! String
            
            if mediaSource.hasSuffix("mp4") {
                let thing = "\(KPService.siteURLString)\(mediaSource)"
                
                self.media = MediaInfo(mediaId: mediaId, mediaTitle: title, photoSrc: nil, videoSrc: thing)
                self.media?.messageText = message
                
                self.performSegue(withIdentifier: "showMediaVideoSegue", sender: self)
            } else {
                let thing = "\(KPService.siteURLString)\(mediaSource)"
                
                self.media = MediaInfo(mediaId: mediaId, mediaTitle: title, photoSrc: thing, videoSrc: nil)
                self.media?.messageText = message
                
                self.performSegue(withIdentifier: "showMediaPhotoSegue", sender: self)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !KPAuthentication.shared.isLoggedIn(), identifier == "showCartForScanCodeSegue" {
            showLogin()
            return false
        }
        
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MediaVideoViewController {
            dest.media = media
        } else if let dest = segue.destination as? MediaPhotoViewController {
            dest.media = media
        } else if let dest = segue.destination as? MediaMessageViewController {
            dest.media = media
        }
    }
}

extension ScanCodeViewController : KPLoginable {
    func showLogin() {
        performSegue(withIdentifier: "showLoginForScanCodeSegue", sender: self)
    }
}
































