//
//  NetworkUnavailabilityPopup.swift
//  KPToffee
//
//  Created by Derrek Larson on 11/2/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//
//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//
import UIKit

class CustomAlert: UIView, Modal {
    
    var backgroundView = UIView()
    var dialogView = UIView()
    
    
    convenience init(title:String,image:UIImage) {
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title, image: image)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(title:String, image:UIImage){
        dialogView.clipsToBounds = true
        dialogView.backgroundColor = UIColor.init(red: 227, green: 215, blue: 189)
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width-64
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
        titleLabel.text = "No Network Connection"
        titleLabel.textAlignment = .center
        dialogView.addSubview(titleLabel)
        
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
        separatorLineView.backgroundColor = UIColor.init(red: 253, green: 239, blue: 210)
        dialogView.addSubview(separatorLineView)
        let dismissButton = UIButton()
        dismissButton.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
        dismissButton.frame.size = CGSize(width: dialogViewWidth - 16, height: 32)
        dismissButton.setTitle("Tap to Retry", for: UIControlState.normal)
        dismissButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        dismissButton.clipsToBounds = true
//        label.textAlignment = .center
        dismissButton.backgroundColor = UIColor.init(red: 253, green: 239, blue: 210)
        dismissButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dismissButton.layer.cornerRadius = 4
        dialogView.addSubview(dismissButton)
//        let imageView = UIImageView()
//        imageView.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
//        imageView.frame.size = CGSize(width: dialogViewWidth - 16 , height: dialogViewWidth - 16)
//        imageView.image = image
//        imageView.layer.cornerRadius = 4
//        imageView.clipsToBounds = true
//        dialogView.addSubview(imageView)
        
        let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + dismissButton.frame.height + 8
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
}
