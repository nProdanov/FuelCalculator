//
//  GraphView.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/22/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
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
    
    private var consumptionsYs: [CGFloat] {
        var consumptions: [CGFloat] = []
        
        let consCount = 20
        let deltaY = (self.startPoint.y - self.endPointOrdinate.y) / CGFloat(consCount)
        
        var currentConsumptionY = self.startPoint.y - deltaY
        for _ in 0..<consCount {
            consumptions.append(currentConsumptionY)
            currentConsumptionY -= deltaY
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
    }
    
    func updateUI(){
        setNeedsDisplay()
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
