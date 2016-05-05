//
//  CentersViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

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
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if let placemark = placemarks?.first,
                    let state = placemark.administrativeArea {
                    
                    self.fetchPlacesForRegion(state)
                }
                
            })
            
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 6000, 6000)
            mapView.setRegion(region, animated: true)
            
            locationManager.stopUpdatingLocation()
            locationManager.stopMonitoringSignificantLocationChanges()
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
                let button = UIButton(type: .DetailDisclosure)
                button.addTarget(self, action: #selector(CentersViewController.onDisclosureButtonTap(_:)), forControlEvents: .TouchUpInside)
                button.tag = Int(annotation.placeId)!
                
                view.canShowCallout = true
                view.calloutOffset  = CGPoint(x: -5, y: 5)
                view.pinTintColor   = UIColor(red: 155.0/255, green: 47.0/255, blue: 245.0/255, alpha: 1.0)
                view.rightCalloutAccessoryView = button as UIView
                
            }
            
            return view
        }
        
        return nil
    }
    
    func fetchPlacesForRegion(region: String){
        
        let requestUrl = UrlFormatter.urlForCentersWithState(region)
        
        Alamofire.request(.GET, requestUrl).validate().responseJSON { response in
            switch response.result {
            
            case .Success:
                if let value = response.result.value {
                    let json: Array<JSON> = JSON(value).arrayValue
                    
                    let places = json.map({ (nucleo) -> PlaceAnnotation in
                        let id = nucleo["id"].stringValue
                        let name = nucleo["name"].stringValue
                        let address = nucleo["address"].stringValue
                        let latitude = nucleo["latitude"].doubleValue
                        let longitude = nucleo["longitude"].doubleValue
                        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        
                        return PlaceAnnotation(placeId: id, placeName: name, placeAddress: address, coordinate: coord)
                    })
                    
                    self.mapView.addAnnotations(places)
                }
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    func onDisclosureButtonTap(sender: UIButton) {
        performSegueWithIdentifier("toDetalheNucleo", sender: sender.tag)
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? DetailCenterViewController {
            viewController.centerId = sender as? Int
        }
    }

}
