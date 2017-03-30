//
//  DbModelCharge.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import CoreData

class DbModelCharge: NSManagedObject
{
    class func createCharge(with chargeInfo: Charge, in context: NSManagedObjectContext) throws -> DbModelCharge
    {
        let charge = DbModelCharge(context: context)
        
        charge.gasStation = try? DbModelGasStation.findOrCreateGasStation(with: chargeInfo.gasStation, in: context)
        charge.chargedFuel = chargeInfo.chargedFuel
        charge.chargingDate = chargeInfo.chargingDate as NSDate?
        charge.distancePast = chargeInfo.distancePast!
        charge.distanceUnit = chargeInfo.distanceUnit
        charge.fuelConsumption = chargeInfo.fuelConsumption!
        charge.fuelUnit = chargeInfo.fuelUnit
        charge.priceUnit = chargeInfo.priceUnit
        charge.price = chargeInfo.price
        charge.id = chargeInfo.id
        
        try? context.save()
        
        return charge
    }
}
