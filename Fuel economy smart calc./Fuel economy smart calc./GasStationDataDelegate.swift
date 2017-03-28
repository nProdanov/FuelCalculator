//
//  GasStationDataDelegate.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/27/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol GasStationDataDelegate
{
    func didReceiveGasStations(gasStations: [GasStation])
    func didReceiveError(error: Error)
}
