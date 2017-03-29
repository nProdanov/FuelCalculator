//
//  CurrentChargeViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/24/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class CurrentChargeViewController: UIViewController
{
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
            if let tripDistance = trip {
                self.currentCharge?.journey += tripDistance
            }
        }
        
        tripQuantityTextField.text = ""
        journeyQuantityTextField.text = self.currentCharge?.journey.description
        dismissKeyboard()
    }
    
    var chargesData: BaseChargesData?
    
    var currentCharge: CurrentCharge? {
        didSet {
            self.updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForDismissingKeyboard()
        addSaveButtonToNavBar()
        
        //        currentCharge = (UIApplication.shared.delegate as! AppDelegate).charges?[0]
        
        chargesData = ChargesData()
        chargesData?.setDelegate(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentCharge == nil {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentCharge == nil {
            self.chargesData?.getCurrentCharge()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let currentCharge = self.currentCharge {
            self.chargesData?.updadeCurrentCharge(with: currentCharge.journey)
        }
    }
    
    func save() {
        if let currentCharge = self.currentCharge {
            self.chargesData?.createCharge(fromCurrentCharge: currentCharge)
        }
    }
    
    private func updateUI() {
        if let charge = currentCharge {
            gasStationNameLabel.text = charge.gasStation.fullName
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM YYYY"
            dateChargedlabel.text = dateFormatter.string(from: charge.chargingDate)
            
            fuelChargedQuantityLabel.text = charge.chargedFuel.description
            fuelChargedUnitLabel.text = charge.fuelunit
            
            fuelPriceLabel.text = charge.price.description
            fuelPriceCurrencyUnitLabel.text = charge.priceUnit
            fuelPriceUnitLabel.text = charge.fuelunit
            
            tripUnitLabel.text = charge.distanceUnit
            journeyUnitLabel.text = charge.distanceUnit
            
            journeyQuantityTextField.text = charge.journey.description
        }
    }
    
    private func addSaveButtonToNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
}

extension CurrentChargeViewController: ChargesDataDelegate
{
    func didReceiveCurrentCharge(_ currentCharge: CurrentCharge?) {
        if currentCharge != nil {
            self.currentCharge = currentCharge
        } else {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    func didCreateCharge() {
        self.chargesData = nil
        self.chargesData?.deleteCurrentCharge()
    }
    
    func didReceiceDeleteCurrentCharge(){
        self.tabBarController?.selectedIndex = 1
    }
}
