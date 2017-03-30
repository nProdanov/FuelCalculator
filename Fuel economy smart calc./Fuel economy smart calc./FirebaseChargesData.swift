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
    var delegate: RemoteChargesDataDelegate?
    
    init(){
        dbReference = FIRDatabase.database().reference()
    }
    
    func setDelegate(_ delegate: RemoteChargesDataDelegate) {
        self.delegate = delegate
    }
    
    func createCharge(fromChargeInfo chargeInfo: Charge) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.dbReference
                .child(Constants.ChargesDbChild)
                .child(chargeInfo.id)
                .setValue(Charge.toDict(chargeInfo))
        }
    }
    
    func getAllCharges() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.dbReference
                .child(Constants.ChargesDbChild)
                .observeSingleEvent(of: .value, with: {(snapshop) in
                    var charges: [Charge] = []
                    if snapshop.exists() {
                        let chargesDict = snapshop.value as! NSDictionary
                        
                        for key in chargesDict.allKeys {
                            let currentChargeDict = chargesDict[key] as! NSDictionary
                            charges.append(Charge.fromDict(currentChargeDict))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didReceiveRemoteCharges(charges)
                    }
                    
                    
                }) {error in
                    self?.delegate?.didReceiveRemoteError(error: error)
            }
        }
        
    }
    
    func getAllChargesCount() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.dbReference
                .child(Constants.ChargesDbChild)
                .observeSingleEvent(of: .value, with: {(snapshop) in
                    DispatchQueue.main.async {
                        self?.delegate?.didReceiveRemoteChargesCount((snapshop.value as! [Any]).count)
                    }
                }) {error in
                    self?.delegate?.didReceiveRemoteError(error: error)
            }
        }
    }
    
    func deleteCharge(byId id: String) {
        
    }
    
    private struct Constants {
        static let ChargesDbChild = "charges"
        static let GasStationDbChild = "gasStations"
    }
}
