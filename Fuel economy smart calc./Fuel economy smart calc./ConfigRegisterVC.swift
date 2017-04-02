//
//  ConfigRegisterVC.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/2/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ConfigRegisterVC
{
    static func setup(container: Container) {
        container.storyboardInitCompleted(RegisterViewController.self)
        { r, c in
            c.authData = r.resolve(BaseAuthData.self)
        }
    }
}
