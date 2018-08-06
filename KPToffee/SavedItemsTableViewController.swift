import UIKit

class SavedItemsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var savedItems: [Product] = []
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        setSavedItemsValues()
    }
    
    fileprivate func setSavedItemsValues() {
        if let products = KPSavedForLater.instance.products, products.count > 0 {
            showNotEmptySaved()
        } else {
            showEmptySaved()
        }
    }
    
    fileprivate func showNotEmptySaved() {
        tableView.backgroundView = UIView()
    }
    
    fileprivate func showEmptySaved() {
        tableView.backgroundView = getEmptySavedBackground()
    }
    
    fileprivate func getEmptySavedBackground() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        label.text = "You currently have no saved items!"
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount: Int = 0
        if let safeProducts = KPSavedForLater.instance.products {
            rowCount = safeProducts.count
        }
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedItemCell", for: indexPath) as! SavedItemCell
        let currentProduct = KPSavedForLater.instance.products![indexPath.row]
        
        cell.lblProductTitle?.text = currentProduct.product.name
        
        cell.imgProductImage.downloadedFrom(link: currentProduct.product.images[0])
        
        if currentProduct.total != currentProduct.saleTotal {
            cell.lblProductPrice.attributedText = getStrikethroughText(text: "$\(currentProduct.total.format(f: ".2"))")
            cell.lblProductSalePrice.text = "$\(currentProduct.saleTotal.format(f: ".2"))"
        } else {
            cell.lblProductPrice.text = "$\(currentProduct.saleTotal.format(f: ".2"))"
            cell.lblProductSalePrice.text = ""
        }
        
        return cell
    }
    
    fileprivate func getStrikethroughText(text: String) -> NSAttributedString {
        let attString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, text.count)
        
        attString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: range)
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(rgb: 0x9B9B9B), range: range);
        
        return attString
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let product = KPSavedForLater.instance.products?[indexPath.row] {
                KPSavedForLater.instance.removeProduct(product: product.product)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.setSavedItemsValues()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSavedItemSegue" {
            let index = tableView.indexPathForSelectedRow?.row
            let dest = segue.destination as! SingleProductViewController
            if let safeProducts = KPSavedForLater.instance.products {
                dest.product = safeProducts[index!].product
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSavedItemSegue", sender: self)
    }
    
    
}
