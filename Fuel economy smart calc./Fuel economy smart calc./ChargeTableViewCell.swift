//
//  ChargeTableViewCell.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var gasStationName: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceUnit: UILabel!
    @IBOutlet weak var priceFuelUnit: UILabel!
    
    @IBOutlet weak var fuelConsumption: UILabel!
    @IBOutlet weak var fuelConsumptionUnit: UILabel!
    @IBOutlet weak var distanceConsumptionUnit: UILabel!
    
    @IBOutlet weak var fuelCharger: UILabel!
    @IBOutlet weak var fuelChargedUnit: UILabel!
    
    @IBOutlet weak var distancePast: UILabel!
    @IBOutlet weak var distancePastUnit: UILabel!
    
    var charge: Charge? { didSet{ updateUI() } }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
    
        date.text = dateFormatter.string(from: (charge?.chargingDate)!)
        gasStationName.text = charge?.gasStationName
        
        price.text = String(format: "%.2f", (charge?.price)!)
        priceUnit.text = charge?.priceUnit
        priceFuelUnit.text = charge?.fuelUnit
        
        fuelConsumption.text = String(format: "%.1f", (charge?.fuelConsumption)!)
        fuelConsumptionUnit.text = charge?.fuelUnit
        distanceConsumptionUnit.text = charge?.distanceUnit
        
        fuelCharger.text = String(format: "%.2f", (charge?.chargedFuel)!)
        fuelChargedUnit.text = charge?.fuelUnit
        
        distancePast.text = String(format: "%.2f", (charge?.distancePast)!)
        distancePastUnit.text = charge?.distanceUnit
    }

}
