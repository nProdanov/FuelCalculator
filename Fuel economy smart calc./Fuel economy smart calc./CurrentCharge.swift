//
//  CurrentCharge.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

class CurrentCharge
{
    let gasStation: GasStation
    let chargingDate: Date
    let chargedFuel: Double
    let price: Double
    let fuelunit: String
    let priceUnit: String
    let distanceUnit: String
    var journey: Double
    
    init(
        gasStation: GasStation,
        chargingDate: Date,
        chargedFuel: Double,
        price: Double,
        fuelUnit: String,
        priceUnit: String,
        distanceUnit: String,
        journey: Double)
    {
        self.gasStation = gasStation
        self.chargingDate = chargingDate
        self.chargedFuel = chargedFuel
        self.price = price
        self.fuelunit = fuelUnit
        self.priceUnit = priceUnit
        self.distanceUnit = distanceUnit
        self.journey = journey
    }
}
