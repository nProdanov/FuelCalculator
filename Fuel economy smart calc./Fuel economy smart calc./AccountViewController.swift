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
        dismissKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForDismissingKeyboard()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        invaildLoginLabel.isHidden = true
        hideLogoutStuff()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    private func showLogoutStuff() {
        accountLabel.isHidden = false
        logoutButton.isHidden = false
        emailLabel.isHidden = false
    }
    
    private func hideLogoutStuff() {
        accountLabel.isHidden = true
        logoutButton.isHidden = true
        emailLabel.isHidden = true
    }
    
    private func showLoginStuff() {
        loginFormLabel.isHidden = false
        emailTextField.isHidden = false
        passwordLabel.isHidden = false
        passwordTextField.isHidden = false
        loginButton.isHidden = false
        noAccountButton.isHidden = false
    }
    
    private func hideLoginStuff() {
        loginFormLabel.isHidden = true
        emailTextField.isHidden = true
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        loginButton.isHidden = true
        noAccountButton.isHidden = true
    }
}
