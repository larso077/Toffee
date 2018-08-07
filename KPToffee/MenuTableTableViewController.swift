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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "KP"
    }
}

