//
//  GraphViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/22/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    private let consumptionTitleText = "l/100km"
    
    var charges: [Charge]?
    
    @IBOutlet weak var graphView: GraphView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        graphView?.charges = mapChargesForGraphView(appDelegate.charges)
        graphView?.monthsStrings = self.generateMonthStrings()
        graphView?.consumptionTitleText = self.consumptionTitleText
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        graphView?.updateUI()
    }
    
    private func mapChargesForGraphView(_ charges: [Charge]?) -> [(Double, Int, String)]? {
        var nineMonthsAgoDate = Date.init()
        nineMonthsAgoDate = nineMonthsAgoDate.addingTimeInterval(-9*31*24*60*60)
        
        var filteredCharges = charges?.filter { $0.chargingDate > nineMonthsAgoDate }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
