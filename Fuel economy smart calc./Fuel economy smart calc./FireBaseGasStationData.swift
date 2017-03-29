//
//  FireBaseGasStationData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/27/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FireBaseGasStationData: BaseRemoteGasStationData
{
    private var delegate: RemoteGasStationDataDelegate?
    
    private var dbReference: FIRDatabaseReference!
    
    init(){
        dbReference = FIRDatabase.database().reference()
    }
    
    func getAll() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.dbReference
                .child(Constants.gasStationDbChild)
                .observeSingleEvent(of: .value, with: {(snapshop) in
                    let gasStationsDict = snapshop.value as! [NSDictionary]
                    let gasStations = gasStationsDict.map { GasStation.fromDict($0) }
                    DispatchQueue.main.async {
                        self?.delegate?.didReceiveRemoteGasStations(gasStations)
                    }
                }) {error in
                    self?.delegate?.didReceiveRemoteError(error: error)
            }
            
        }
    }
    
    func getAllCount() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.dbReference
                .child(Constants.gasStationDbChild)
                .observeSingleEvent(of: .value, with: {(snapshop) in
                    DispatchQueue.main.async {
                        self?.delegate?.didReceiveRemoteGasStationsCount((snapshop.value as! [Any]).count)
                    }
                }) {error in
                    self?.delegate?.didReceiveRemoteError(error: error)
            }

        }
    }
    
    func setDelegate(_ delegate: RemoteGasStationDataDelegate) {
        self.delegate = delegate
    }
    
    private struct Constants {
        fileprivate static let gasStationDbChild = "gasStations"
    }
}
