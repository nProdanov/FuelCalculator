//
//  DbModelCurrentCharge.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import CoreData

class DbModelCurrentCharge : NSManagedObject
{
    class func createCurrentChargex(with currentChargeInfo: CurrentCharge, in context: NSManagedObjectContext) throws -> DbModelCurrentCharge
    {
        let request: NSFetchRequest<DbModelCurrentCharge> = DbModelCurrentCharge.fetchRequest()
        
        do {
            let matches = try context.fetch(request)
            
            assert(matches.count == 0, "Cannot have more than 1 current charge per time")
        } catch {
            throw error
        }
        
        let currentCharge = DbModelCurrentCharge(context: context)
        currentCharge.chargingDate = currentChargeInfo.chargingDate as NSDate?
        currentCharge.chargedFuel = currentChargeInfo.chargedFuel
        currentCharge.journey = currentChargeInfo.journey
        currentCharge.price = currentChargeInfo.price
        currentCharge.priceUnit = currentChargeInfo.priceUnit
        currentCharge.fuelUnit = currentChargeInfo.fuelunit
        currentCharge.distanceUnit = currentChargeInfo.distanceUnit
        
        do {
            currentCharge.gasStation = try DbModelGasStation.findOrCreateGasStation(with: currentChargeInfo.gasStation, in: context)
        } catch {
            print("error: \(error)")
        }
        
        return currentCharge
    }
    
    
}
