//
//  ChargeTableViewCell.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargeTableViewCell: UITableViewCell {
    
    private let timelinePathXOffset = 30
    private let parentWidthToTimelinePathScale = 30
    
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
    
    private var timelinePathMinX: CGFloat {
        return self.date.frame.minX - CGFloat(self.timelinePathXOffset)
    }
    
    private var timelinePathWidth: CGFloat {
        return self.bounds.width / CGFloat(self.parentWidthToTimelinePathScale)
    }
    
    private var timelinePointerMinY: CGFloat {
        return self.date.frame.minY
    }
    
    private var timelinePointerMaxY: CGFloat {
        return self.date.frame.maxY
    }
    
    var charge: Charge? {
        didSet {
            updateUI()
            self.setNeedsDisplay()
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
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForTimelinePath().fill()
        
        pathForTimeLinePointer().fill()
        
    }
    
    private func pathForTimeLinePointer() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(
            x: self.timelinePathMinX + self.timelinePathWidth,
            y: self.timelinePointerMinY + 10))
        
        path.addLine(to: CGPoint(
            x: self.timelinePathMinX + self.timelinePathWidth + self.timelinePathWidth,
            y: self.timelinePathMinX + (self.timelinePointerMaxY - self.timelinePointerMinY) / 2))
        
        path.addLine(to: CGPoint(
            x: self.timelinePathMinX + self.timelinePathWidth,
            y: self.timelinePointerMaxY - 10))
        path.close()
        
        return path
    }
    
    private func pathForTimelinePath() -> UIBezierPath {
        let rect = CGRect(x: self.timelinePathMinX, y: self.bounds.minY, width: self.timelinePathWidth, height: self.bounds.height)
        let path = UIBezierPath(rect: rect)
        return path
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
