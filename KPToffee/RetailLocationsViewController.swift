//
//  RetailLocationsTableViewController.swift
//  KPToffee
//
//  Created by UWP_MU-eg9rvp on 8/7/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation

class RetailLocationsViewController: UITableViewController, UpdateBadgeDelegate {
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
    
    //***********************************************************
    // Start Table Functions
    let headerTitles = ["Wisconsin", "Illinois", "Iowa", "Michigan"]
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let list = Locations.locations
//        let count = list.count
//        return count
//    }
    let instance = Locations.instance
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = instance.locationsByState
        return list[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath as IndexPath) as! RetailLocationCell
        let list = instance.locationsByState
        let name = list[indexPath.section][indexPath.row].name
        let address = "\(list[indexPath.section][indexPath.row].city) - \(list[indexPath.section][indexPath.row].address)"
        cell.locationName?.text = name
        cell.address?.text = address
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        convertAddress(index: index)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    
    func convertAddress(index: Int) { //Geocoding location, displays name
        let geocoder = CLGeocoder()
        let selLoc = Locations.locations[index]
        let address = "\(selLoc.address) \(selLoc.city), \(selLoc.state) \(selLoc.zipcode)"
        var coordinate: (CLLocationDegrees, CLLocationDegrees)
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) in
                if((error) != nil){
                    print("Error", error ?? "")
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    let regionDistance: CLLocationDistance = 1000
                    let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                    let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                    
                    if #available(iOS 10.0, *) { // fallback check
                        let placemark = MKPlacemark(coordinate: coordinates)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = selLoc.name
                        mapItem.openInMaps(launchOptions: options)
                    } else {
                        self.openMaps(address: address)
                    }
                }
            })
        
        }
        
    
    
    func openMaps(address: String) { // Maps fallback using address URL, without location name
        let baseURL: String = "http://maps.apple.com/?q="
        
        guard let encodedString = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let addressURL = URL(string: "\(baseURL)\(encodedString)") else {
            return
        }
        
        openURL(addressURL)
    }
    
    fileprivate func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        tableView.tableFooterView = UIView()
    }
    
    
    
}

