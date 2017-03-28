//
//  BaseRemoteGasStationData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/28/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol BaseRemoteGasStationData
{
    func setDelegate(_ delegate: RemoteGasStationDataDelegate)
    func getAll()
    func getAllCount()
}
