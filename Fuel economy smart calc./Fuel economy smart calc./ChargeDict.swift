//
//  ChargeFromDict.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

extension Charge
{
    static func fromDict(_ dict: NSDictionary) -> Charge {
        let id = dict["id"] as! String
        
        let dateFormatter = DateFormatter()
        let chargingDate = dateFormatter.date(from: (dict["chargingDate"] as! String))!
        
        let chargedFuelQuantity = dict["chargedFuel"] as! Double
        let fuelUnit = dict["fuelUnit"] as! String
        
        let price = dict["price"] as! Double
        let priceUnit = dict["priceUnit"] as! String
        
        let distancePast = dict["distancePast"] as! Double
        let distanceUnit = dict["distanceUnit"] as! String
        
        let fuelConsumption = dict["fuelConsumption"] as! Double
        let priceConsumption = dict["priceConsumption"] as! Double
        
        let gasStation = GasStation.fromDict(dict)

        return Charge(
            id: id,
            chargingDate: chargingDate,
            gasStation: gasStation,
            chargedFuel: chargedFuelQuantity,
            distancePast: distancePast,
            price: price,
            fuelUnit: fuelUnit,
            distanceUnit: distanceUnit,
            priceUnit: priceUnit,
            fuelConsumption: fuelConsumption,
            priceConsumption: priceConsumption)
    }
    
    static func toDict(_ charge: Charge) -> NSDictionary {
        var dict: Dictionary<String, String> = [:]
        
        dict["id"] = charge.id
        dict["gasStationId"] = charge.gasStation.id.description
        
        let dateFormatter = DateFormatter()
        dict["chargingDate"] = dateFormatter.string(from: charge.chargingDate)
        
        dict["chargedFuel"] = charge.chargedFuel.description
        dict["fuelUnit"] = charge.fuelUnit
        
        dict["price"] = charge.price.description
        dict["priceUnit"] = charge.priceUnit
        
        dict["distancePast"] = charge.distancePast?.description
        dict["distanceUnit"] = charge.distanceUnit
        
        dict["fuelConsumption"] = charge.fuelConsumption?.description
        dict["priceConsumption"] = charge.priceConsumption?.description
        
        return dict as NSDictionary
    }
}
