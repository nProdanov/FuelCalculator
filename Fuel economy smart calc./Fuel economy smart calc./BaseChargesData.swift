//
//  BaseChargesData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol BaseChargesData
{
    func setDelegate(_ delegate: ChargesDataDelegate)
    func getCurrentCharge()
    func createCurrentCharge(from currCharge: CurrentCharge)
    func updadeCurrentCharge(with journey: Double)
    func deleteCurrentCharge()
    func createCharge(fromCurrentCharge currentCharge: CurrentCharge)
    func getAllCharges()
    func deleteCharge(byId id: String)
}
