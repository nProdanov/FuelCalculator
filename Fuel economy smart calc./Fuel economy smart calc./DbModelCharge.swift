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
        charge.priceConsumption = chargeInfo.priceConsumption!
        charge.fuelUnit = chargeInfo.fuelUnit
        charge.priceUnit = chargeInfo.priceUnit
        charge.price = chargeInfo.price
        charge.id = chargeInfo.id
        
        try? context.save()
        
        return charge
    }
    
    class func findOrCreateCharge(with chargeInfo: Charge, in context: NSManagedObjectContext) throws -> DbModelCharge
    {
        let request: NSFetchRequest<DbModelCharge> = DbModelCharge.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", chargeInfo.id)
        
        do {
            let matches = try context.fetch(request)
            let charges = matches.map {Charge.fromDbModel($0)}
            if matches.count > 0 {
                assert(matches.count == 1, "db model gas station -- inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let charge = DbModelCharge(context: context)
        charge.id = chargeInfo.id
        charge.chargedFuel = chargeInfo.chargedFuel
        charge.chargingDate = chargeInfo.chargingDate as NSDate?
        charge.distancePast = chargeInfo.distancePast!
        charge.distanceUnit = chargeInfo.distanceUnit
        charge.fuelConsumption = chargeInfo.fuelConsumption!
        charge.fuelUnit = chargeInfo.fuelUnit
        charge.gasStation = try? DbModelGasStation.findOrCreateGasStation(with: chargeInfo.gasStation, in: context)
        charge.price = chargeInfo.price
        charge.priceConsumption = chargeInfo.priceConsumption!
        charge.priceUnit = chargeInfo.priceUnit
        
        return charge
    }
    
    class func delete(byId id: String, in context: NSManagedObjectContext) throws
    {
        let request: NSFetchRequest<DbModelCharge> = DbModelCharge.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            var matches = try context.fetch(request)
            
            if matches.count > 0 {
                assert(matches.count == 1, "Cannot have more than 1 current charge per time")
                context.delete(matches[0])
                
                try? context.save()
            } else {
                // Throw eror - no current charge
            }
        } catch {
            throw error
        }
    }
}
