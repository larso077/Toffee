//
//  ProductsViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 4/8/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//
//NOTE FROM DERREK: THERE IS ALREADY A FUNCTION TO CONVERT HTML TO AN ATTRIBUTED TEXT
//STRING, SIMPLY PASS THAT OUTPUT INTO THE PRODUCT LABEL WHEN SERVER SIDE IS READY

import UIKit

private let reuseIdentifier = "ProductCell"

class ProductsViewController: UICollectionViewController, UpdateBadgeDelegate{

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var currProductCount: Int = 0
    
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
        notificationButton.addTarget(self, action: #selector(showCartForProductsSegue), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
    }
    
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let tileExtraSpace: CGFloat = 50
    var products: [Product] = []
    var isUnwinding: Bool = false
    
    
    
    @objc func showCartForProductsSegue(sender: UIBarButtonItem!) {
//        if KPAuthentication.shared.isLoggedIn() {
            performSegue(withIdentifier: "showCartForProductsSegue", sender: nil)
//        } else {
//            showLogin()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ProductsViewController.handleModalDismissed),
                                               name: NSNotification.Name(rawValue: "modalIsDimissed"),
                                               object: nil)
    
        loadProducts();
        
        menuButton.width = CGFloat(0.0)
        
        hideNavBorder()
        if PopupsController.shared.shouldShowInitialPopup == true {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"InitialPopupViewController")
            
            self.present(vc as! InitialPopupViewController, animated: true, completion: nil)
            PopupsController.shared .setShowInitialPopup(bool: false)
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let theShoppingCart = KPShoppingCart.instance
        let quantity = theShoppingCart.productCount
        
        self.drawBadge(quantity: quantity)
        
