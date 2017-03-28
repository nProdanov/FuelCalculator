//
//  GasStationFromDict.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/27/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

extension GasStation
{
    static func fromDict(_ dict: NSDictionary) -> GasStation {
        let address = dict["address"] as! String
        let brandName = dict["brand_name"] as! String
        let city = dict["city"] as! String
        let id = dict["id"] as! Int
        let latitude = dict["lat"] as! Double
        let longtitude = dict["lon"] as! Double
        let name = dict["name"] as! String
        
        return GasStation(
            address: address,
            brandName: brandName,
            city: city,
            id: id,
            latitude: latitude,
            longtitude: longtitude,
            name: name)
    }
}
