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
    
    var calculatorBrain: BaseFuelCalculatorBrain?
    
    init() {
        self.remoteChargesData = FireBaseChargesData() // Swinject
        self.remoteChargesData?.setDelegate(self)
        self.calculatorBrain = BaseFuelCalculatorBrain()
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
        container?.performBackgroundTask { [weak self] context in
            try? DbModelCurrentCharge.delete(in: context)
            
            if let mainContext =  self?.container?.viewContext {
                mainContext.perform {
                    self?.delegate?.didReceiceDeleteCurrentCharge()
                }
            }
        }
    }
    
    func createCharge(fromCurrentCharge currentCharge: CurrentCharge) {
        self.calculatorBrain?.performCalculation(
            fuelQuantity: currentCharge.chargedFuel,
            fuelUnit: currentCharge.fuelunit,
            distanceQuantity: currentCharge.journey,
            distanceUnit: currentCharge.distanceUnit,
            fuelResultUnit: "l/100km",
            priceQuantity: currentCharge.price,
            priceFuelUnit: currentCharge.fuelunit,
            priceCurrencyUnit: currentCharge.priceUnit,
            costCurrencyUnit: currentCharge.priceUnit,
            costDistanceQuantity: 100,
            costDistanceUnit: currentCharge.distanceUnit)
        
        let gasStation = currentCharge.gasStation
        let charge = Charge(
            id: "\(arc4random())\(currentCharge.gasStation.name)",
            chargingDate: currentCharge.chargingDate,
            gasStation: gasStation,
            chargedFuel: currentCharge.chargedFuel,
            distancePast: currentCharge.journey,
            price: currentCharge.price,
            fuelUnit: currentCharge.fuelunit,
            distanceUnit: currentCharge.distanceUnit,
            priceUnit: currentCharge.priceUnit,
            fuelConsumption: self.calculatorBrain?.fuelResult,
            priceConsumption: self.calculatorBrain?.costResult)
        
        container?.performBackgroundTask { [weak self] context in
            _ = try? DbModelCharge.createCharge(with: charge, in: context)
            
            if let mainContext =  self?.container?.viewContext {
                mainContext.perform {
                    self?.delegate?.didCreateCharge()
                }
            }
        }
        
        self.remoteChargesData?.createCharge(fromChargeInfo: charge)
    }
    
    func getAllCharges() {
        container?.performBackgroundTask { [weak self] context in
            let request: NSFetchRequest<DbModelCharge> = DbModelCharge.fetchRequest()
            if let dbCharges = try? context.fetch(request) {
                if dbCharges.count > 0 {
                    let charges = dbCharges.map { Charge.fromDbModel($0) }
                    
                    if let mainContext =  self?.container?.viewContext {
                        mainContext.perform {
                            self?.delegate?.didReceiveAllCharges(charges)
                        }
                    }
                    
                } else{
                    self?.delegate?.didReceiveAllCharges([])
                }
            }
        }
        //        self.remoteChargesData?.getAllCharges()
    }
    
    func deleteCharge(byId id: String) {
        
    }
    
    func didReceiveRemoteChargesCount(_ count: Int) {
        print(count)
    }
    
    func didReceiveRemoteCharges(_ charges: [Charge]) {
        self.delegate?.didReceiveAllCharges(charges)
    }
    
    func didReceiveRemoteError(error: Error) {
        
    }
    
    private struct Constants
    {
        static let MainLogicProblemAssertMessage = "Can not have more than 1 current charge per time"
    }
}
