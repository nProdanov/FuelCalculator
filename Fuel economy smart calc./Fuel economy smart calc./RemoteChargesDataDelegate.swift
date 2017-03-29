//
//  RemoteChargesDataDelegate.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

protocol RemoteChargesDataDelegate
{
    func didReceiveRemoteCharges(_ charges: [Charge])
    func didReceiveRemoteChargesCount(_ count: Int)
    func didReceiveRemoteError(error: Error)
}
