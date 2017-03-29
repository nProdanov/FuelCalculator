//
//  BaseRemoteChargesData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol BaseRemoteChargesData
{
    func setDelegate(_ delegate: RemoteChargesDataDelegate)
    func getAllCharges()
    func getAllChargesCount()
    func createCharge(fromChargeInfo chargeInfo: Charge)
    func deleteCharge(byId id: String)
}
