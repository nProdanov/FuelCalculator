//
//  GraphViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/22/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    var charges: [Charge]?
    
    @IBOutlet weak var graphView: GraphView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var nineMonthsAgoDate = Date.init()
        nineMonthsAgoDate = nineMonthsAgoDate.addingTimeInterval(-9*31*24*60*60)
        
        charges = appDelegate.charges?.filter { $0.chargingDate > nineMonthsAgoDate }
        charges?.sort { $0.chargingDate < $1.chargingDate }
        let months = DateFormatter().monthSymbols!
        graphView?.charges = self.charges?.map {
            (charge) -> (Double, Int, String) in
            
            return (
                charge.fuelConsumption!,
                Calendar.current.component(.day, from: charge.chargingDate),
                months[ Calendar.current.component(.month, from: charge.chargingDate) - 1])
        }
        
        graphView?.loadView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        graphView?.updateUI()
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
