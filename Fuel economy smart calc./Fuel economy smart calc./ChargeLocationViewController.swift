//
//  ChargeLocationViewController.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/26/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit
import MapKit

class ChargeLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var gasStation: GasStation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gasStation = self.gasStation {
            dropPin(gasStation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.ReusableAnnotationIdentifier) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.ReusableAnnotationIdentifier)
        pinView?.pinTintColor = Constants.AnnotationPinTintColor
        pinView?.canShowCallout = true
        
        let button = Constants.LeftCalloutViewButton
        button.setBackgroundImage(Constants.LeftCalloutViewButtonImage, for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    func getDirections(){
        if let selectedPin = gasStation {
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: selectedPin.coordinate))
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    func dropPin(_ annotation: GasStation) {
        mapView?.removeAnnotations(mapView.annotations)
        
        mapView?.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(annotation.coordinate, span)
        mapView?.setRegion(region, animated: true)
    }
    
    private struct Constants {
        static let ReusableAnnotationIdentifier = "charge"
        static let AnnotationPinTintColor = UIColor.orange
        static let LeftCalloutViewButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
        static let LeftCalloutViewButtonImage = UIImage(named: "car")
    }
}
