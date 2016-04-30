//
//  CentersViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import MapKit

class CentersViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let searchRadius = 1000
    
    var nucleos:[Nucleo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSideMenu(self.menuItem)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter  = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlaceAnnotation {
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeedView.annotation = annotation
                view = dequeedView
            }
            else {
                view  = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset  = CGPoint(x: -5, y: 5)
                view.pinTintColor   = UIColor(red: 155.0/255, green: 47.0/255, blue: 245.0/255, alpha: 1.0)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            
            return view
        }
        
        return nil
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.fetchPlacesNearCoordinate(location.coordinate)
            
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
            mapView.setRegion(region, animated: true)
            
            
            locationManager.stopUpdatingLocation()
            locationManager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D){
        self.nucleos = DiscoveringMock.mockPlaces()
        
        for nucleo: Nucleo in nucleos! {
            let annotation = PlaceAnnotation(placeName: nucleo.name, placeAddress: "Some Address", coordinate: nucleo.coordinate)
            mapView.addAnnotation(annotation)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
