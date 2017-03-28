//
//  ChargesTableViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargesTableViewController: UITableViewController {
    
    var charges: [Charge]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        charges = appDelegate.charges
    }
}

extension ChargesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charges!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charge", for: indexPath)
        
        if let charge = charges?[indexPath.row]{    
            if let chargeCell = cell as? ChargeTableViewCell {
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
