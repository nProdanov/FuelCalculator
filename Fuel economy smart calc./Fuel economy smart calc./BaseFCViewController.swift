//
//  BaseFCViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/18/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class BaseFCViewController: UIViewController {
    
    private let defaultInputValue = ""
    private let defaultOutputValue = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
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
    
    @IBAction func changeControl(_ sender: UISegmentedControl) {
        self.makeCalculation()
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        self.dismissKeyboard()
        self.makeCalculation()
    }
    @IBAction func clear(_ sender: Any) {
        self.dismissKeyboard()
        
        fuelInputTextField.text = self.defaultInputValue
        distanceInputTextField.text = self.defaultInputValue
        priceInputTextField.text = self.defaultInputValue
        
        fuelOutputTextField.text = self.defaultOutputValue
        costOutputTextField.text = self.defaultOutputValue
    }
    
    private var brain = BaseFuelCalculatorBrain()
    
    
    private func makeCalculation() {
        self.dismissKeyboard()
        
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
                fuelQuantity: fuel,
                fuelUnit: fuelInputType,
                distanceQuantity: distance,
                distanceUnit: distanceInputUnitType,
                fuelResultUnit: fuelResultType,
                priceQuantity: priceQt,
                priceFuelUnit: priceFuelUnit,
                priceCurrencyUnit: priceCurrency,
                costCurrencyUnit: costCurrency,
                costDistanceQuantity: Double(costDistanceQt),
                costDistanceUnit: costDistanceUnitType)
            
            if let result = brain.fuelResult {
                self.setDoubleToTextField(valueForSet: result, textFieldToSet: fuelOutputTextField)
                
                if let costResult = brain.costResult {
                    self.setDoubleToTextField(valueForSet: costResult, textFieldToSet: costOutputTextField)
                }
                else {
                    costOutputTextField.text = self.defaultOutputValue
                }
            }
        }else{
            fuelOutputTextField.text = self.defaultOutputValue
            costOutputTextField.text = self.defaultOutputValue
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
