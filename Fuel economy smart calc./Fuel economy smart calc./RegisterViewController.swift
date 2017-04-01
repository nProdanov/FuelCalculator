//
//  RegisterViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/1/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate
{
    
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var passwodTextFIeld: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var invalidMatchPassowrdsLabel: UILabel!
    @IBOutlet weak var invalidPasswordLabel: UILabel!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    @IBAction func register() {
        dismissKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureForDismissingKeyboard()
        
        emailTextField.delegate = self
        passwodTextFIeld.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        invalidEmailLabel.isHidden = true
        invalidPasswordLabel.isHidden = true
        invalidMatchPassowrdsLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextField { // Switch focus to
            passwodTextFIeld.becomeFirstResponder()
        }
        
        if textField == passwodTextFIeld {
            repeatPasswordTextField.becomeFirstResponder()
        }
        
        if textField == repeatPasswordTextField {
            register()
        }
        return true
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
