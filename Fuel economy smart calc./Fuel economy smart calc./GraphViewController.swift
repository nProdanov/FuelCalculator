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
        
        self.chargesData = ChargesData()
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
        
        var filteredCharges = charges?.filter {
            $0.chargingDate > nineMonthsAgoDate &&
                Int(Calendar.current.component(.month, from: $0.chargingDate)) < nextMonth
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
        
        var currentDate = Date.init()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM"
        
        let day = Calendar.current.component(.day, from: currentDate)
        
        if day < 3 {
            currentDate = currentDate.addingTimeInterval(2*24*60*60)
        }
        
        for _ in 1...9 {
            monthsStrings.insert(dateFormater.string(from: currentDate), at: 0)
            currentDate =  currentDate.addingTimeInterval(-31*24*60*60)
        }
        
        return monthsStrings
    }
}
