import UIKit
import AVFoundation

class CheckoutViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var pagingControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // private variables
    
    private var checkoutViews: [UIView] = []
    private var horizontalScrollIsLocked: Bool = false
    private var nextStepScrollIsLocked: Bool = true
    private var lastOffsetX: CGFloat = 0
    private var currentValueSet: CheckoutValueSet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded() // without this I am not getting the proper width from self.view.frame.width
        scrollView.delegate = self
        loadCheckoutViews()
        pagingControl.numberOfPages = checkoutViews.count
        hideKeyboardWhenTappedAround()
        
        if PopupsController.shared.shouldShowCheckoutPopup == true {
            performSegue(withIdentifier: "showPopup", sender: self)
        }
        
    }
    
    @objc func setStep(sender: UIButton) {
        goToStep(sender.tag + 1)
    }
    
    func goToStep(_ index: Int) {
        var frame = scrollView.frame
        
        frame.origin.x = frame.size.width * CGFloat(index);
        frame.origin.y = 0;
        
        view.endEditing(true)
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    // NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ReviewCheckoutSectionViewController {
            dest.checkoutValueSet = currentValueSet
        } else if segue.identifier! == "showCheckoutReviewModallySegue" {
            let dest = segue.destination as! CheckoutModalViewController
            let valueSets = getAllValueSets()
            let order = Order()
            
            order.shippingAddress = getShippingAddress()
            order.billingAddress = getBillingAddress()
            order.subtotal = KPShoppingCart.instance.subtotal
            order.tax = KPShoppingCart.instance.tax
            order.paymentInfo = getPaymentInfo()
            
            dest.basicInfoList = valueSets.map({ (valueSet) -> CheckoutReviewBasicInfo in
                return CheckoutReviewBasicInfo(title: valueSet.name, content: valueSet.getRegularString())
            })
            
            dest.mediaInfo = getMediaInfo()
            
            dest.order = order
            dest.delegate = self
        }
    }
    
    
    
    fileprivate func getShippingAddress() -> Address {
        let shippingView = checkoutViews[0] as! CheckoutShippingAddressView
        let address = Address(firstName: shippingView.txtFirstName.text!, lastName: shippingView.txtLastName.text!, street: shippingView.txtAddress.text!, line2: shippingView.txtAddressLine2.text!, city: shippingView.txtCity.text!, stateId: Int(shippingView.txtState.tag), zipcode: Int(shippingView.txtPostalCode.text!)!)
        
        return address
    }
    
    fileprivate func getBillingAddress() -> BillingAddress {
        let billingView = checkoutViews[2] as! CheckoutBillingView
        
        if billingView.switchUseShippingAddress.isOn {
            let shipping = getShippingAddress()
            let address = BillingAddress(firstName: shipping.firstName, lastName: shipping.lastName, street: shipping.street, line2: shipping.line2!, city: shipping.city, stateId: shipping.state.stateId, zipcode: shipping.zipcode)
            
            address.sameAsShipping = true
            
            return address
        } else {
            return BillingAddress(firstName: billingView.txtFirstName.text!, lastName: billingView.txtLastName.text!, street: billingView.txtAddress.text!, line2: billingView.txtAddressLine2.text!, city: billingView.txtCity.text!, stateId: Int(billingView.txtState.tag), zipcode: Int(billingView.txtPostalCode.text!)!)
        }
    }
    
    fileprivate func getPaymentInfo() -> PaymentInformation {
        let paymentView = checkoutViews[1] as! CheckoutCardInfoView
        let info = PaymentInformation(cardNumber: paymentView.txtCardNumber.text!, expirationDate: paymentView.txtExpirationDate.text!, cvv: Int(paymentView.txtCVV.text!)!)
        
        return info
    }
    
    fileprivate func getMediaInfo() -> MediaInfo {
        let mediaView = checkoutViews.last as! CheckoutMediaView
        
        return mediaView.getMediaInformation()
    }
    
    // DELEGATE METHODS
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if horizontalScrollIsLocked {
            scrollView.contentOffset.x = lastOffsetX
        } else {
            let page = scrollView.contentOffset.x / scrollView.frame.size.width
            
            pagingControl.currentPage = Int(page)
            lastOffsetX = scrollView.contentOffset.x
            
            // stop the vertical scrolling
            scrollView.contentOffset.y = 0
        }
    }
    
    public func showReviewInformation(sender: Any) {
        let valueSets = getAllValueSets()
        
        switch (sender as! UIButton).tag {
        case 4:
            currentValueSet = valueSets.first(where: { (set) -> Bool in
                set.name == "Shipping Address"
            })
            performSegue(withIdentifier: "showReviewInformationSegue", sender: self)
            break
        case 5:
            currentValueSet = valueSets.first(where: { (set) -> Bool in
                set.name == "Payment Info"
            })
            performSegue(withIdentifier: "showReviewInformationSegue", sender: self)
            break
        case 6:
            currentValueSet = valueSets.first(where: { (set) -> Bool in
                set.name == "Billing Address"
            })
            performSegue(withIdentifier: "showReviewInformationSegue", sender: self)
            break
        case 7:
            currentValueSet = valueSets.first(where: { (set) -> Bool in
                set.name == "Message"
            })
            performSegue(withIdentifier: "showReviewInformationSegue", sender: self)
            break
        default: break
        }
    }
    
    fileprivate func getAllValueSets() -> [CheckoutValueSet] {
        let valueHolders = checkoutViews.filter {
            $0 is CheckoutValuesHolder
        }
        
        return valueHolders.map {
            ($0 as! CheckoutValuesHolder).getValues()
        }
    }
    
    fileprivate func loadCheckoutViews() {
        checkoutViews = []
        
        if let safeView = getShippingView() {
            safeView.btnNextStep.tag = 0
            checkoutViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 0)
        }
        
        if let safeView = getCardInfoView() {
            safeView.btnNextStep.tag = 1
            checkoutViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 1)
        }
        
        if let safeView = getBillingView() {
            safeView.btnNextStep.tag = 2
            checkoutViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 2)
        }
        
        if let safeView = getMediaView() {
            safeView.btnNextStep.tag = 3
            checkoutViews.append(safeView)
            addSlideToScrollView(theView: safeView, index: 3)
        }
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(checkoutViews.count), height: scrollView.frame.height)
    }
    
    fileprivate func addSlideToScrollView(theView: UIView, index: Int) {
        theView.tag = index
        theView.frame.size.height = self.scrollView.frame.size.height
        theView.frame.size.width = self.view.frame.width
        theView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
        
        scrollView.addSubview(theView)
    }
    
    fileprivate func getShippingView() -> CheckoutShippingAddressView? {
        let theView = Bundle.main.loadNibNamed("CheckoutShippingAddress", owner: self, options: nil)?.first as? CheckoutShippingAddressView
        
        theView?.btnNextStep.addTarget(self, action:#selector(setStep(sender:)), for: .touchUpInside)
        
        return theView
    }
    
    fileprivate func getCardInfoView() -> CheckoutCardInfoView? {
        let theView = Bundle.main.loadNibNamed("CheckoutCardInfo", owner: self, options: nil)?.first as? CheckoutCardInfoView
        
        theView?.btnNextStep.addTarget(self, action:#selector(setStep(sender:)), for: .touchUpInside)
        
        return theView
    }
    
    fileprivate func getBillingView() -> CheckoutBillingView? {
        let theView = Bundle.main.loadNibNamed("CheckoutBilling", owner: self, options: nil)?.first as? CheckoutBillingView
        
        theView?.btnNextStep.addTarget(self, action:#selector(setStep(sender:)), for: .touchUpInside)
        
        return theView
    }
    
    fileprivate func getMediaView() -> CheckoutMediaView? {
        let theView: CheckoutMediaView? = Bundle.main.loadNibNamed("CheckoutMedia", owner: self, options: nil)?.first as? CheckoutMediaView
        
        theView?.btnNextStep.addTarget(self, action: #selector(showCheckoutModal(sender:)), for: .touchUpInside)
        theView?.btnRemoveMedia.isHidden = true
        
        return theView
    }
    
    @objc func showCheckoutModal(sender: UIView) {
        if validateValues() {
            self.performSegue(withIdentifier: "showCheckoutReviewModallySegue", sender: self)
        }
    }
    
    fileprivate func validateValues() -> Bool {
        var isValid = true
        
        for view in checkoutViews {
            guard let valueHolder = view as? CheckoutValuesHolder else {
                continue
            }
            
            let validation = valueHolder.validate()
            
            if !validation.isValid {
                isValid = false
                goToStep(validation.stepNumber)
                showValidationMessage(message: validation.message)
                break
            }
        }
        
        return isValid
    }
    
    fileprivate func showValidationMessage(message: String) {
        let alert = UIAlertController(title: "Invalid Values", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // KEYBOARD
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CheckoutViewController.keyboardDidShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CheckoutViewController.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        horizontalScrollIsLocked = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        horizontalScrollIsLocked = false
    }
}

