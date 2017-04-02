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
        
        let gasStationData = GasStationData(withRemoteData: defaultContainer.resolve(BaseRemoteGasStationData.self)!)
        
        defaultContainer
            .register(BaseGasStationData.self) { _ in gasStationData }
            .inObjectScope(.container)
        
        // Location manager
        defaultContainer
            .register(CLLocationManager.self) { _ in CLLocationManager() }
        
        // Calculator brain
        defaultContainer
            .register(BaseFuelCalculatorBrain.self) { _ in BaseFuelCalculatorBrain() }
        
        // Charges data
        let remoteChargesData = FireBaseChargesData()
        
        defaultContainer
            .register(BaseRemoteChargesData.self) { _ in remoteChargesData }
        
        let chargesData = ChargesData(
            withRemoteChargesData: defaultContainer.resolve(BaseRemoteChargesData.self)!,
            andCalculatorBrain: defaultContainer.resolve(BaseFuelCalculatorBrain.self)!)
        
        defaultContainer
            .register(BaseChargesData.self) { _ in chargesData}
            .inObjectScope(.container)
        
        // VC
        ConfigChargingLocationVC.setup(container: defaultContainer)
        ConfigCurrentChargeVC.setup(container: defaultContainer)
        ConfigGraphVC.setup(container: defaultContainer)
        ConfigChargesVC.setup(container: defaultContainer)
        ConfigChargingVC.setup(container: defaultContainer)
        ConfigRecomendedVC.setup(container: defaultContainer)
    }
}
