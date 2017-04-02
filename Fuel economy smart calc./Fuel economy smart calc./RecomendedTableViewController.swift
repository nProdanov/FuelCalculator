//
//  RecomendedTableViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/31/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class RecomendedTableViewController: UITableViewController, ChargesDataDelegate
{
    var charges: [Charge]?
    
    var chargesData: BaseChargesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chargesData?.setDelegate(self)
        self.chargesData?.getAllCharges()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charges?.count ?? 0
    }
    
    func didReceiveAllCharges(_ charges: [Charge]) {
        let sortedCharges = charges.sorted { $0.priceConsumption! < $1.priceConsumption! }
        
        self.charges = []
        if sortedCharges.count > 0 {
            self.charges?.append(sortedCharges[0])
        }
        
        if sortedCharges.count > 1{
            self.charges?.append(sortedCharges[1])
        }
        
        if sortedCharges.count > 2{
            self.charges?.append(sortedCharges[2])
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recomendedCell", for: indexPath)
        
        if let charge = self.charges?[indexPath.row] {
            if let chargeCell = cell as? RecomendedTableViewCell {
                chargeCell.charge = charge
                
                chargeCell.backgroundColor = UIColor(hue: 0.5889, saturation: 0.65, brightness: 0.41, alpha: 1.0)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let charges = charges {
            let chargeLocationVC = storyboard?.instantiateViewController(withIdentifier: "ChargeLocation") as! ChargeLocationViewController
            chargeLocationVC.gasStation = charges[indexPath.row].gasStation
            
            navigationController?.show(chargeLocationVC, sender: self)
        }
    }
}
