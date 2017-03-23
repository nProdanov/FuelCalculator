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

    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        charges = appDelegate.charges
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
