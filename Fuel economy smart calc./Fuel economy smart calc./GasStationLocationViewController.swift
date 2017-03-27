//
//  GasStationLocationViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/26/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPin(placemark: MKPlacemark)
}

class GasStationLocationViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var gasStationData: BaseGasStationData?
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .standard
//            mapView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gasStationData = FireBaseGasStationData()
        gasStationData?.setDelegate(self)
        gasStationData?.getAll()
        
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
    }
    
    fileprivate func clearGasStations() {
        mapView?.removeAnnotations(mapView.annotations)
    }
    
    fileprivate func addGasStations(_ gasStations: [GasStation]) {
        mapView?.addAnnotations(gasStations)
    }
}

extension GasStationLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}

extension GasStationLocationViewController: GasStationDataDelegate {
    func didReceiveGasStations(gasStations: [GasStation]) {
        self.clearGasStations()
        
        self.addGasStations(gasStations)
    }
    
    func didReceiveError(error: Error) {
        print(error)
    }
}
