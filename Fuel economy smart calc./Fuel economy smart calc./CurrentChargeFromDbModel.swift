//
//  CurrentChargeFromDbModel.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

extension CurrentCharge
{
    static func fromDbModel(_ dbModel: DbModelCurrentCharge) -> CurrentCharge {
        return CurrentCharge(
            gasStation: GasStation.fromDbModel(dbModel.gasStation!),
            chargingDate: dbModel.chargingDate as! Date,
            chargedFuel: dbModel.chargedFuel,
            price: dbModel.price,
            fuelUnit: dbModel.fuelUnit!,
            priceUnit: dbModel.priceUnit!,
            distanceUnit: dbModel.distanceUnit!,
            journey: dbModel.journey)
    }
}