        if isUnwinding {
            KPShoppingCart.instance.products?.removeAll()
            isUnwinding = false
            MessageCenter.showMessage(rootViewController: self, message: "Order Submitted Successfully!")
        }
        
        
    }
    
    private func hideNavBorder() {
        let image = UIImage(named: "navbar.jpg")
        
        navigationController?.navigationBar.setBackgroundImage(image, for: .top, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func unwindToProductsHome(segue: UIStoryboardSegue) {}
    
    func loadProducts() {
        loadRealProducts()
    }
    
    private func loadRealProducts() {
        let loadURL = "/API/loadapplication.ashx"
        
        LoadingHandler.shared.showOverlayModal(viewController: self)
        KPService.getJSON(withURLString: loadURL, params: nil) { (values, error) in
            if let safeError = error {
//                MessageCenter.showMessage(rootViewController: self, message: safeError)
                let alert = CustomAlert(title: "No Network Connection", image: UIImage(named: "AppIcon")!)
                DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
                    alert.show(animated: true)
                    return
                })
            }
            
            guard let json = values else {
                print("invalid json")
                return
            }
            
            self.parseSettingsJSON(json: json)
            self.parseProductsJSON(json: json)
            self.loadRealStateInfo(json: json)
            self.collectionView?.reloadData()
            
            LoadingHandler.shared.hideOverlayModal(viewController: self)
        }
    }
    @objc private func handleModalDismissed() {
    loadRealProducts()
    }
    
    private func parseSettingsJSON(json: [String: Any?]) {
        if let settings = json["Settings"] as? [[String: Any?]] {
            let userDefaults = UserDefaults.standard
            
            for setting in settings {
                let key = setting["SettingKey"] as! String
                let value = setting["SettingValue"] as? String
                
                switch key {
                case "HeaderImage":
                    userDefaults.set(value ?? "", forKey: defaultKeys.headerImage)
                    break
                case "EULA":
                    userDefaults.set(value ?? "", forKey: defaultKeys.eula)
                    break;
                case "PrivacyPolicy":
                    userDefaults.set(value ?? "", forKey: defaultKeys.privacyPolicy)
                    break;
                case "CustomerServicePhone":
                    userDefaults.set(value ?? "", forKey: defaultKeys.contactPhoneNumber)
                    break
                case "CustomerServiceEmail":
                    userDefaults.set(value ?? "", forKey: defaultKeys.contactEmailAddress)
                    break
                case "CustomerServiceAddress":
                    userDefaults.set(value ?? "", forKey: defaultKeys.contactAddress)
                    break
                default:
                    break
                }
            }
        }
    }
    
    private func loadRealStateInfo(json: [String: Any?]) {
        stateInfo.states = []
        
        if let states = json["States"] as? [[String: Any?]] {
            for state in states {
                let id = state["StateId"] as? Int ?? -1
                let abbreviation = String(describing: state["StateAbbreviation"]!!)
                let name = String(describing: state["StateName"]!!)
                
                stateInfo.states.append(State(stateId: id, stateName: name, stateAbbreviation: abbreviation))
            }
        }
    }
    //FOR STYLISH PRODUCT LABELS OR ANY OTHER HTML TEXT FOR LABELS.
    private func getStringForLabel(label: UILabel, text: String){
        guard let data = text.data(using: String.Encoding.unicode) else {return}
        let attrString = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        label.attributedText = attrString
    }

    
    private func parseProductsJSON(json: [String: Any?]) {
        products = []
        
        if let safeProducts = json["Products"] as? [[String: Any?]] {
            for product in safeProducts {
                addProduct(jsonProduct: product)
            }
        }
    }
    
    private func addProduct(jsonProduct: [String: Any?]) {
        let product = Product()
        
        product.productId = jsonProduct["ProductId"] as! Int
        product.name = jsonProduct["Name"] as! String
        product.productDescription = jsonProduct["Description"] as! String
        product.price = jsonProduct["Price"] as! Float
        product.salePrice = jsonProduct["SalePrice"] as? Float ?? 0
        product.SKU = jsonProduct["Sku"] as! String
        product.stockCount = (jsonProduct["StockCount"] as? Int) ?? 0
        product.stockUnlimited = (jsonProduct["StockUnlimited"] as? Bool) ?? false
        product.isFeatured = (jsonProduct["IsFeatured"] as? Bool) ?? false
        product.images = (jsonProduct["ProductImages"] as? [String]) ?? []
        
        products.append(product)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SingleProductViewController {
            let selected = collectionView?.indexPathsForSelectedItems
            let indexPath = selected?[0]
            
            destination.product = products[indexPath!.row]
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if !KPAuthentication.shared.isLoggedIn(), identifier == "showCartForProductsSegue" {
//            showLogin()
//            return false
//        }
        
        return true
    }
    
    @IBAction func unwindToProducts(segue: UIStoryboardSegue) {
        isUnwinding = true
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageHeight = cell.frame.height - tileExtraSpace
        let product = products[indexPath.row]
        let titleLabel = getCellNameLabel(cell: cell, text: product.name, y: imageHeight)
        
        titleLabel.textColor = UIColor(rgb: 0x522100)
        titleLabel.font = UIFont.italicSystemFont(ofSize: 13)
        
        cell.backgroundColor = UIColor(rgb: 0xE6DCC5)
        
        
        removeAllSubviewsFromCell(cell: cell);
        
        cell.contentView.addSubview(getCellImage(cell: cell, product: product))
        cell.contentView.addSubview(titleLabel)
        cell.contentView.addSubview(getCellNameLabel(cell: cell, text: "$\(product.salePrice.format(f: ".2"))", y: imageHeight + tileExtraSpace / 2 + 8.5))
        
        cell.layer.cornerRadius = 3.5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    fileprivate func removeAllSubviewsFromCell(cell: UICollectionViewCell) {
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    fileprivate func getCellImage(cell: UICollectionViewCell, product: Product) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: cell.contentView.frame.width - 20, height: cell.contentView.frame.height - tileExtraSpace - 10))
        
        imageView.downloadedFrom(link: product.images[0])
        
        return imageView
    }
    
    fileprivate func getCellNameLabel(cell: UICollectionViewCell, text: String, y: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: 7, y: y - 20, width: cell.contentView.frame.width - 10, height: tileExtraSpace))
        
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        
        label.text = text
        label.textColor = UIColor(rgb: 0x522100)
        
        return label
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var daView : UICollectionReusableView! = nil
        
        if kind == UICollectionElementKindSectionHeader {
            daView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:"ProductCollectionHeader", for: indexPath)
            
            if daView.subviews.count == 0 {
                let imageView = UIImageView(frame: daView.frame)
                
                imageView.image = UIImage(named: "banner.jpg")
                
                daView.addSubview(imageView)
            }
        }
        
        return daView
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSingleProductSegue", sender: self)
    }
}

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + tileExtraSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension ProductsViewController : KPLoginable {
    func showLogin() {
        performSegue(withIdentifier: "showLoginForProductsSegue", sender: self)
    }
    
}

