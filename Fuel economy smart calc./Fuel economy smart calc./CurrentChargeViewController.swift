//
//  CurrentChargeViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/24/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class CurrentChargeViewController: UIViewController {
    
    @IBOutlet weak var tripQuantityTextField: UITextField!
    @IBOutlet weak var journeyQuantityTextField: UITextField!
    
    @IBOutlet weak var gasStationNameLabel: UILabel!
    @IBOutlet weak var dateChargedlabel: UILabel!
    @IBOutlet weak var fuelChargedQuantityLabel: UILabel!
    @IBOutlet weak var fuelPriceLabel: UILabel!
    @IBOutlet weak var fuelChargedUnitLabel: UILabel!
    @IBOutlet weak var fuelPriceCurrencyUnitLabel: UILabel!
    @IBOutlet weak var fuelPriceUnitLabel: UILabel!
    @IBOutlet weak var tripUnitLabel: UILabel!
    @IBOutlet weak var journeyUnitLabel: UILabel!
    
    
    @IBAction func addTripToJourney() {
        let trip = Double(tripQuantityTextField.text!)
        
        if currentCharge != nil {
            currentCharge!.distancePast = currentCharge!.distancePast ?? 0
            
            if let tripDistance = trip {
                currentCharge?.distancePast! += tripDistance
            }
        }
        
        tripQuantityTextField.text = ""
        dismissKeyboard()
    }
    
    var currentCharge: Charge? {
        didSet {
            self.updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForDismissingKeyboard()
        addSaveButtonToNavBar()
        
//        currentCharge = (UIApplication.shared.delegate as! AppDelegate).charges?[0]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentCharge == nil {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentCharge == nil {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    func save() {
        
    }
    
    private func updateUI() {
        if let charge = currentCharge {
            gasStationNameLabel.text = charge.gasStation.fullName
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM YYYY"
            dateChargedlabel.text = dateFormatter.string(from: charge.chargingDate)
            
            fuelChargedQuantityLabel.text = charge.chargedFuel.description
            fuelChargedUnitLabel.text = charge.fuelUnit
            
            fuelPriceLabel.text = charge.price.description
            fuelPriceCurrencyUnitLabel.text = charge.priceUnit
            fuelPriceUnitLabel.text = charge.fuelUnit
            
            tripUnitLabel.text = charge.distanceUnit
            journeyUnitLabel.text = charge.distanceUnit
            
            journeyQuantityTextField.text = charge.distancePast?.description
        }
        
    }
    
    private func addSaveButtonToNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
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
