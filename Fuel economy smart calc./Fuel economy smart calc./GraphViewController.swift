//
//  GraphViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/22/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, ChargesDataDelegate
{
    private let consumptionTitleText = "l/100km"
    
    var chargesData: BaseChargesData?
    
    @IBOutlet weak var graphView: GraphView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chargesData?.setDelegate(self)
        self.chargesData?.getAllCharges()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        graphView?.updateUI()
    }
    
    func didReceiveAllCharges(_ charges: [Charge]) {
        graphView?.monthsStrings = self.generateMonthStrings()
        graphView?.consumptionTitleText = self.consumptionTitleText
        graphView?.charges = mapChargesForGraphView(charges)
    }
    
    private func mapChargesForGraphView(_ charges: [Charge]?) -> [(Double, Int, String)]? {
        let dateNow = Date.init()
        let nineMonthsAgoDate = dateNow.addingTimeInterval(-9*31*24*60*60)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        
        var nextMonthDate = dateNow.addingTimeInterval(25*24*60*60)
        let currentMonth = Int(Calendar.current.component(.month, from: dateNow))
        var nextMonth = Int(Calendar.current.component(.month, from: nextMonthDate))
        
        while nextMonth == currentMonth {
            nextMonthDate = nextMonthDate.addingTimeInterval(25*24*60*60)
            nextMonth = Int(Calendar.current.component(.month, from: nextMonthDate))
        }
        
        let dayOfMonth = Double((Calendar.current.component(.day, from: nextMonthDate) - 1))
        nextMonthDate = nextMonthDate.addingTimeInterval(-dayOfMonth*24*60*60)
        
        var filteredCharges = charges?.filter {
            $0.chargingDate > nineMonthsAgoDate &&
            $0.chargingDate < nextMonthDate
        }
    
        filteredCharges?.sort { $0.chargingDate < $1.chargingDate }
        let months = DateFormatter().monthSymbols!
        return filteredCharges?.map {
            (charge) -> (Double, Int, String) in
            
            return (
                charge.fuelConsumption!,
                Calendar.current.component(.day, from: charge.chargingDate),
                months[ Calendar.current.component(.month, from: charge.chargingDate) - 1])
        }
    }
    
    private func generateMonthStrings() -> [String] {
        var monthsStrings: [String] = []
        
        let dateNow = Date.init()
        
        let monthDateFormatter = DateFormatter()
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM"
        
        var month = Int(Calendar.current.component(.month, from: dateNow))
        var nineMonthsAgoDate = dateNow
        
        monthsStrings.insert(dateFormater.string(from: nineMonthsAgoDate), at: monthsStrings.startIndex)
        
        for _ in 0..<8 {
            nineMonthsAgoDate = nineMonthsAgoDate.addingTimeInterval(-28*24*60*60)
            var previousMonth = Int(Calendar.current.component(.month, from: nineMonthsAgoDate))
            
            while month == previousMonth {
                nineMonthsAgoDate = nineMonthsAgoDate.addingTimeInterval(-28*24*60*60)
                previousMonth = Int(Calendar.current.component(.month, from: nineMonthsAgoDate))
            }
            
            dateFormater.dateFormat = "MMMM"
            monthsStrings.insert(dateFormater.string(from: nineMonthsAgoDate), at: monthsStrings.startIndex)
            monthDateFormatter.dateFormat = "M"
            month = previousMonth
        }

        return monthsStrings
    }
}
