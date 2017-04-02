//
//  ChargesTableViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/21/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit
import CoreData

class ChargesTableViewController: UITableViewController {
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var charges: [Charge]? {
        didSet{
            self.charges?.sort { $0.chargingDate > $1.chargingDate }
            self.tableView.reloadData()
        }
    }
    
    var chargesData: BaseChargesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing", attributes: attributes)
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chargesData?.setDelegate(self)
        self.chargesData?.getAllCharges()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.chargesData?.sync()
        self.chargesData?.getAllCharges()
        refreshControl.endRefreshing()
    }
}

extension ChargesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charges?.count ?? 0
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let charges = self.charges {
                self.chargesData?.deleteCharge(byId: charges[indexPath.row].id)
                self.charges?.remove(at: indexPath.row)
                //                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension ChargesTableViewController: ChargesDataDelegate
{
    func didReceiveAllCharges(_ charges: [Charge]) {
        self.charges = charges
    }
    
    func didDeleteCharge() {
        self.tableView.reloadData()
    }
}
