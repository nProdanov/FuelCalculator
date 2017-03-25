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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        currentCharge = (UIApplication.shared.delegate as! AppDelegate).charges?[0]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentCharge != nil {
            self.tabBarController?.selectedIndex = 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.selectedIndex = 2
    }
    
    // TODO: Provide Gas Station via Location
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
