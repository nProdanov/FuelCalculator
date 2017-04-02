//
//  ChargingViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/25/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargingViewController: UIViewController
{
    @IBOutlet weak var gasStationNameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fuelChargedQuantityTextField: UITextField!
    @IBOutlet weak var fuelPriceTextField: UITextField!
    
    
    @IBOutlet weak var fuelChargedUnitLabel: UILabel!
    @IBOutlet weak var fuelPriceCurrencyLabel: UILabel!
    @IBOutlet weak var fuelPriceFuelUnitLabel: UILabel!
    
    @IBAction func saveCharge() {
        if let gasStation = self.choosedGasStation,
            let chargedFuel = fuelChargedQuantityTextField.text,
            let price = fuelPriceTextField.text,
            let fuelUnit = fuelChargedUnitLabel.text,
            let currency = fuelPriceCurrencyLabel.text
        {
            let date = datePicker.date
            let journey = 0.0
            let distanceUnit = "KM"
            
            let currCharge = CurrentCharge(
                gasStation: gasStation,
                chargingDate: date,
                chargedFuel: Double(chargedFuel)!,
                price: Double(price)!,
                fuelUnit: fuelUnit,
                priceUnit: currency,
                distanceUnit: distanceUnit,
                journey: journey)
            
            self.chargesData?.createCurrentCharge(from: currCharge)
        }
        
    }
    
    var currentCharge: CurrentCharge?
    
    var choosedGasStation: GasStation? {
        didSet {
            gasStationNameTextField.text = "\(choosedGasStation!.brandName) \(choosedGasStation!.address)"
        }
    }
    
    var chargesData: BaseChargesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        addGestureForDismissingKeyboard()
        self.gasStationNameTextField.text = "-"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentCharge != nil {
            self.tabBarController?.selectedIndex = 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chargesData?.setDelegate(self)
        self.chargesData?.getCurrentCharge()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGasStationsMap" {
            let gasStationLocationViewController = segue.destination as! GasStationLocationViewController
            gasStationLocationViewController.gasStationLocationDelegate = self
        }
    }
}

extension ChargingViewController: GasStaionLocationDelegate
{
    func didReceiveGasStation(_ gasStation: GasStation) {
        choosedGasStation = gasStation
    }
}

extension ChargingViewController: ChargesDataDelegate
{
    func didReceiveCurrentCharge(_ currentCharge: CurrentCharge?) {
        if currentCharge != nil {
            self.tabBarController?.selectedIndex = 2
        }
    }
    
    func didCreateCurrentCharge() {
        self.datePicker.setDate(Date.init(), animated: true)
        self.fuelChargedQuantityTextField.text = ""
        self.fuelPriceTextField.text = ""
        self.gasStationNameTextField.text = ""
        self.tabBarController?.selectedIndex = 2
    }
}
