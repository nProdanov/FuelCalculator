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
import FirebaseAuth

class FireBaseChargesData: BaseRemoteChargesData
{
    private var dbReference: FIRDatabaseReference!
    var delegate: RemoteChargesDataDelegate?
    
    init(){
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
        
        dbReference = FIRDatabase.database().reference()
    }
    
    func setDelegate(_ delegate: RemoteChargesDataDelegate) {
        self.delegate = delegate
    }
    
    func createCharge(fromChargeInfo chargeInfo: Charge) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let user = FIRAuth.auth()?.currentUser
            
            if user != nil {
                self?.dbReference
                    .child(Constants.ChargesDbChild)
                    .child(user!.uid)
                    .child(chargeInfo.id)
                    .setValue(Charge.toDict(chargeInfo))
            }
        }
    }
    
    func getAllCharges() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let user = FIRAuth.auth()?.currentUser
            
            if user != nil {
                self?.dbReference
                    .child(Constants.ChargesDbChild)
                    .child(user!.uid)
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
    }
    
    func getAllChargesCount() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let user = FIRAuth.auth()?.currentUser
            
            if user != nil {
                self?.dbReference
                    .child(Constants.ChargesDbChild)
                    .child(user!.uid)
                    .observeSingleEvent(of: .value, with: {(snapshop) in
                        DispatchQueue.main.async {
                            if snapshop.exists() {
                                self?.delegate?.didReceiveRemoteChargesCount((snapshop.value as! NSDictionary).allKeys.count)
                            } else {
                                self?.delegate?.didReceiveRemoteChargesCount(0)
                            }
                        }
                    }) {error in
                        self?.delegate?.didReceiveRemoteError(error: error)
                }
            } else {
                self?.delegate?.didReceiveRemoteChargesCount(nil)
            }
        }
    }
    
    func deleteCharge(byId id: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let user = FIRAuth.auth()?.currentUser
            
            if user != nil {
                self?.dbReference
                    .child(Constants.ChargesDbChild)
                    .child(user!.uid)
                    .child(id)
                    .removeValue()
            }
        }
    }
    
    private struct Constants {
        static let ChargesDbChild = "charges"
        static let GasStationDbChild = "gasStations"
    }
}
