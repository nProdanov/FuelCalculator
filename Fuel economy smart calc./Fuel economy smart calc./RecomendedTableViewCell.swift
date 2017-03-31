//
//  RecomendedTableViewCell.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/31/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class RecomendedTableViewCell: UITableViewCell
{
    @IBOutlet weak var gasStationNameLabel: UILabel!
    
    @IBOutlet weak var fuelConsumptionLabel: UILabel!
    @IBOutlet weak var fuelUnitLabel: UILabel!
    @IBOutlet weak var distanceUnitFuelConsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var fuelUnitPriceLabel: UILabel!
    @IBOutlet weak var distanceUnitPriceLabel: UILabel!
    
    @IBOutlet weak var priceConsumptionLabel: UILabel!
    @IBOutlet weak var currencyPriceConsLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var charge: Charge? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func updateUI() {
        
        self.gasStationNameLabel.text = self.charge?.gasStation.fullName
        self.fuelConsumptionLabel.text = String(format: "%.1f", (self.charge?.fuelConsumption)!)
        self.fuelUnitLabel.text = self.charge?.fuelUnit
        self.distanceUnitFuelConsLabel.text = self.charge?.distanceUnit
        self.priceLabel.text = self.charge?.price.description
        self.fuelUnitPriceLabel.text = self.charge?.fuelUnit
        self.distanceUnitPriceLabel.text = self.charge?.distanceUnit
        self.priceConsumptionLabel.text = String(format: "%.2f", (charge?.priceConsumption)!)
        self.currencyPriceConsLabel.text = self.charge?.priceUnit
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        
        if let charge = self.charge {
            dateLabel.text = dateFormatter.string(from: charge.chargingDate)
        }
    }
    
}
