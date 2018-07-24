//
//  ShippingAddressView.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/13/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation
import InputMask

public class CheckoutShippingAddressView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, CheckoutValuesHolder, MaskedTextFieldDelegateListener {
    @IBOutlet weak var txtFirstName: KPTextField!
    @IBOutlet weak var txtLastName: KPTextField!
    @IBOutlet weak var txtEmailAddress: KPTextField!
    @IBOutlet weak var txtPhoneNumber: KPTextField!
    @IBOutlet weak var txtAddress: KPTextField!
    @IBOutlet weak var txtCity: KPTextField!
    @IBOutlet weak var txtState: KPTextField!
    @IBOutlet weak var txtPostalCode: KPTextField!
    @IBOutlet weak var btnNextStep: UIButton!
    
    let pickerView = UIPickerView()
    
    var inputDelegate: MaskedTextFieldDelegate!
    
    public override func awakeFromNib() {
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtState.inputAccessoryView = getPickerToolbar()
        txtState.inputView = pickerView
        
        inputDelegate = MaskedTextFieldDelegate(format: "([000])-[000]-[0000]")
        inputDelegate.listener = self
        
        txtPhoneNumber.delegate = inputDelegate
    }
    
    public func getValues() -> CheckoutValueSet {
        return CheckoutValueSet(name: "Shipping Address", values:
            [
                "FirstName": txtFirstName.text,
                "LastName": txtLastName.text,
                "Email": txtEmailAddress.text,
                "PhoneNumber": txtPhoneNumber.text,
                "Address": txtAddress.text,
                "City": txtCity.text,
                "State": txtState.text,
                "PostalCode": txtPostalCode.text
            ])
    }
    
    public func validate() -> CheckoutValidationValueSet {
        let valueSet = CheckoutValidationValueSet(stepNumber: 0)
        
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
        
        guard let phoneNumber = txtPhoneNumber.text, phoneNumber.count == 14 else {
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
}

extension CheckoutShippingAddressView : UITextFieldDelegate {
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
        
        return true
    }
}



