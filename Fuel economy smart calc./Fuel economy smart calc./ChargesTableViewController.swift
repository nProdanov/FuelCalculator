//
//  ChargesTableViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class ChargesTableViewController: UITableViewController {
    
    var charges: [Charge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.separatorStyle = .none
        
        charges = [
            Charge(chargingDate: Date.init(), gasStationName: "Eko Mladost", gasStationCoordinates: (23.0, 23.0), chargedFuel: 65.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.5, priceConsumption: 13.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Ivony", gasStationCoordinates: (100.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 1.83, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 10.98),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0),
            Charge(chargingDate: Date.init(), gasStationName: "Eko Botevgradsko", gasStationCoordinates: (23.0, 23.0), chargedFuel: 60.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 6.0, priceConsumption: 12.0)
        ]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return charges.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charge", for: indexPath)
        
        let charge = charges[indexPath.row]
        // Configure the cell...
        
        if let chargeCell = cell as? ChargeTableViewCell {
            chargeCell.charge = charge
                        
            chargeCell.backgroundColor = UIColor(hue: 0.5889, saturation: 0.65, brightness: 0.41, alpha: 1.0)
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
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
