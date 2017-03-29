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

class ChargesData: BaseChargesData
{
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var delegate: ChargesDataDelegate?
    
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
    
    func createCharge(fromCurrentCharge currentCharge: CurrentCharge) {
        
    }
    
    func getAllCharges() {
        
    }
    
    func deleteCharge(byId id: String) {
        
    }
    
    private struct Constants
    {
        static let MainLogicProblemAssertMessage = "Can not have more than 1 current charge per time"
    }
}
