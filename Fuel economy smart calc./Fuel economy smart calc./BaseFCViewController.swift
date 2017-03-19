//
//  BaseFCViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/18/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class BaseFCViewController: UIViewController {
    
    
    @IBOutlet weak var fuelInputTextField: UITextField!
    @IBOutlet weak var fuelInputUnitControl: UISegmentedControl!
    
    
    @IBOutlet weak var distanceInputTextField: UITextField!
    @IBOutlet weak var distanceInputUnitControl: UISegmentedControl!
    
    @IBOutlet weak var priceInputTextField: UITextField!
    @IBOutlet weak var priceInputCurrencyControl: UISegmentedControl!
    @IBOutlet weak var priceInputFuelUnitControl: UISegmentedControl!
    
    
    @IBOutlet weak var fuelOutputTextField: UITextField!
    @IBOutlet weak var fuelOutputTypeControl: UISegmentedControl!
    
    
    @IBOutlet weak var costOutputTextField: UITextField!
    @IBOutlet weak var costOutputCurrencyControl: UISegmentedControl!
    @IBOutlet weak var costOutputUnitQuantityControl: UISegmentedControl!
    @IBOutlet weak var costOutputDistanceUnitControl: UISegmentedControl!
    
    
    private var brain = BaseFuelCalculatorBrain()
    
    @IBAction func calculate() {
        self.makeCalculation()
    }
    private func makeCalculation() {
        if  let fuel = self.convertInputToDouble(from: fuelInputTextField),
            let fuelInputType = self.convertSelectedSegmentToString(from: fuelInputUnitControl),
            let distance = self.convertInputToDouble(from: distanceInputTextField),
            let distanceInputUnitType = self.convertSelectedSegmentToString(from: distanceInputUnitControl),
            let fuelResultType = self.convertSelectedSegmentToString(from: fuelOutputTypeControl)
        {
            let priceQt = self.convertInputToDouble(from: priceInputTextField) ?? nil
            let priceFuelUnit = self.convertSelectedSegmentToString(from: priceInputFuelUnitControl)!
            let priceCurrency = self.convertSelectedSegmentToString(from: priceInputCurrencyControl)!
            let costCurrency = self.convertSelectedSegmentToString(from: costOutputCurrencyControl)!
            let costDistanceQt = self.convertSelectedSegmentToString(from: costOutputUnitQuantityControl)!
            let costDistanceUnitType = self.convertSelectedSegmentToString(from: costOutputDistanceUnitControl)!
            
            brain.performCalculation(
                fuelQt: fuel,
                fuelUnit: BaseFuelCalculatorBrain.FuelUnit.fromString(fuelUnitString: fuelInputType)!,
                distanceQt: distance,
                distanceUnit: BaseFuelCalculatorBrain.DistanceUnit.fromString(distanceUnitString: distanceInputUnitType)!,
                fuelResultType: BaseFuelCalculatorBrain.FuelResultType.fromString(fuelResultString: fuelResultType)!,
                priceQt: priceQt,
                priceFuelUnit: BaseFuelCalculatorBrain.FuelUnit.fromString(fuelUnitString: priceFuelUnit),
                priceUnit: BaseFuelCalculatorBrain.Currency.fromString(currencyString: priceCurrency),
                costCurrency: BaseFuelCalculatorBrain.Currency.fromString(currencyString: costCurrency),
                costDistanceQt: Double(costDistanceQt),
                costDistanceUnit: BaseFuelCalculatorBrain.DistanceUnit.fromString(distanceUnitString: costDistanceUnitType))
            
            if let result = brain.fuelResult {
                self.setDoubleToTextField(valueForSet: result, textFieldToSet: fuelOutputTextField)
                
                if let costResult = brain.costResult {
                    self.setDoubleToTextField(valueForSet: costResult, textFieldToSet: costOutputTextField)
                }
                else {
                    costOutputTextField.text = "-"                }
            }
        }else{
            fuelOutputTextField.text = "-"
        }
        
    }
    
    private func convertInputToDouble(from input: UITextField!) -> Double? {
        if let inputString = input.text,
            !inputString.isEmpty,
            inputString != "",
            let inputDouble = Double(inputString){
            return inputDouble
        }
        
        return nil
    }
    
    private func setDoubleToTextField(valueForSet valueDouble: Double, textFieldToSet: UITextField) {
        textFieldToSet.text =  String(format: "%.2f", valueDouble)
    }
    
    private func convertSelectedSegmentToString(from segmentedControl: UISegmentedControl) -> String? {
        return segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
