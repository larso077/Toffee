//
//  ImagePickerDelegate.swift
//  KPToffee
//
//  Created by Erik Fisch on 5/20/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation

protocol ImagePickerDelegate {
    func requestedImagePicker(_ sender: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
}
