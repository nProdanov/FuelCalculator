//
//  Charge.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

struct Charge {
    var chargingDate: Date
    var gasStationName: String
    var gasStationCoordinates: (Double, Double)?
    var chargedFuel: Double
    var distancePast: Double?
    var price: Double
    var fuelUnit: String
    var distanceUnit: String
    var priceUnit: String
    var fuelConsumption: Double?
    var priceConsumption: Double?
}
