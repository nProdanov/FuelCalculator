//
//  DbModelGasStation.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import CoreData

class DbModelGasStation: NSManagedObject {
    
    class func findOrCreateGasStation(with gasStationInfo: GasStation, in context: NSManagedObjectContext) throws -> DbModelGasStation
    {
        let request: NSFetchRequest<DbModelGasStation> = DbModelGasStation.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", gasStationInfo.id)
        
        do {
            let matches = try context.fetch(request)
            
            if matches.count > 0 {
                assert(matches.count == 1, "db model gas station -- inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let gasStation = DbModelGasStation(context: context)
        gasStation.id = Int32(gasStationInfo.id)
        gasStation.brandName = gasStationInfo.brandName
        gasStation.city = gasStationInfo.city
        gasStation.name = gasStationInfo.name
        gasStation.address = gasStationInfo.address
        gasStation.latitude = gasStationInfo.latitude
        gasStation.longtitude = gasStationInfo.longtitude
        
        return gasStation
    }
}
