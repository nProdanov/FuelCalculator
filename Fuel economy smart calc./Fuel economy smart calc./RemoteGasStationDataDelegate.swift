//
//  RemoteDataDelegate.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol RemoteGasStationDataDelegate
{
    func didReceiveRemoteGasStations(_ gasStations: [GasStation])
    func didReceiveRemoteGasStationsCount(_ count: Int)
    func didReceiveRemoteError(error: Error)
}
