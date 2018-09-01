//
//  PopupViewController.swift
//  KPToffee
//
//  Created by UWP_MU-gfkzby on 8/15/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import UIKit
import AVFoundation

class InitialPopupViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var pagingControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func showPopupSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            PopupsController.shared.setShowInitialPopup(bool: false)
        } else {
            PopupsController.shared.setShowInitialPopup(bool: true)
        }
    }
    
    
    
    // private variables
    
    private var popupViews: [UIView] = []
    private var horizontalScrollIsLocked: Bool = false
    
    private var lastOffsetX: CGFloat = 0
    
    var player: AVAudioPlayer?
    
    func playSound() {
        let url = Bundle.main.url(forResource: "coffee", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded() // without this I am not getting the proper width from self.view.frame.width
        scrollView.delegate = self
        
        loadCheckoutViews()
        pagingControl.numberOfPages = popupViews.count
        hideKeyboardWhenTappedAround()
        playSound()
        
    }
    
    
    @IBAction func exitBtn(_ sender: Any) {
        player?.stop()
        self.dismiss(animated: true)
    }
    
    func dismissPopup() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func setStep(sender: UIButton) {
        goToStep(sender.tag + 1)
    }
    
    func goToStep(_ index: Int) {
        var frame = scrollView.frame
        
        frame.origin.x = frame.size.width * CGFloat(index);
        frame.origin.y = 0;
        
        view.endEditing(true)
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    // DELEGATE METHODS
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if horizontalScrollIsLocked {
            scrollView.contentOffset.x = lastOffsetX
        } else {
            let page = scrollView.contentOffset.x / scrollView.frame.size.width
            
            pagingControl.currentPage = Int(page)
            lastOffsetX = scrollView.contentOffset.x
            
            // stop the vertical scrolling
            scrollView.contentOffset.y = 0
        }
    }
    
    fileprivate func loadCheckoutViews() {
        popupViews = []
        
        if let safeView = getFirstPopupView() {
            popupViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 0)
        }
        
        if let safeView = getSecondPopupView() {
            popupViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 1)
        }
        
        if let safeView = getThirdPopupView() {
            popupViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 1)
        }
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(popupViews.count), height: scrollView.frame.height)
    }
    
    fileprivate func addSlideToScrollView(theView: UIView, index: Int) {
        theView.tag = index
        theView.frame.size.height = self.scrollView.frame.size.height
        theView.frame.size.width = self.view.frame.width
        theView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
        
        scrollView.addSubview(theView)
    }
    
    fileprivate func getFirstPopupView() -> FirstInitialPopupView? {
        let theView = Bundle.main.loadNibNamed("FirstInitialPopup", owner: self, options: nil)?.first as? FirstInitialPopupView
        
        return theView
    }
    
    fileprivate func getSecondPopupView() -> SecondInitialPopupView? {
        let theView = Bundle.main.loadNibNamed("SecondInitialPopup", owner: self, options: nil)?.first as? SecondInitialPopupView
        
        return theView
    }
    
    fileprivate func getThirdPopupView() -> ThirdInitialPopupView? {
        let theView = Bundle.main.loadNibNamed("ThirdInitialPopup", owner: self, options: nil)?.first as? ThirdInitialPopupView
        
        return theView
    }
    
}







