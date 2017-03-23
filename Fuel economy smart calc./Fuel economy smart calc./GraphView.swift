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
    
    private var consumptionsLabels: [UILabel]?
    
    private var monthsLabels: [UILabel]?
    
    private var monthsStrings: [String]?
    
    var charges: [(Double, Int, String)]? {
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
    
    private var deltaY: CGFloat {
        return (self.startPoint.y - self.endPointOrdinate.y) / CGFloat(self.consumptionHelpersCount)
    }
    
    private var consumptionsYs: [CGFloat] {
        var consumptions: [CGFloat] = []
        
        var currentConsumptionY = self.startPoint.y - self.deltaY
        for _ in 0 ..< self.consumptionHelpersCount {
            consumptions.append(currentConsumptionY)
            currentConsumptionY -= self.deltaY
        }
        
        return consumptions
    }
    
    private var consumptionDashedLine: CGFloat {
        return self.bounds.width / 50
    }
    
    private var monthsDashedLine: CGFloat {
        return self.bounds.height / 50
    }
    
    private var monthsXs: [CGFloat] {
        var months: [CGFloat] = []
        
        let monthsCount = 9
        let deltaX = (self.endPointAbcise.x - self.startPoint.x) / CGFloat(monthsCount + 1)
        
        var currentMonthX = self.startPoint.x + deltaX
        for _ in 0..<monthsCount {
            months.append(currentMonthX)
            currentMonthX += deltaX
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
        
        removeConsumptions()
        removeMonths()
        
        addConsumptions()
        addMonths()
        
        for ch in self.charges! {
            print(ch)
        }
    }
    
    func loadView() {
        self.generateMonthsStrings()
    }
    
    func updateUI(){
        setNeedsDisplay()
    }
    
    private func generateMonthsStrings() {
        self.monthsStrings = []
        
        var currentDate = Date.init()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM"
        
        let day = Calendar.current.component(.day, from: currentDate)
        
        if day < 3 {
            currentDate = currentDate.addingTimeInterval(2*24*60*60)
        }
        
        for _ in 1...9 {
            monthsStrings?.insert(dateFormater.string(from: currentDate), at: 0)
            currentDate =  currentDate.addingTimeInterval(-31*24*60*60)
        }
        
    }
    
    private func addMonths(){
        let monthsXs = self.monthsXs
        let monthYOffset = CGFloat(10)
        let labelFrame = CGRect(x: 0, y: 0, width: 60, height: 12)
        let labelFont = UIFont.systemFont(ofSize: 8)
        
        var months: [UILabel] = []
        
        for index in 0..<monthsXs.count {
            let monthLabel = UILabel(frame: labelFrame)
            monthLabel.center = CGPoint(x: monthsXs[index], y: self.startY + monthYOffset)
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
        consumptionTitleLabel.text = "l/100km"
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
