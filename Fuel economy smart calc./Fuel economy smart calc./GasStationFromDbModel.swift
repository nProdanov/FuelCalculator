//
//  GasStationFromDbModel.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

extension GasStation
{
    static func fromDbModel(_ dbModel: DbModelGasStation) -> GasStation {
        return GasStation(
            address: dbModel.address!,
            brandName: dbModel.brandName!,
            city: dbModel.city!,
            id: Int(dbModel.id),
            latitude: dbModel.latitude,
            longtitude: dbModel.longtitude,
            name: dbModel.name!)
    }
}
