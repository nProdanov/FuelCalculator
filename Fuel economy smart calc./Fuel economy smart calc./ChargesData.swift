//
//  ChargesData.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/29/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ChargesData: BaseChargesData, RemoteChargesDataDelegate
{
    var remoteChargesData: BaseRemoteChargesData?
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var delegate: ChargesDataDelegate?
    
    init() {
        remoteChargesData = FireBaseChargesData() // Swinject
        remoteChargesData?.setDelegate(self)
    }
    
    func setDelegate(_ delegate: ChargesDataDelegate){
        self.delegate = delegate
    }
    
    func getCurrentCharge() {
        if let context = self.container?.viewContext {
            context.perform { [weak self] in
                let request: NSFetchRequest<DbModelCurrentCharge> = DbModelCurrentCharge.fetchRequest()
                if let dbCurrentCharge = try? context.fetch(request) {
                    if dbCurrentCharge.count > 0 {
                        assert(dbCurrentCharge.count == 1, Constants.MainLogicProblemAssertMessage)
                        self?.delegate?.didReceiveCurrentCharge(CurrentCharge.fromDbModel(dbCurrentCharge[0]))
                    }
                    else{
                        self?.delegate?.didReceiveCurrentCharge(nil)
                    }
                }
            }
        }
    }
    
    func createCurrentCharge(from currCharge: CurrentCharge) {
        container?.performBackgroundTask { [weak self] context in
            _ = try? DbModelCurrentCharge.createCurrentChargex(with: currCharge, in: context)
            try? context.save()
            
            if let mainContext =  self?.container?.viewContext {
                mainContext.perform {
                    self?.delegate?.didCreateCurrentCharge()
                }
            }
        }
    }
    
    func updadeCurrentCharge(with journey: Double) {
        container?.performBackgroundTask { context in
            try? DbModelCurrentCharge.updateCurrentCharge(with: journey, in: context)
        }
    }
    
    func deleteCurrentCharge() {
        container?.performBackgroundTask { context in
            try? DbModelCurrentCharge.delete(in: context)
        }
    }
    
    func createCharge(fromCurrentCharge currentCharge: CurrentCharge) {
        let gas = GasStation(
            address: "до с. Студена, Пернишко",
            brandName: "Lukoil",
            city: "АМ Струма",
            id: 1,
            latitude: 42.570553,
            longtitude: 23.116175,
            name: "B051")
        
        let ch = Charge(
            id: "\(arc4random())",
            chargingDate: Date.init(),
            gasStation: gas,
            chargedFuel: 65.0,
            distancePast: 900.0,
            price: 2.09,
            fuelUnit: "LTR",
            distanceUnit: "KM",
            priceUnit: "LV",
            fuelConsumption: 6.5,
            priceConsumption: 10.1)
        self.remoteChargesData?.createCharge(fromChargeInfo: ch)
    }
    
    func getAllCharges() {
        self.remoteChargesData?.getAllCharges()
    }
    
    func deleteCharge(byId id: String) {
        
    }
    
    func didReceiveRemoteChargesCount(_ count: Int) {
        print(count)
    }
    
    func didReceiveRemoteCharges(_ charges: [Charge]) {
        print(charges)
    }
    
    func didReceiveRemoteError(error: Error) {
        
    }
    
    private struct Constants
    {
        static let MainLogicProblemAssertMessage = "Can not have more than 1 current charge per time"
    }
}
