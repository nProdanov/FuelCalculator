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
    @IBAction func toggleFuelInputUnitControl(_ sender: UISegmentedControl) {
    }
    
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
    
    
    @IBAction func makeCalculation(_ sender: UIButton) {
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
