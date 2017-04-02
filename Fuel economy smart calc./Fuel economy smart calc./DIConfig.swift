//
//  DIConfig.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/2/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import MapKit

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard
{
    public static func setup() {
        Container.loggingFunction = nil
        
        // Gas stations data
        let remoteGasStationsData = FireBaseGasStationData()
        
        defaultContainer
            .register(BaseRemoteGasStationData.self) { _ in remoteGasStationsData }
        
        defaultContainer
            .register(BaseGasStationData.self) {res in GasStationData(withRemoteData: res.resolve(BaseRemoteGasStationData.self)!)}
            .inObjectScope(.container)
        
        // Location manager
        defaultContainer
            .register(CLLocationManager.self) { _ in CLLocationManager() }
        
        // VC
        ConfigChargingLocationVC.setup(container: defaultContainer)
    }
}
