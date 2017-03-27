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

class FireBaseGasStationData: BaseGasStationData {
    
    var delegate: GasStationDataDelegate?
    
    var dbReference: FIRDatabaseReference!
    
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
                        self?.delegate?.didReceiveGasStations(gasStations: gasStations)
                    }
                }) {error in
                        self?.delegate?.didReceiveError(error: error)
            }
            
        }
    }
    
    func setDelegate(_ delegate: GasStationDataDelegate) {
        self.delegate = delegate
    }
    
    private struct Constants {
        fileprivate static let gasStationDbChild = "gasStations"
    }
}
