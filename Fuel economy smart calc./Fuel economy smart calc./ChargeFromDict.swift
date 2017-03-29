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
}
