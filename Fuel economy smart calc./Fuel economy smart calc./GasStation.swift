//
//  GasStation.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/27/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

class GasStation: NSObject
{
    var address: String
    var brandName: String
    var city: String
    var id: Int
    var latitude: Double
    var longtitude: Double
    var name: String
    
    init(address: String, brandName: String, city: String, id: Int, latitude: Double, longtitude: Double, name: String){
        self.address = address
        self.brandName = brandName
        self.city = city
        self.id = id
        self.latitude = latitude
        self.longtitude = longtitude
        self.name = name
    }
}
