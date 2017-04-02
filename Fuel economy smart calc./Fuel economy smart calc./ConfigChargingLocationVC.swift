//
//  ConfigCharginLocationVC.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/2/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import MapKit

import Swinject
import SwinjectStoryboard

class ConfigChargingLocationVC {
    static func setup(container: Container) {
        container.storyboardInitCompleted(GasStationLocationViewController.self)
        { r, c in
            c.gasStationData = r.resolve(BaseGasStationData.self)
            c.locationManager = r.resolve(CLLocationManager.self)
        }
    }
}
