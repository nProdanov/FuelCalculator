//
//  VCLoadingExtension.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 4/2/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit

var loadingScreen = UIActivityIndicatorView()

extension UIViewController {
    func showLoadingScreen() {
        loadingScreen.frame = self.view.frame
        loadingScreen.activityIndicatorViewStyle = .whiteLarge
        loadingScreen.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        self.view.addSubview(loadingScreen)
        loadingScreen.startAnimating()
    }
    
    func hideLoadingScreen() {
        loadingScreen.stopAnimating()
        loadingScreen.removeFromSuperview()
    }
}
