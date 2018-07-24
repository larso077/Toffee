//
//  SingleProductViewController.swift
//  KPToffee
//
//  Created by Erik Fisch on 4/14/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit

class SingleProductViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var txtProductDescription: UITextView!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var productImageScrollView: UIScrollView!
    @IBOutlet weak var lblProductSalePrice: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layoutIfNeeded()

        if let safeProduct = product {
            if safeProduct.price != safeProduct.salePrice {
                lblProductPrice.attributedText = getStrikethroughText(text: "$\(safeProduct.price.format(f: ".2"))")
                lblProductSalePrice.text = "$\(safeProduct.salePrice.format(f: ".2"))"
            } else {
                lblProductPrice.text = "$\(safeProduct.salePrice.format(f: ".2"))"
                lblProductSalePrice.text = ""
            }
            
            txtProductDescription.text = safeProduct.productDescription
            lblProductName.text = safeProduct.name
            productImageScrollView.delegate = self
            setupProductImageScrollView()
            txtProductDescription.sizeToFit()
            txtProductDescription.scrollRangeToVisible(NSRange(location: 0, length: 0))
        }
    }
    
    fileprivate func getStrikethroughText(text: String) -> NSAttributedString {
        let attString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, text.count)
        
        attString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: range)
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(rgb: 0x9B9B9B), range: range);
        
        return attString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        if let safeProduct = product {
            KPShoppingCart.instance.addProduct(product: safeProduct, quantity: Int(txtQuantity.text!)!)
            
            showAddedToCart()
        }
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        let currentQuantity = Int(txtQuantity.text!)
        
        if currentQuantity! > 1 {
            txtQuantity.text = "\(currentQuantity! - 1)"
        }
    }
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        let currentQuantity = Int(txtQuantity.text!)
        
        if currentQuantity! <= 99 {
            txtQuantity.text = "\(currentQuantity! + 1)"
        }
    }
    
    fileprivate func showAddedToCart() -> Void {
        let alert = UIAlertController(title: "Added to Cart!", message: "", preferredStyle: .alert)
        let delay = DispatchTime(uptimeNanoseconds: 0) + 1
        
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: delay){
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "unwindToProductHomeSegue", sender: self)
        }
    }
    
    // scrollview stuff
    fileprivate func setupProductImageScrollView() {
        productImageScrollView.layoutIfNeeded()
        
        if let imageArray = product?.images {
            for i in 0..<imageArray.count {
                let image = imageArray[i]
                let imageView = UIImageView()
                
                imageView.downloadedFrom(link: image, contentMode: .scaleAspectFit)
                addImageToScrollView(theView: imageView, index: i)
            }
            
            productImageScrollView.contentSize = CGSize(width: productImageScrollView.bounds.width * CGFloat(imageArray.count), height: productImageScrollView.frame.size.height)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    fileprivate func addImageToScrollView(theView: UIView, index: Int) {
        theView.frame.size.height = productImageScrollView.frame.size.height
        theView.frame.size.width = productImageScrollView.frame.size.width
        theView.frame.origin.x = CGFloat(index) * productImageScrollView.bounds.size.width
        
        productImageScrollView.addSubview(theView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
























