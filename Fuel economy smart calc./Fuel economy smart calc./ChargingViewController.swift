//
//  ChargingViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/25/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargingViewController: UIViewController {
    
    @IBOutlet weak var gasStationNameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fuelChargedQuantityTextField: UITextField!
    @IBOutlet weak var fuelPriceTextField: UITextField!
    
    
    @IBOutlet weak var fuelChargedUnitLabel: UILabel!
    @IBOutlet weak var fuelPriceCurrencyLabel: UILabel!
    @IBOutlet weak var fuelPriceFuelUnitLabel: UILabel!
    
    @IBAction func saveCharge() {
    }
    
    var currentCharge: Charge?
    
    var choosedGasStation: GasStation? {
        didSet {
            gasStationNameTextField.text = "\(choosedGasStation!.brandName) \(choosedGasStation!.address)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        addGestureForDismissingKeyboard()
        //        currentCharge = (UIApplication.shared.delegate as! AppDelegate).charges?[0]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentCharge != nil {
            self.tabBarController?.selectedIndex = 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentCharge != nil {
            self.tabBarController?.selectedIndex = 2
        }
    }
    
    // TODO: Provide Gas Station via Location
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGasStationsMap" {
            let gasStationLocationViewController = segue.destination as! GasStationLocationViewController
            gasStationLocationViewController.gasStationLocationDelegate = self
        }
    }
}

extension ChargingViewController: GasStaionLocationDelegate {
    func didReceiveGasStation(_ gasStation: GasStation) {
        choosedGasStation = gasStation
    }
}
