//
//  ChargesData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

class ChargesData: BaseChargesData
{
    var delegate: ChargesDataDelegate?
    
    func setDelegate(_ delegate: ChargesDataDelegate){
        self.delegate = delegate
    }
    
    func getCurrentCharge() {
        
    }
    
    func createCurrentCharge(from currCharge: CurrentCharge) {
        
    }
    
    func createCharge(fromCurrentCharge currentCharge: CurrentCharge) {
        
    }
    
    func getAllCharges() {
     
    }
    
    func deleteCharge(byId id: String) {
        
    }
}
