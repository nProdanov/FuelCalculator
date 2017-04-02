//
//  AccountViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/1/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITextFieldDelegate
{
    // Logout
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func logout() {
        authData?.signOutUser()
        emailLabel.text = ""
        
        hideLogoutStuff()
        showLoginStuff()
    }
    
    // Login
    @IBOutlet weak var loginFormLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var noAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var invaildLoginLabel: UILabel!
    
    @IBAction func login() {
        invaildLoginLabel.isHidden = true
        dismissKeyboard()
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            self.authData?.signInUser(withEmail: email, andPassowrd: password)
            showLoadingScreen()
        }
    }
    
    var authData: BaseAuthData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureForDismissingKeyboard()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        authData = FirebaseAuthData()
        authData?.setDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        invaildLoginLabel.isHidden = true
        
        authData?.getCurrentUser()
        showLoadingScreen()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextField { // Switch focus to
            passwordTextField.becomeFirstResponder()
        }
        
        if textField == passwordTextField {
            login()
        }
        return true
    }
    
    fileprivate func showLogoutStuff() {
        accountLabel.isHidden = false
        logoutButton.isHidden = false
        emailLabel.isHidden = false
    }
    
    fileprivate func hideLogoutStuff() {
        accountLabel.isHidden = true
        logoutButton.isHidden = true
        emailLabel.isHidden = true
    }
    
    fileprivate func showLoginStuff() {
        loginFormLabel.isHidden = false
        emailTextField.isHidden = false
        passwordLabel.isHidden = false
        passwordTextField.isHidden = false
        loginButton.isHidden = false
        noAccountButton.isHidden = false
    }
    
    fileprivate func hideLoginStuff() {
        loginFormLabel.isHidden = true
        emailTextField.isHidden = true
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        loginButton.isHidden = true
        noAccountButton.isHidden = true
    }
}

extension AccountViewController: AuthDataDelegate
{
    func didReceiveSignInUserError() {
        invaildLoginLabel.isHidden = false
        
        hideLoadingScreen()
    }
    
    func didReceiveSignInUser(withEmail email: String) {
        hideLoadingScreen()
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        hideLoginStuff()
        showLogoutStuff()
        emailLabel.text = email
    }
    
    func didReceiveCurrentUser(withEmail email: String?) {
        hideLoadingScreen()
        
        if email != nil {
            hideLoginStuff()
            showLogoutStuff()
            emailLabel.text = email
        } else {
            hideLogoutStuff()
            showLoginStuff()
        }
    }
}
