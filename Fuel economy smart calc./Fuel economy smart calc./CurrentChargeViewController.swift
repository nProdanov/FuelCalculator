//
//  CurrentChargeViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/24/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class CurrentChargeViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    func save() {
        
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
