//
//  AuthDataDelegate.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/1/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol AuthDataDelegate
{
    func didReceiveCreateUser(withEmail email: String)
    func didReceiveSignInUser(withEmail email: String)
    func didReceiveCurrentUser(withEmail email: String?)
    func didReceiveCreateUserError()
    func didReceiveSignInUserError()    
}

extension AuthDataDelegate
{
    func didReceiveCreateUser(withEmail email: String){
        
    }
    
    func didReceiveSignInUser(withEmail email: String){
        
    }
    
    func didReceiveCurrentUser(withEmail email: String?){
        
    }
    
    func didReceiveCreateUserError(){
        
    }
    
    func didReceiveSignInUserError(){
        
    }
}
