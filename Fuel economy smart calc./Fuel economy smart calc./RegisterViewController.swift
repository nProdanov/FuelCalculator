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
    
    @IBOutlet weak var invalidRegisterLabel: UILabel!
    @IBOutlet weak var invalidMatchPassowrdsLabel: UILabel!
    @IBOutlet weak var invalidPasswordLabel: UILabel!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    @IBAction func register() {
        invalidRegisterLabel.isHidden = true
        if let email = emailTextField.text,
            let password = passwodTextFIeld.text,
            let repeatPassword = repeatPasswordTextField.text {
            
            let isValidEmail = self.isValidEmail(email)
            let isValidPassword = self.isValidPassword(password)
            let isPasswordsMatching = self.isPasswordsMatching(password, repeatPassword)
            
            invalidEmailLabel.isHidden = isValidEmail
            invalidPasswordLabel.isHidden = isValidPassword
            invalidMatchPassowrdsLabel.isHidden = isPasswordsMatching
            
            if isValidEmail, isValidPassword, isPasswordsMatching {
                    authData?.createUser(withEmail: email, andPassword: password)
            }
        }
    }
    
    var authData: BaseAuthData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureForDismissingKeyboard()
        
        emailTextField.delegate = self
        passwodTextFIeld.delegate = self
        repeatPasswordTextField.delegate = self
        
        authData = FirebaseAuthData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        invalidEmailLabel.isHidden = true
        invalidPasswordLabel.isHidden = true
        invalidMatchPassowrdsLabel.isHidden = true
        invalidRegisterLabel.isHidden = true
        
        authData?.setDelegate(delegate: self)
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
    
    private func isValidEmail(_ testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.characters.count >= 6
    }
    
    private func isPasswordsMatching(_ password: String, _ repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
    
}

extension RegisterViewController: AuthDataDelegate
{
    func didReceiveCreateUser(withEmail email: String) {
        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func didReceiveCreateUserError() {
        invalidRegisterLabel.isHidden = false
    }
}
