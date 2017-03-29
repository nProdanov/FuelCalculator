//
//  FirebaseChargesData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FireBaseChargesData: BaseRemoteChargesData
{
    private var dbReference: FIRDatabaseReference!
    var delegate: ChargesDataDelegate?
    
    init(){
        dbReference = FIRDatabase.database().reference()
    }
    
    func setDelegate(_ delegate: ChargesDataDelegate) {
        self.delegate = delegate
    }
    
    func createCharge(fromChargeInfo chargeInfo: Charge) {
        
    }
    
    func getAllCharges() {
        
    }
    
    func getAllChargesCount() {
        
    }
    
    func deleteCharge(byId id: String) {
        
    }
    
    private struct Constants {
        static let ChargesDbChild = "charges"
        static let GasStationDbChild = "gasStations"
    }
}
