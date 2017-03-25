//
//  ViewControllerDismissKeyboard.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/25/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

extension UIViewController {
    func addGestureForDismissingKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
