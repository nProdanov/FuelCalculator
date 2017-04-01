//
//  BaseAuthData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/1/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol BaseAuthData {
    func setDelegate(delegate: AuthDataDelegate)
    func createUser(withEmail email: String, andPassword password: String)
    func signInUser(withEmail email: String, andPassowrd password: String)
    func getCurrentUser()
    func signOutUser()
}
