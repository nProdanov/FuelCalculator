//
//  ChargesDataDelegate.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol ChargesDataDelegate
{
    func didReceiveCurrentCharge(_ currentCharge: CurrentCharge?)
    func didCreateCurrentCharge()
    func didCreateCharge()
    func didReceiveAllCharges(_ charges: [Charge])
    func didDeleteCharge()
}

extension ChargesDataDelegate
{
    func didReceiveCurrentCharge(_ currentCharge: CurrentCharge?) {
        
    }
    
    func didCreateCurrentCharge(){
        
    }
    
    func didCreateCharge() {
        
    }
    
    func didReceiveAllCharges(_ charges: [Charge]) {
        
    }
    
    func didDeleteCharge(){
        
    }
}

