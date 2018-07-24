//
//  CheckoutCardInfoView.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/15/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

public class CheckoutCardInfoView: UIView, CheckoutValuesHolder, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var txtCardNumber: KPTextField!
    @IBOutlet weak var txtExpirationDate: KPTextField!
    @IBOutlet weak var txtCVV: KPTextField!
    
    @IBOutlet weak var btnNextStep: UIButton!
    
    private var datePicker = UIPickerView()
    private var months = [
        "01 - January",
        "02 - February",
        "03 - March",
        "04 - April",
        "05 - May",
        "06 - June",
        "07 - July",
        "08 - August",
        "09 - September",
        "10 - October",
        "11 - November",
        "12 - December"
    ]
    private var monthNumbers = [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12"
    ]
    private var years = [String]()
    
    public override func awakeFromNib() {
        datePicker.delegate = self
        datePicker.dataSource = self
        
        datePicker.showsSelectionIndicator = true
        
        setYears()
        txtExpirationDate.inputAccessoryView = getPickerToolbar()
        txtExpirationDate.inputView = datePicker
        
        datePicker.selectRow(0, inComponent: 0, animated: false)
        datePicker.selectRow(0, inComponent: 1, animated: false)
    }
    
    public func getValues() -> CheckoutValueSet {
        return CheckoutValueSet(name: "Payment Info", values:
            [
                "CardNumber": txtCardNumber.text,
                "ExpirationDate": txtExpirationDate.text,
                "CVV": txtCVV.text
            ])
    }
    
    public func validate() -> CheckoutValidationValueSet {
        let valueSet = CheckoutValidationValueSet(stepNumber: 1)
        
        guard let cardNumber = txtCardNumber.text, cardNumber.count >= 12 && cardNumber.count <= 19 else {
            valueSet.message = "Please enter a valid credit card number"
            return valueSet
        }
        
        guard let _ = txtExpirationDate.text else {
            valueSet.message = "Please select an expiration date"
            return valueSet
        }
        
        guard let cvv = txtCVV.text, cvv.count == 3 || cvv.count == 4 else {
            valueSet.message = "Please enter a valid CVV number"
            return valueSet
        }
        
        valueSet.isValid = true
        valueSet.message = "Success"
        
        return valueSet
    }
    
    private func setYears() {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        years = []
        
        for i in 0...9 {
            years.append(String(describing: currentYear + i))
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 12
        } else {
            return 10
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return months[row]
        } else {
            return years[row]
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let newLength = text.count + string.count - range.length
        
        return newLength <= 4
    }
    
    @objc public func completeDateSelection() {
        let monthIndex = datePicker.selectedRow(inComponent: 0)
        let yearIndex = datePicker.selectedRow(inComponent: 1)
        
        txtExpirationDate.text = "\(monthNumbers[monthIndex])/\(years[yearIndex])"
        txtCVV.becomeFirstResponder()
    }
    
    private func getPickerToolbar() -> UIToolbar {
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(completeDateSelection))
        let toolbar = UIToolbar()
        
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        return toolbar;
    }
}
