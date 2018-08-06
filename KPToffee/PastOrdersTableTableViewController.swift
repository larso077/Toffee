import UIKit

class PastOrdersTableTableViewController: UITableViewController {
    var orders: [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadOrders()
        
        tableView.tableFooterView = UIView()
    }
    
    // private functions
    
    fileprivate func loadOrders() {
        loadRealOrders()
    }
    
    fileprivate func loadRealOrders() {
        let userDefaults = UserDefaults.standard
        let urlString = "/API/Orders/GetOrderList.ashx"
        
        LoadingHandler.shared.showOverlay(view: self.view)
        
        KPService.getJSONList(withURLString: urlString, params: [
            "Token": userDefaults.string(forKey: defaultKeys.authToken)!
        ]) { (values, error) in
            if let safeError = error {
                self.navigationController?.popViewController(animated: true)
                MessageCenter.showMessage(rootViewController: self, message: safeError)
                return
            }
            
            guard let safeValues = values else {
                LoadingHandler.shared.hideOverlayView()
                self.tableView.backgroundView = self.getEmptyListBackgroundView()
                return
            }
            
            LoadingHandler.shared.hideOverlayView()
            
            if safeValues.count > 0 {
                self.tableView.backgroundView = UIView()
                self.parseOrderJSON(values: safeValues)
                self.tableView.reloadData()
            } else {
                self.tableView.backgroundView = self.getEmptyListBackgroundView()
            }
        }
    }
    
    fileprivate func getEmptyListBackgroundView() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        label.text = "No Gifts Yet!"
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }
    
    fileprivate func parseOrderJSON(values: [[String: Any?]]) {
        orders = []
        
        for value in values {
            let order = Order()
            
            order.orderId = value["OrderId"] as! Int
            order.subtotal = value["SubTotal"] as? Float ?? 0.0
            order.tax = value["Tax"] as? Float ?? 0.0
            // shipping not on order yet
            order.orderDate = value["OrderDate"] as? Date
            order.shipDate = value["ShipDate"] as? Date
            
            orders.append(order)
        }
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastOrderCell", for: indexPath) as! PastOrderCell
        let order = orders[indexPath.row]
    
        cell.lblOrderNumber.text = "#\(order.orderId)"
        
        if let orderDate = order.orderDate {
            cell.lblOrderDate.text = getNiceDate(theDate: orderDate)
        }
        
        if let shipDate = order.shipDate {
            let today = Date()
            
            if today >= shipDate {
                cell.lblShippingStatus.text = "Shipped"
                cell.lblShippingStatus.textColor = UIColor(rgb: 0x7FBAFF)
            } else {
                cell.lblShippingStatus.text = "Not Shipped"
                cell.lblShippingStatus.textColor = .lightGray
            }
        } else {
            cell.lblShippingStatus.text = "Not Shipped"
            cell.lblShippingStatus.textColor = .lightGray
        }
        
        return cell
    }
    
    private func getNiceDate(theDate: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: theDate)
    }

    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !KPAuthentication.shared.isLoggedIn(), identifier == "showCartForPastOrdersSegue" {
            showLogin()
            return false
        }
        
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPastOrderInformationSegue" {
            let index = tableView.indexPathForSelectedRow?.row
            let dest = segue.destination as! CheckoutModalViewController
            
            dest.isForCheckout = false
        }
    }
}

extension PastOrdersTableTableViewController : KPLoginable {
    func showLogin() {
        performSegue(withIdentifier: "showLoginForPastOrdersSegue", sender: self)
    }
}



































