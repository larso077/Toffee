//
//  RetailLocationsVIewController.swift
//  KPToffee
//
//  Created by Alec DiGirolamo on 8/28/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import UIKit
import MapKit

class RetailLocationsViewController: UIViewController, UpdateBadgeDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    func updateQuantity(_ quantity: Int?) {
        drawBadge(quantity: quantity)
    }
    func drawBadge(quantity: Int?) {
        let notificationButton = BasketBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(named: "shopping bag")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        var num = quantity
        if num == nil { num = 0 }
        notificationButton.badge = "\(num ?? 0)"
        notificationButton.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: notificationButton)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    @objc func goToCart() {
        if KPAuthentication.shared.isLoggedIn() {
            performSegue(withIdentifier: "showCartForLocationsSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "showLoginForLocationsSegue", sender: self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let theShoppingCart = KPShoppingCart.instance
        let quantity = theShoppingCart.productCount
        
        drawBadge(quantity: quantity)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        
        let tempLoc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Locations.locations[0].lon, Locations.locations[0].lat)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(tempLoc, span)
        mapView.setRegion(region, animated: true)
        
        // Latitude and longitude are reversed (x.lon is actually the latitude of x)
        for x in Locations.locations {
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(x.lon, x.lat)
            
            let annotation = MKPointAnnotation()
            
            
            annotation.coordinate = location
            annotation.title = x.name
            annotation.subtitle = "\(x.address) \(x.city), \(x.state) \(x.zipcode)"
            mapView.addAnnotation(annotation)
        }
        
    }
}
