//
//  MyGiftsTableViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 7/4/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class MyGiftsTableViewController: UITableViewController, UpdateBadgeDelegate {
    
    func updateQuantity(_ quantity: Int?) {
        drawBadge(quantity: quantity)
    }
    
    func drawBadge(quantity: Int?) {
        let notificationButton = BasketBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(named: "shopping-basket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.imageView?.tintColor = UIColor(rgb: 0x522100)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        var num = quantity
        if num == nil { num = 0 }
        notificationButton.badge = "\(num ?? 0)"
        notificationButton.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: notificationButton)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    func goToCart() {
            performSegue(withIdentifier: "showCartForGiftSegue", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let theShoppingCart = KPShoppingCart.instance
        let quantity = theShoppingCart.productCount
        
        drawBadge(quantity: quantity)
    }
    var gifts: [MediaInfo] = []
    var currentMedia: MediaInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        loadGiftList()
    }
    
    fileprivate func loadGiftList() {
        if let token = UserDefaults.standard.string(forKey: defaultKeys.authToken) {
            KPService.getJSONList(withURLString: "/API/Media/GetMediaList.ashx", params: ["Token": token]) { (values, error) in
                self.gifts = []
                
                if let safeError = error {
                    self.navigationController?.popViewController(animated: true)
                    MessageCenter.showMessage(rootViewController: self, message: safeError)
                    return
                }
                
                if let safeValues = values {
                    self.tableView.backgroundView = UIView()
                    self.parseJSONGifts(values: safeValues)
                }
                
                if self.gifts.count < 1 {
                    self.tableView.backgroundView = self.getEmptyListBackgroundView()
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func parseJSONGifts(values: [[String: Any?]]) {
        for thing in values {
            self.gifts.append(MediaInfo(values: thing))
        }
    }
    
    fileprivate func getEmptyListBackgroundView() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        label.text = "No Gifts Yet!"
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleGiftCell", for: indexPath)
        let gift = self.gifts[indexPath.row]
        
        cell.textLabel?.text = gift.mediaTitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gift = gifts[indexPath.row]
        let authToken = UserDefaults.standard.string(forKey: defaultKeys.authToken)!
        
        KPService.getJSON(withURLString: "/API/Media/GetMediaById.ashx", params: ["MediaId": gift.mediaToken!, "Token": authToken]) { (values, error) in
            if let safeError = error {
                MessageCenter.showMessage(rootViewController: self, message: safeError)
                return
            }
            
            if let safeValues = values {
                let mediaInfo = MediaInfo(values: safeValues)
                
                if let source = mediaInfo.photoSrc, source != "" {
                    self.currentMedia = mediaInfo
                    self.performSegue(withIdentifier: "showGiftPhotoSegue", sender: self)
                } else if let source = mediaInfo.videoSrc, source != "" {
                    self.currentMedia = mediaInfo
                    self.performSegue(withIdentifier: "showGiftVideoSegue", sender: self)
                } else {
                    self.currentMedia = mediaInfo
                    self.performSegue(withIdentifier: "showGiftMessageSegue", sender: self)
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MediaPhotoViewController {
            dest.media = currentMedia!
        } else if let dest = segue.destination as? MediaVideoViewController {
            dest.media = currentMedia!
        } else if let dest = segue.destination as? MediaMessageViewController {
            dest.media = currentMedia!
        }
    }
}

























