//
//  ModalPopup.swift
//  KPToffee
//
//  Created by Derrek Larson on 11/2/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation

import UIKit

protocol Modal {
    func show(animated:Bool)
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
}

extension Modal where Self:UIView{
    func show(animated:Bool){
        self.backgroundView.alpha = 0
        self.dialogView.backgroundColor = UIColor.init(red: 227, green: 215, blue: 189)
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }
    
    func dismiss(animated:Bool, completion: (() -> Void)? = nil){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
            

                self.removeFromSuperview()
            })
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
            self.removeFromSuperview()
        }
        
    }
}
