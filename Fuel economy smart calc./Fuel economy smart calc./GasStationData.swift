//
//  GasStationData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

class GasStationData: BaseGasStationData, RemoteGasStationDataDelegate
{
    var remoteData: BaseRemoteGasStationData? {
        didSet{
            remoteData?.setDelegate(self)
        }
    }
    
    private var delegate: GasStationDataDelegate?
    
    init() {
        remoteData = FireBaseGasStationData() // Swinject
    }
    
    func setDelegate(_ delegate: GasStationDataDelegate){
        self.delegate = delegate
    }
    
    func getAll() {
        self.remoteData?.getAllCount()
    }
    
    func didReceiveRemoteGasStations(_ gasStations: [GasStation]) {
        
    }
    
    func didReceiveRemoteGasStationsCount(_ count: Int) {
        
    }
    
    func didReceiveRemoteError(error: Error) {
        
    }
    
}
