//
//  ChargeLocationViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/26/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit
import MapKit

class ChargeLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var geoCoder: CLGeocoder?
    
    var chargeInfo: (name: String, coordinates: (Double, Double))? {
        didSet {
            chargePin = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: chargeInfo!.coordinates.0, longitude: chargeInfo!.coordinates.1))
        }
    }
    
    var chargePin: MKPlacemark? {
        didSet {
            dropPin(chargePin)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geoCoder = CLGeocoder()
        dropPin(chargePin)
    }
    
    func getDirections(){
        if let selectedPin = chargePin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    func dropPin(_ chargePin: MKPlacemark?) {
        mapView?.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = chargePin!.coordinate
        
        let location = CLLocation(latitude: chargeInfo!.coordinates.0,
                                  longitude: chargeInfo!.coordinates.1)
        
        geoCoder?.reverseGeocodeLocation(location) { placemarks, error in
            if error == nil && (placemarks?.count)! > 0 {
                DispatchQueue.main.async {
                    annotation.title = placemarks?.last?.name
                }
            }
        }
        
        mapView?.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(chargePin!.coordinate, span)
        mapView?.setRegion(region, animated: true)
    }
}

extension ChargeLocationViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "charge"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = .orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
