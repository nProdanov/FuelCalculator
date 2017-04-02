//
//  MoreTabViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/2/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

class MoreTabViewController: UIViewController {
    
    
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var chargesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDisclosure(toButton: accountButton)
        addDisclosure(toButton: chargesButton)
        addDisclosure(toButton: graphButton)
    }
    
    private func addDisclosure(toButton button: UIButton){
        let disclosure = UITableViewCell()
        disclosure.frame = button.bounds
        disclosure.accessoryType = .disclosureIndicator
        disclosure.isUserInteractionEnabled = false
        button.addSubview(disclosure)
    }
}
