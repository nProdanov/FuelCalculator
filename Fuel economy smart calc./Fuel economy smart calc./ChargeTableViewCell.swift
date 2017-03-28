//
//  ChargeTableViewCell.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargeTableViewCell: UITableViewCell {
    
    private let timelinePathXOffset = CGFloat(25)
    private let timelinePathWidth = CGFloat(5.0)
    
    private let timelinePointerRadius = CGFloat(10)
    private let startAngle = CGFloat(0)
    private let endAngle = 2 * CGFloat.pi
    
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
    
    private var timelineMinX: CGFloat {
        return date.frame.minX - self.timelinePathXOffset
    }
    
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
        
        // Configure the view for the selected
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(hue: 0.5889, saturation: 0.63, brightness: 0.65, alpha: 1.0) /* #3e6ea8 */
        
        // set color here
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    override func draw(_ rect: CGRect) {
        let customColor = UIColor(hue: 0.5083, saturation: 0, brightness: 0.92, alpha: 1.0) /* #eaeaea */
        customColor.set()
        pathForTimelinePath().stroke()
        pathForTimeLinePointer().fill()
        
    }
    
    private func pathForTimeLinePointer() -> UIBezierPath {
        let centerX = self.timelineMinX
        let centerY = date.frame.minY + ((date.frame.maxY - date.frame.minY) / 2)
        let center = CGPoint(x: centerX, y: centerY)
        
        let path = UIBezierPath(arcCenter: center, radius: self.timelinePointerRadius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: false)
        
        return path
    }
    
    private func pathForTimelinePath() -> UIBezierPath {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: self.timelineMinX, y: self.bounds.minY)
        let endPoint = CGPoint(x: self.timelineMinX, y: self.bounds.maxY)
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = self.timelinePathWidth
        return path
    }
    
    private func updateUI(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        date.text = dateFormatter.string(from: (charge?.chargingDate)!)
        gasStationName.text = charge?.gasStation.fullName
        
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
