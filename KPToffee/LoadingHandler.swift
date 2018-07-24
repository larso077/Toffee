//
//  LoadingHandler.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/5/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class LoadingHandler {
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    class var shared: LoadingHandler {
        struct Static {
            static let instance: LoadingHandler = LoadingHandler()
        }
        return Static.instance
    }
    
    init(){
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.backgroundColor = UIColor(white: 0.5, alpha: 1)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        overlayView.addSubview(activityIndicator)
    }
    
    public func showOverlay(view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    public func showOverlayModal(viewController: UIViewController) {
        let overlayVC = UIViewController();
        
        overlayVC.modalPresentationStyle = .overCurrentContext
        overlayVC.view.backgroundColor = UIColor(white: 1, alpha: 0.7)
        
        viewController.present(overlayVC, animated: false, completion: nil)
        
        overlayView.center = overlayVC.view.center
        overlayVC.view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayModal(viewController: UIViewController) {
        hideOverlayView()
        viewController.dismiss(animated: false, completion: nil)
    }
}
