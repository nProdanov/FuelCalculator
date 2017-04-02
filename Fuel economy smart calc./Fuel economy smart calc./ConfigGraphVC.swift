//
//  ConfigGraphVC.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/2/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation

import Swinject
import SwinjectStoryboard

class ConfigGraphVC
{
    static func setup(container: Container) {
        container.storyboardInitCompleted(GraphViewController.self)
        { r, c in
            c.chargesData = r.resolve(BaseChargesData.self)
        }
    }
}
