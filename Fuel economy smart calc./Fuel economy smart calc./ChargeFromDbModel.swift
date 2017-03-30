//
//  ChargeFromDbModel.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/30/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

extension Charge
{
    static func fromDbModel(_ dbModel: DbModelCharge) -> Charge {
        return Charge(
            id: dbModel.id!,
            chargingDate: dbModel.chargingDate as! Date,
            gasStation: GasStation.fromDbModel(dbModel.gasStation!),
            chargedFuel: dbModel.chargedFuel,
            distancePast: dbModel.distancePast,
            price: dbModel.price,
            fuelUnit: dbModel.fuelUnit!,
            distanceUnit: dbModel.distanceUnit!,
            priceUnit: dbModel.priceUnit!,
            fuelConsumption: dbModel.fuelConsumption,
            priceConsumption: dbModel.priceConsumption)
    }
}
