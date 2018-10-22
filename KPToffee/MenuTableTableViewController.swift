//
//  MenuTableTableViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/26/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class MenuTableTableViewController: UITableViewController {
    private var headerHeight: CGFloat = 70
    var menuSelection : MenuSelection? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // the 60 is because of the default over-drag of the swrevealviewcontroller
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 60, height: headerHeight))
        let imageWidth = headerView.bounds.width * 0.34
        let imageView = UIImageView(frame: CGRect(x: (headerView.bounds.width / 2) - (imageWidth / 2), y: 9, width: imageWidth, height: headerView.bounds.height))
        
        imageView.image = UIImage(named: "kp-toffee-logo.png")
        
        headerView.addSubview(imageView)
        
        return headerView
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row{
//        case 0:
//            menuSelection = .contactUs
//            initStoryboard(controller: self, storyboardName: "Customer Service")
//        
//        case 1:
//            menuSelection = .giftCards
//            initStoryboard(controller: self, storyboardName: "Gift Cards")
//        case 2:
//            menuSelection = .retailLocations
//            // do nothing, this vc is already on this sb.
//        case 3:
//            menuSelection = .scanCodes
//            initStoryboard(controller: self, storyboardName: "Scan Codes")
//        case 4:
//            menuSelection = .yourAccount
//            initStoryboard(controller: self, storyboardName: "Your Account")
//        default:
//            menuSelection = nil
//        }
//
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "KP"
    }
//    func initStoryboard(controller: UIViewController, storyboardName: String)
//    {
//
//        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
//        if menuSelection != nil {
//        switch menuSelection!{
//        case .contactUs:
//            let childController = storyboard.instantiateInitialViewController() as! CustomerServiceTableViewController
//                addChildViewController(childController)
//                controller.view.addSubview(childController.view)
//                controller.didMove(toParentViewController: childController)
//        case .giftCards:
//                let childController = storyboard.instantiateInitialViewController() as! GiftCardsViewController
//                addChildViewController(childController)
//                controller.view.addSubview(childController.view)
//                controller.didMove(toParentViewController: childController)
//        case .retailLocations:
//                let childController = storyboard.instantiateInitialViewController() as! RetailLocationsViewController
//                addChildViewController(childController)
//                controller.view.addSubview(childController.view)
//                controller.didMove(toParentViewController: childController)
//        case .scanCodes:
//                let childController = storyboard.instantiateInitialViewController() as! ScanCodeViewController
//                addChildViewController(childController)
//                controller.view.addSubview(childController.view)
//                controller.didMove(toParentViewController: childController)
//        case .yourAccount:
//                let childController = storyboard.instantiateInitialViewController() as! YourAccountViewController
//                addChildViewController(childController)
//                controller.view.addSubview(childController.view)
//                controller.didMove(toParentViewController: childController)
//            }
//        }
//
//    }
    

}
enum MenuSelection{
    case scanCodes
    case yourAccount
    case contactUs
    case retailLocations
    case giftCards
}

