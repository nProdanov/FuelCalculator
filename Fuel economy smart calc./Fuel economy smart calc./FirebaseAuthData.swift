//
//  FirebaseAuthData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/1/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseAuthData: BaseAuthData {
    
    var delegate: AuthDataDelegate?
    
    init() {
    }
    
    func setDelegate(delegate: AuthDataDelegate){
        self.delegate = delegate
    }
    
    func createUser(withEmail email: String, andPassword password: String){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                DispatchQueue.main.async {
                    if let user = user {
                        self?.delegate?.didReceiveCreateUser(withEmail: user.email!)
                    } else {
                        self?.delegate?.didReceiveCreateUserError()
                    }
                }
            }
        }
    }
    
    func signInUser(withEmail email: String, andPassowrd password: String){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                DispatchQueue.main.async {
                    if let user = user {
                        self?.delegate?.didReceiveSignInUser(withEmail: user.email!)
                    } else {
                        self?.delegate?.didReceiveSignInUserError()
                    }
                }
            }
        }
    }
    
    func getCurrentUser(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let user = FIRAuth.auth()?.currentUser
            DispatchQueue.main.async {
                if let user = user {
                    self?.delegate?.didReceiveCurrentUser(withEmail: user.email!)
                } else {
                    self?.delegate?.didReceiveCurrentUser(withEmail: nil)
                }
            }
        }
    }
    
    func signOutUser() {
        DispatchQueue.global(qos: .userInitiated).async {
            try? FIRAuth.auth()?.signOut()
        }
    }
}
