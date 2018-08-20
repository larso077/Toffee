import UIKit
import AVFoundation
import Stripe
import Alamofire

class CheckoutModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitOrderButton: UIButton!
    @IBOutlet weak var modalViewNavigationBar: UINavigationBar!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    var basicInfoList: [CheckoutReviewBasicInfo]?
    var mediaInfo: MediaInfo?
    var order: Order?
    var isForCheckout: Bool = true
    weak var delegate: CheckoutViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isForCheckout {
            modalTransitionStyle = .coverVertical
            modalPresentationStyle = .fullScreen
            modalPresentationCapturesStatusBarAppearance = true
        } else {
            submitOrderButton.isHidden = true
            loadPastOrderInformation()
        }
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 140
    }
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Do you wish to cancel?", message: "Cancelling the order will bring you back to the checkout.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: {_ in self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: {_ in alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated:true, completion: nil)
    }
    
    @IBAction func submitOrderClicked(_ sender: UIButton) {
        let card = getStripeCard()
        
        LoadingHandler.shared.showOverlayModal(viewController: self)
        
        STPAPIClient.shared().createToken(withCard: card) { (token, error) in
            if let safeError = error {
                LoadingHandler.shared.hideOverlayModal(viewController: self)
                MessageCenter.showMessage(rootViewController: self, message: safeError.localizedDescription)
            } else if let safeToken = token {
                self.sendOrderToServer(token: safeToken)
            } else {
                LoadingHandler.shared.hideOverlayModal(viewController: self)
                MessageCenter.showMessage(rootViewController: self, message: "Internal error.")
            }
        }
    }
    
    fileprivate func loadPastOrderInformation() {
        let urlString = "/API/Orders/GetOrderById.ashx"
        let userDefaults = UserDefaults.standard
        
        LoadingHandler.shared.showOverlay(view: self.view)
        
        guard let safeOrder = order else {
            return
        }
        
        KPService.getJSON(withURLString: urlString, params: [
            "Token": userDefaults.string(forKey: defaultKeys.authToken)!,
            "OrderId": safeOrder.orderId.description
        ]) { (values, error) in
            if let safeError = error {
                MessageCenter.showMessage(rootViewController: self, message: safeError)
                return
            }
            
            guard let safeValues = values else {
                LoadingHandler.shared.hideOverlayView()
                return
            }
            
            if let shippingAddress = safeValues["ShippingAddress"] as? [String: Any?] {
                self.order?.shippingAddress = Address(values: shippingAddress)
            }
            
            if let billingAddress = safeValues["BillingAddress"] as? [String: Any?] {
                self.order?.billingAddress = BillingAddress(values: billingAddress)
            }
            
            self.tableView.reloadData()
            
            LoadingHandler.shared.hideOverlayView()
        }
    }
    
    fileprivate func sendOrderToServer(token: STPToken) {
        let mediaData = getMediaData()
        let stringData = mediaData?.base64EncodedData(options: .lineLength64Characters)
        let destination = "/API/orders/placeorder.ashx"
        
        KPService.upload(withURLString: destination, mediaData: stringData, requestParams: getOrderParameters(stripeToken: token)) { (results) in
            if let safeResults = results, let result = safeResults[0]["Result"] as? String {
                LoadingHandler.shared.hideOverlayModal(viewController: self)

                if result == "Success" {
                    self.goBackToProductsView()
                } else {
                    MessageCenter.showMessage(rootViewController: self, message: "There was an error processing the order, please try again.")
                }
            }
        }
    }
    
    fileprivate func getMediaData() -> Data? {
        if let videoURL = mediaInfo?.videoSrc {
            let url = URL(fileURLWithPath: videoURL)
            do {
                return try Data(contentsOf: url, options: .mappedIfSafe)
            } catch {
                return nil
            }
        } else if let _ = mediaInfo?.actualImage {
            return (UIImageJPEGRepresentation((mediaInfo?.actualImage!)!, 0.5) as Data?)!
        }
        
        return nil
    }
    
    fileprivate func goBackToProductsView() {
        if let presenter = self.delegate {
            self.dismiss(animated: true, completion: {
                presenter.performSegue(withIdentifier: "unwindBackToProductsSegue", sender: presenter)
            })
        }
    }
    
    fileprivate func getOrderParameters(stripeToken: STPToken) -> [String: Any] {
        var values: [String: Any] = [:]
        let userDefaults = UserDefaults.standard
        
        guard let safeOrder = order, let shipping = safeOrder.shippingAddress else {
            return values
        }
        
        values["Token"] = userDefaults.string(forKey: defaultKeys.authToken)
        values["StripeToken"] = stripeToken
        values["StripeEmail"] = "efisch26@gmail.com"
        values["ShippingFirstName"] = shipping.firstName
        values["ShippingLastName"] = shipping.lastName
        values["ShippingStreet"] = shipping.street
        values["ShippingCity"] = shipping.city
        values["ShippingStateId"] = shipping.state.stateId
        values["ShippingZipCode"] = shipping.zipcode
        values["BillingSameAsShipping"] = safeOrder.billingAddress?.sameAsShipping
        
        if let billing = safeOrder.billingAddress, billing.sameAsShipping {
            values["BillingFirstName"] = shipping.firstName
            values["BillingLastName"] = shipping.lastName
            values["BillingStreet"] = shipping.street
            values["BillingCity"] = shipping.city
            values["BillingStateId"] = shipping.state.stateId
            values["BillingZipCode"] = shipping.zipcode
        } else if let billing = safeOrder.billingAddress {
            values["BillingFirstName"] = billing.firstName
            values["BillingLastName"] = billing.lastName
            values["BillingStreet"] = billing.street
            values["BillingCity"] = billing.city
            values["BillingStateId"] = billing.state.stateId
            values["BillingZipCode"] = billing.zipcode
        }
        
        // media stuff
        values["Title"] = mediaInfo?.mediaTitle ?? "No Title"
        values["Message"] = mediaInfo?.messageText ?? "No message, sorry."
        
        if let _ = mediaInfo?.videoSrc {
            values["MediaContentType"] = "video/mp4"
        } else if let _ = mediaInfo?.actualImage {
            values["MediaContentType"] = "image/jpeg"
        }
        
        // totals stuff
        values["SubTotal"] = KPShoppingCart.instance.subtotal
        values["Tax"] = KPShoppingCart.instance.tax
        values["Shipping"] = 0.00
        values["GrandTotal"] = safeOrder.total
        values["Products"] = getProductsList()
        
        return values
    }
    
    fileprivate func getProductsList() -> [[String: Any]] {
        var products: [[String: Any]] = []
        
        guard let safeProductQuantityList = KPShoppingCart.instance.products else {
            return products
        }
        
        for productQuantity in safeProductQuantityList {
            products.append([
                "ProductId": productQuantity.product.productId,
                "Quantity": productQuantity.quantity
                ])
        }
        
        return products
    }
    
    fileprivate func startLoading() {
        LoadingHandler.shared.showOverlay(view: self.view)
        self.view.isHidden = true
    }
    
    fileprivate func endLoading() {
        self.view.isHidden = false
        LoadingHandler.shared.hideOverlayView()
    }
    
    fileprivate func getStripeCard() -> STPCardParams {
        let card = STPCardParams()
        let paymentInfo = order!.paymentInfo!
        
        card.expYear = UInt(paymentInfo.expirationYear)
        card.expMonth = UInt(paymentInfo.expirationMonth)
        card.number = paymentInfo.cardNumber
        card.cvc = String(describing: paymentInfo.cvv)
        
        return card
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
            return UITableViewAutomaticDimension
        } else {
            return 335
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isForCheckout {
            return 4
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            return getBasicCell(tableView: tableView, indexPath: indexPath)
        } else {
            return getMediaCell(tableView: tableView, indexPath: indexPath)
        }
    }
     
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    fileprivate func getBasicCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewInfoBasicCell", for: indexPath) as! CheckoutReviewBasicCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Shipping Address"
            cell.contentLabel.text = order?.shippingAddress?.description
            break
        case 1:
            cell.titleLabel.text = "Billing Address"
            cell.contentLabel.text = order?.billingAddress?.description
            break
        case 2:
            cell.titleLabel.text = "Payment Info"
            cell.contentLabel.text = order?.paymentInfo?.description
            break
        default:
            break
        }
        
        cell.contentLabel.sizeToFit()
        
        return cell
    }
    
    fileprivate func getMediaCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewInfoMediaCell", for: indexPath) as! CheckoutReviewMediaCell
        
        cell.messageTextView.text = mediaInfo?.messageText
        
        if let image = mediaInfo?.actualImage {
            cell.mediaImageView.image = image
        } else if let _ = mediaInfo?.videoSrc {
            showVideoPreview(cell: cell)
        } else {
            cell.mediaImageView.isHidden = true
        }
        
        return cell
    }
    
    fileprivate func showVideoPreview(cell: CheckoutReviewMediaCell) {
        let asset = AVURLAsset(url: URL(fileURLWithPath: (mediaInfo?.videoSrc)!))
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let image = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            
            cell.mediaImageView.image = UIImage(cgImage: image, scale: 1, orientation: .right)
        } catch {
            print(error)
        }
    }
}
