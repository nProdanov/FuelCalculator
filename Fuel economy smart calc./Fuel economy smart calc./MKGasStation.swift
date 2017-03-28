//
//  MKGasStation.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/27/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import Foundation
import MapKit

extension GasStation : MKAnnotation
{    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    
    var title: String? {
        return self.fullName
    }
    
    var subtitle: String? {
        return address
    }
}
