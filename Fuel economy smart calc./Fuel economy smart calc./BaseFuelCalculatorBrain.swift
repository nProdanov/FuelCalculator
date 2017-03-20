//
//  BaseFuelCalculatorBrain.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/18/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

struct BaseFuelCalculatorBrain {
    
    var fuelResult: Double?
    var costResult: Double?
    
    private let fuelResultTypes = [
        "l/100km": 1.0,
        "MPG":235.214583
    ]
    
    private let fuelUnits = [
        "LTR": 1.0,
        "GAL": 3.78541178
    ]
    
    private let distanceUnits = [
        "KM": 1.0,
        "MIL": 1.609344
    ]
    
    private let currencyTypes = [
        "LV": 1.0,
        "EUR": 1.95797,
        "USD": 1.8218
        
    ]
    
    mutating func performCalculation(fuelQuantity fuelQt: Double,
                                     fuelUnit: String,
                                     distanceQuantity distanceQt: Double,
                                     distanceUnit: String,
                                     fuelResultUnit: String,
                                     priceQuantity priceQt: Double? = nil,
                                     priceFuelUnit: String? = nil,
                                     priceCurrencyUnit: String? = nil,
                                     costCurrencyUnit: String? = nil,
                                     costDistanceQuantity costDistanceQt: Double? = nil,
                                     costDistanceUnit: String? = nil){
        let rawFuelUnit = fuelUnits[fuelUnit]!
        let rawDistanceUnit = distanceUnits[distanceUnit]!
        let rawFuelResultType = fuelResultTypes[fuelResultUnit]!
        
        if fuelQt == 0 || distanceQt == 0 {
            self.fuelResult = nil
            self.costResult = nil
            return
        }
        
        let fuel = fuelQt * rawFuelUnit
        let distance = distanceQt * rawDistanceUnit
        
        let result = fuel / (distance / 100)
        fuelResult = result * rawFuelResultType
        
        if let priceQuantity = priceQt,
            let priceType = priceCurrencyUnit,
            let priceFuelType = priceFuelUnit,
            let fuelResult = self.fuelResult,
            let costResultCurrency = costCurrencyUnit,
            let costDistanceQuantity = costDistanceQt,
            let costDistanceUnitType = costDistanceUnit
        {
            if priceQuantity == 0 {
                self.costResult = nil
                return
            }
            
            let rawPriceUnit = self.currencyTypes[priceType]!
            let rawPriceFuelUnit = self.fuelUnits[priceFuelType]!
            let rawCostUnit = self.currencyTypes[costResultCurrency]!
            let rawCostDistanceUnit = self.distanceUnits[costDistanceUnitType]!
            
            let price = priceQuantity * rawPriceUnit * rawPriceFuelUnit
            
            self.costResult = (price * (1 / rawCostUnit) * rawCostDistanceUnit) / (100 / costDistanceQuantity) * fuelResult
        }
        else{
            self.costResult = nil
        }
    }
}
