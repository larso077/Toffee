//
//  CheckoutBillingView.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/13/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class CheckoutBillingView : UIView, UIPickerViewDelegate, UIPickerViewDataSource, CheckoutValuesHolder {
    @IBOutlet weak var switchUseShippingAddress: UISwitch!
    
    @IBOutlet weak var txtFirstName: KPTextField!
    @IBOutlet weak var txtLastName: KPTextField!
    @IBOutlet weak var txtEmailAddress: KPTextField!
    @IBOutlet weak var txtPhoneNumber: KPTextField!
    @IBOutlet weak var txtAddress: KPTextField!
    @IBOutlet weak var txtAddressLine2: KPTextField!
    @IBOutlet weak var txtCity: KPTextField!
    @IBOutlet weak var txtState: KPTextField!
    @IBOutlet weak var txtPostalCode: KPTextField!
    @IBOutlet weak var btnNextStep: UIButton!
    @IBOutlet weak var addressLine2Info: UILabel!
    @IBOutlet weak var showInfoAddress2: UIButton!
    
    let pickerView = UIPickerView()
    var check = 0
    
    public override func awakeFromNib() {
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtState.inputAccessoryView = getPickerToolbar()
        txtState.inputView = pickerView
    }
    
    public func getValues() -> CheckoutValueSet {
        return CheckoutValueSet(name: "Billing Address", values:
            [
                "UseShippingAddress": String(describing: switchUseShippingAddress.isOn),
                "FirstName": txtFirstName.text,
                "LastName": txtLastName.text,
                "Email": txtEmailAddress.text,
                "PhoneNumber": txtPhoneNumber.text,
                "Address": txtAddress.text,
                "AddressLine2": txtAddressLine2.text,
                "City": txtCity.text,
                "State": txtState.text,
                "PostalCode": txtPostalCode.text
            ])
    }
    
    @IBAction func revealAddress2Info(_ sender: Any) {
        // city state zip movement
        let amount: CGFloat = 20
        if addressLine2Info.isHidden == true {
            UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: 7), animations: {
                self.txtCity.frame.origin.y+=amount
                self.txtState.frame.origin.y+=amount
                self.txtPostalCode.frame.origin.y+=amount
            },completion: nil)
            check = 1
            addressLine2Info.isHidden = false
        }
        else{
            UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: 7), animations: {
                self.txtCity.frame.origin.y-=amount
                self.txtState.frame.origin.y-=amount
                self.txtPostalCode.frame.origin.y-=amount
            },completion: nil)
            check = 0
            addressLine2Info.isHidden = true
        }
    }
    
    public func validate() -> CheckoutValidationValueSet {
        let valueSet = CheckoutValidationValueSet(stepNumber: 2)
        
        if switchUseShippingAddress.isOn {
            valueSet.isValid = true
            valueSet.message = "Success"
            return valueSet
        }
        
        guard let firstName = txtFirstName.text, firstName.count > 1 else {
            valueSet.message = "Please enter a valid first name"
            return valueSet
        }
        
        guard let lastName = txtLastName.text, lastName.count > 1 else {
            valueSet.message = "Please enter a valid last name"
            return valueSet
        }
        
        guard let email = txtEmailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines), email.isValidEmailAddress() else {
            valueSet.message = "Please enter a valid email address"
            return valueSet
        }
        
        guard let phoneNumber = txtPhoneNumber.text, phoneNumber.count == 10 else {
            valueSet.message = "Please enter a valid 10 digit phone number"
            return valueSet
        }
        
        guard let address = txtAddress.text, address.count >= 3 else {
            valueSet.message = "Please enter a valid address"
            return valueSet
        }
        
        
        guard let city = txtCity.text, city.count > 1 else {
            valueSet.message = "Please enter a valid city"
            return valueSet
        }
        
        guard let state = txtState.text, state.count > 1 else {
            valueSet.message = "Please select a valid state"
            return valueSet
        }
        
        guard let postalCode = txtPostalCode.text, postalCode.count == 5 || postalCode.count == 9 else {
            valueSet.message = "Please enter a valid 5 or 9 digit postal code"
            return valueSet
        }
        
        valueSet.isValid = true
        valueSet.message = "Success"
        
        return valueSet
    }
    
    @IBAction func useShippingAddressChanged(_ sender: UISwitch!) {
        hideBillingThings(sender.isOn)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateInfo.states.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = stateInfo.states[row]
        
        return state.stateName
    }
    
    @objc public func completeStateSelection() {
        let stateIndex = pickerView.selectedRow(inComponent: 0)
        
        txtState.text = stateInfo.states[stateIndex].stateAbbreviation
        txtState.tag = stateIndex + 1
        txtPostalCode.becomeFirstResponder()
    }
    
    private func getPickerToolbar() -> UIToolbar {
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(completeStateSelection))
        let toolbar = UIToolbar()
        
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        return toolbar;
    }
    
    fileprivate func hideBillingThings(_ shouldHide: Bool) {
        txtFirstName.isHidden = shouldHide
        txtLastName.isHidden = shouldHide
        txtEmailAddress.isHidden = shouldHide
        txtPhoneNumber.isHidden = shouldHide
        txtAddress.isHidden = shouldHide
        txtAddressLine2.isHidden = shouldHide
        txtCity.isHidden = shouldHide
        txtState.isHidden = shouldHide
        txtPostalCode.isHidden = shouldHide
        showInfoAddress2.isHidden = shouldHide
        
        if addressLine2Info.isHidden == true{
            if check == 1 {
                addressLine2Info.isHidden = false
            }
            else if check == 0{
                addressLine2Info.isHidden = true
            } else {
                addressLine2Info.isHidden = false
            }
        }
        else if addressLine2Info.isHidden == false{
            addressLine2Info.isHidden = true
        }
    }
}


extension CheckoutBillingView : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName {
            txtLastName.becomeFirstResponder()
        } else if textField == txtLastName {
            txtEmailAddress.becomeFirstResponder()
        } else if textField == txtEmailAddress {
            txtPhoneNumber.becomeFirstResponder()
        } else if textField == txtAddress {
            txtCity.becomeFirstResponder()
        } else if textField == txtCity {
            txtState.becomeFirstResponder()
        }
        
        return true;
    }
}


