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
    
    var chargesData: ChargesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chargesData = ChargesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chargesData?.setDelegate(self)
        self.chargesData?.getAllCharges()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    
}
