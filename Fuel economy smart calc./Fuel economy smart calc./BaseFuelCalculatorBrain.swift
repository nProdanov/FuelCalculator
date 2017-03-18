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
    
    mutating func performCalculation(fuelQt: Double,
                                     fuelUnit: FuelUnit,
                                     distanceQt: Double,
                                     distanceUnit: DistanceUnit,
                                     fuelResultType: FuelResultType,
                                     priceQt: Double? = nil,
                                     priceFuelUnit: FuelUnit? = nil,
                                     priceUnit: Currency? = nil,
                                     costCurrency: Currency? = nil,
                                     costDistanceQt: Double? = nil,
                                     costDistanceUnit: DistanceUnit? = nil){
        let fuel = fuelQt * fuelUnit.rawValue
        let distance = distanceQt * distanceUnit.rawValue
        
        let result = fuel / (distance / 100)
        fuelResult = result * fuelResultType.rawValue
        
        if let priceQuantity = priceQt,
            let priceType = priceUnit,
            let priceFuelType = priceFuelUnit,
            let fuelResult = self.fuelResult,
            let costResultCurrency = costCurrency,
            let costDistanceQuantity = costDistanceQt,
            let costDistanceUnitType = costDistanceUnit
        {
            
            let price = priceQuantity * priceType.rawValue * priceFuelType.rawValue
            
            
            costResult = (price * (1 / costResultCurrency.rawValue) * costDistanceUnitType.rawValue) / (100 / costDistanceQuantity) * fuelResult
        }
    }
    
    
    
    enum FuelResultType: Double {
        case KM = 1.0
        case MPG = 235.214583
        
        static func fromString(fuelResultString: String) -> FuelResultType? {
            switch fuelResultString {
            case "l/100km": return .KM
            case "MPG": return .MPG
            default: return nil
            }
        }
    }
    
    enum FuelUnit: Double {
        case LTR = 1.0
        case GAL = 3.78541178
        
        public static func fromString(fuelUnitString: String) -> FuelUnit? {
            switch fuelUnitString {
            case "LTR": return .LTR
            case "GAL": return .GAL
            default: return nil
            }
        }
    }
    
    enum DistanceUnit: Double {
        case KM = 1.0
        case MIL = 1.609344
        
        static func fromString(distanceUnitString: String) -> DistanceUnit? {
            switch distanceUnitString {
            case "KM": return .KM
            case "MIL": return .MIL
            default: return nil
            }
        }
    }
    
    enum Currency: Double {
        case LV = 1.0
        case EUR = 1.95797
        case USD = 1.8218
        
        static func fromString(currencyString: String) -> Currency? {
            switch currencyString {
            case "LV" : return .LV
            case "EUR" : return .EUR
            case "USD" : return .USD
            default: return nil
            }
        }
    }
}
