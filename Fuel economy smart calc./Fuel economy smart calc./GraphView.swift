//
//  GraphView.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/22/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    private let consumptionHelpersCount = 20
    private let monthsCount = 9
    
    var monthsStrings: [String]?
    
    var consumptionTitleText: String?
    
    private var consumptionsLabels: [UILabel]?
    
    private var monthsLabels: [UILabel]?
    
    var charges: [(Double, Int, String)]? {
        didSet {
            updateUI()
        }
    }
    
    var chargesPoints: [CGPoint]? {
        didSet {
            updateUI()
        }
    }
    
    private var startX: CGFloat {
        return self.bounds.width / CGFloat(20)
    }
    
    private var startY: CGFloat {
        return self.bounds.height - (self.bounds.height / CGFloat(10))
    }
    private var startPoint: CGPoint {
        return CGPoint(x: self.startX, y: self.startY)
    }
    
    private var endPointOrdinate: CGPoint {
        let endY = self.bounds.height / CGFloat(20)
        return  CGPoint(x: self.startX, y: endY)
    }
    
    private var endPointAbcise: CGPoint {
        let endX = self.bounds.width - self.bounds.width / CGFloat(25)
        return CGPoint(x: endX, y: self.startY)
    }
    
    private var consumptionsDeltaY: CGFloat {
        return (self.startPoint.y - self.endPointOrdinate.y) / CGFloat(self.consumptionHelpersCount)
    }
    
    private var consumptionsYs: [CGFloat] {
        var consumptions: [CGFloat] = []
        
        var currentConsumptionY = self.startPoint.y - self.consumptionsDeltaY
        for _ in 0 ..< self.consumptionHelpersCount {
            consumptions.append(currentConsumptionY)
            currentConsumptionY -= self.consumptionsDeltaY
        }
        
        return consumptions
    }
    
    private var consumptionDashedLine: CGFloat {
        return self.bounds.width / 50
    }
    
    private var monthsDashedLine: CGFloat {
        return self.bounds.height / 50
    }
    
    private var monthsDeltaX: CGFloat {
        return (self.endPointAbcise.x - self.startPoint.x) / CGFloat(self.monthsCount + 1)
    }
    
    private var monthsXs: [CGFloat] {
        var months: [CGFloat] = []
        
        let monthsCount = 9
        
        var currentMonthX = self.startPoint.x + self.monthsDeltaX
        for _ in 0..<monthsCount {
            months.append(currentMonthX)
            currentMonthX += self.monthsDeltaX
        }
        
        return months
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.darkGray.set()
        self.pathForOrdinateLine().stroke()
        self.pathForArrowOrdinate().fill()
        self.pathForAbciseLine().stroke()
        self.pathForArrowAbcise().fill()
        self.pathForConsumptionsHelperLines().stroke()
        self.pathForMonthsHelperLines().stroke()
        
        if self.charges != nil {
            self.generateConsumptionsPoints()
            self.pathForConsumptionCurve().stroke()
            self.consumptionDots()
        }
        
        removeConsumptions()
        removeMonths()
        
        addConsumptions()
        addMonths()
    }
    
    func updateUI(){
        setNeedsDisplay()
    }
    
    private func generateConsumptionsPoints() {
        var points: [CGPoint] = []
        var val = 1
        for charge in charges! {
            let monthsIndex = (monthsStrings?.index(of: charge.2))! as Int
            let deltaXDay = self.monthsDeltaX / 30
            let x = self.startX +  CGFloat(monthsIndex) * self.monthsDeltaX + CGFloat(charge.1) * deltaXDay
            let y = self.startY - CGFloat(charge.0) * self.consumptionsDeltaY
            
            points.append(CGPoint(x: x, y: y))
            val += 1
        }
        
        chargesPoints = points
    }
    
    private func addMonths(){
        let monthsXs = self.monthsXs
        let monthYOffset = CGFloat(10)
        let labelFrame = CGRect(x: 0, y: 0, width: 60, height: 12)
        let labelFont = UIFont.systemFont(ofSize: 8)
        
        var months: [UILabel] = []
        
        for index in 0..<monthsXs.count {
            let monthLabel = UILabel(frame: labelFrame)
            monthLabel.center = CGPoint(x: monthsXs[index] - self.monthsDeltaX / 2, y: self.startY + monthYOffset)
            monthLabel.textAlignment = .center
            monthLabel.text = self.monthsStrings?[index]
            monthLabel.font = labelFont
            
            months.append(monthLabel)
            
            self.addSubview(monthLabel)
        }
        
        self.monthsLabels = months
    }
    
    private func removeMonths() {
        if let labels = monthsLabels {
            for label in labels {
                label.removeFromSuperview()
            }
        }
    }
    
    private func addConsumptions(){
        let consumptionsYs = self.consumptionsYs
        let consumptionXOffset = CGFloat(10)
        let labelFrame = CGRect(x: 0, y: 0, width: 11, height: 12)
        let labelFont = UIFont.systemFont(ofSize: 8)
        
        var consumptions: [UILabel] = []
        var currentValue = 1
        for index in 0..<consumptionsYs.count {
            let consumptionLabel = UILabel(frame: labelFrame)
            consumptionLabel.center = CGPoint(x: self.startX - consumptionXOffset, y: consumptionsYs[index])
            consumptionLabel.textAlignment = .center
            consumptionLabel.text = currentValue.description
            consumptionLabel.font = labelFont
            
            consumptions.append(consumptionLabel)
            
            self.addSubview(consumptionLabel)
            
            currentValue += 1
        }
        
        let consumptionTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 33, height: 12))
        consumptionTitleLabel.center = CGPoint(x: self.startX - consumptionXOffset, y: self.startPoint.y + 10)
        consumptionTitleLabel.textAlignment = .center
        consumptionTitleLabel.text = self.consumptionTitleText ??  ""
        consumptionTitleLabel.font = labelFont
        
        self.addSubview(consumptionTitleLabel)
        
        consumptions.append(consumptionTitleLabel)
        
        self.consumptionsLabels = consumptions
    }
    
    private func removeConsumptions() {
        if let labels = self.consumptionsLabels {
            for label in labels {
                label.removeFromSuperview()
            }
        }
    }
    
    private func consumptionDots(){
        if let points  = self.chargesPoints {
            for point in points {
                let path = UIBezierPath(arcCenter: point, radius: 3, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
                path.fill()
            }
        }
    }
    
    private func pathForConsumptionCurve() -> UIBezierPath {
        let path = UIBezierPath()
        
        if let points = self.chargesPoints
        {
            if points.count > 0 {
                path.move(to: points[0])
                
                for index in 1..<points.count {
                    path.addLine(to: points[index])
                }
            }
        }
        
        path.lineWidth = 2.0
        
        return path
    }
    
    private func pathForMonthsHelperLines() -> UIBezierPath {
        let path = UIBezierPath()
        
        let monthsXs = self.monthsXs
        
        for index in 0..<monthsXs.count {
            path.move(to: CGPoint(x: monthsXs[index], y: self.startY))
            
            var currentY = self.startY
            while currentY > self.endPointOrdinate.y {
                path.move(to: CGPoint(x: monthsXs[index], y: currentY))
                path.addLine(to: CGPoint(x: monthsXs[index], y: currentY - self.monthsDashedLine))
                currentY -= 1.3 *  self.monthsDashedLine
            }
        }
        
        path.lineWidth = 0.25
        return path
    }
    
    private func pathForConsumptionsHelperLines() -> UIBezierPath {
        let path = UIBezierPath()
        
        let consumptionsYs = self.consumptionsYs
        
        for index in 0..<consumptionsYs.count {
            path.move(to: CGPoint(x: self.startX, y: consumptionsYs[index]))
            
            var currentX = self.startX
            while currentX < self.endPointAbcise.x - self.consumptionDashedLine {
                path.move(to: CGPoint(x: currentX, y: consumptionsYs[index]))
                path.addLine(to: CGPoint(x: currentX + self.consumptionDashedLine, y: consumptionsYs[index]))
                currentX += 1.3 * self.consumptionDashedLine
            }
        }
        
        path.lineWidth = 0.25
        
        return path
    }
    
    private func pathForArrowAbcise() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: self.endPointAbcise)
        path.addLine(to: CGPoint(x: self.endPointAbcise.x - 20, y: self.startY - 2))
        path.addLine(to: CGPoint(x: self.endPointAbcise.x - 20, y: self.startY + 2))
        path.close()
        
        return path
        
    }
    
    private func pathForAbciseLine() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: self.startPoint)
        path.addLine(to: self.endPointAbcise)
        path.lineWidth = 1
        
        return path
    }
    
    private func pathForArrowOrdinate() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: self.endPointOrdinate)
        path.addLine(to: CGPoint(x: self.startX - 2, y: self.endPointOrdinate.y + 20))
        path.addLine(to: CGPoint(x: self.startX + 2, y: self.endPointOrdinate.y + 20))
        path.close()
        
        return path
    }
    
    private func pathForOrdinateLine() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: self.startPoint)
        path.addLine(to: self.endPointOrdinate)
        
        return path
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
