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
        
        let deltaY = (self.startPoint.y - self.endPointOrdinate.y) / 20
        let consCount = 20
        
        var currentConsumptionY = self.startPoint.y - deltaY
        for _ in 0..<consCount {
            consumptions.append(currentConsumptionY)
            currentConsumptionY = currentConsumptionY - deltaY
        }
        
        return consumptions
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.darkGray.set()
        self.pathForOrdinateLine().stroke()
        self.pathForArrowOrdinate().fill()
        self.pathForAbciseLine().stroke()
        self.pathForArrowAbcise().fill()
        self.pathForConsumptionsHelperLines().stroke()
    }
    
    func updateUI(){
        setNeedsDisplay()
    }
    
    private func pathForConsumptionsHelperLines() -> UIBezierPath {
        let path = UIBezierPath()
        
        let consumptionsYs = self.consumptionsYs
        
        for index in 0..<consumptionsYs.count {
            path.move(to: CGPoint(x: self.startX, y: consumptionsYs[index]))
            path.addLine(to: CGPoint(x: self.endPointAbcise.x, y: consumptionsYs[index]))
        }
        
        path.lineWidth = 0.5
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
