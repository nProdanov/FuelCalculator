//
//  GasStationLocationViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/26/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit
import MapKit

class GasStationLocationViewController: UIViewController, MKMapViewDelegate
{
    var areAnotationsReady = false
    
    var locationManager: CLLocationManager? {
        didSet {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.requestLocation()
        }
    }
    
    var gasStationData: BaseGasStationData? {
        didSet {
            gasStationData?.setDelegate(self)
            gasStationData?.getAll()
            areAnotationsReady = true
        }
    }
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .standard
            mapView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gasStationData = FireBaseGasStationData() // Swinject
        locationManager = CLLocationManager() // Swinject
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationReuseIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationReuseIdentifier)
            
            let leftViewButton = UIButton(frame: Constants.LeftCalloutFrame)
            
            annotationView?.leftCalloutAccessoryView = leftViewButton
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: Constants.ImageForAnnotation)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !(view.annotation is MKUserLocation) else {
            return
        }
        
        let leftViewButton = view.leftCalloutAccessoryView as! UIButton
        leftViewButton.setTitle("Charge here!", for: .normal)
        leftViewButton.setTitleColor(UIColor.white, for: .normal)
        leftViewButton.setTitleColor(UIColor.gray, for: .selected)
        leftViewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        leftViewButton.backgroundColor = UIColor(hue: 0.5972, saturation: 0.54, brightness: 0.74, alpha: 1.0)
        
    }
    
    fileprivate func clearGasStations() {
        mapView?.removeAnnotations(mapView.annotations)
    }
    
    fileprivate func addGasStations(_ gasStations: [GasStation]) {
        mapView?.addAnnotations(gasStations)
    }
    
    private struct Constants {
        static let AnnotationReuseIdentifier = "gasStation"
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 100, height: 59)
        static let ShowChargingWithGasStationNameSegue = "showCharging"
        static let ImageForAnnotation = "gasstationpin"
    }
}

extension GasStationLocationViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            if !areAnotationsReady {
                self.gasStationData?.getAll()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}

extension GasStationLocationViewController: GasStationDataDelegate
{
    func didReceiveGasStations(gasStations: [GasStation]) {
        self.clearGasStations()
        self.addGasStations(gasStations)
    }
    
    func didReceiveError(error: Error) {
        print("error: \(error)")
    }
}
