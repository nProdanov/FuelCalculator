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
        // Gas station
        let address = dict["address"] as! String
        let brandName = dict["brand_name"] as! String
        let city = dict["city"] as! String
        let gasIdString = dict["gasStationId"] as! String
        let gasStationId = Int(gasIdString)!
        let latitude = Double(dict["lat"] as! String)!
        let longtitude = Double(dict["lon"] as! String)!
        let name = dict["name"] as! String
        
        // Charge
        let id = dict["id"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let chargingDate = dateFormatter.date(from: (dict["chargingDate"] as! String))!
        
        let chargedFuelQuantity = Double(dict["chargedFuel"] as! String)!
        let fuelUnit = dict["fuelUnit"] as! String
        
        let price = Double(dict["price"] as! String)!
        let priceUnit = dict["priceUnit"] as! String
        
        let distancePast = Double(dict["distancePast"] as! String)
        let distanceUnit = dict["distanceUnit"] as! String
        
        let fuelConsumption = Double(dict["fuelConsumption"] as! String)!
        let priceConsumption = Double(dict["priceConsumption"] as! String)!
        
        let gasStation = GasStation(
            address: address,
            brandName: brandName,
            city: city,
            id: gasStationId,
            latitude: latitude,
            longtitude: longtitude,
            name: name)
        
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
        
        // Gas station
        dict["address"] = charge.gasStation.address
        dict["brand_name"] = charge.gasStation.brandName
        dict["city"] = charge.gasStation.city
        dict["gasStationId"] = charge.gasStation.id.description
        dict["lat"] = charge.gasStation.latitude.description
        dict["lon"] = charge.gasStation.longtitude.description
        dict["name"] = charge.gasStation.name
        
        // Charge
        dict["id"] = charge.id
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
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
