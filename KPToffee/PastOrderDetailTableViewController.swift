import UIKit

class PastOrderDetailTableViewController: UITableViewController {

    public var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Order #\(String(describing: order!.orderId))"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(49)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .lightGray
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 30)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentOrder = order!
        
        if segue.identifier == "showPastOrderShippingAddressSegue" {
            let dest = segue.destination as! PastOrderSingleDetailViewController
            
            dest.titleValue = "Shipping Address"
            dest.actualValue = currentOrder.shippingAddress!.description
        } else if segue.identifier == "showPastOrderPaymentInformationSegue" {
            // I need to implement something here but it depends on what data I will have at this point
        } else if segue.identifier == "showPastOrderBillingAddressSegue" {
            let dest = segue.destination as! PastOrderSingleDetailViewController
            
            dest.titleValue = "Billing Address"
            dest.actualValue = currentOrder.billingAddress!.description
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let currentOrder = order else {
            print("nope")
            return false
        }
        
        if identifier == "showPastOrderShippingAddressSegue" {
            guard let _ = currentOrder.shippingAddress else {
                return false
            }
        } else if identifier == "showPastOrderPaymentInformationSegue" {
            return false
        } else if identifier == "showPastOrderBillingAddressSegue" {
            guard let _ = currentOrder.billingAddress else {
                return false
            }
        }
        
        return true
    }
}









