//
//  CentersViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 24/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import GoogleMaps

class CentersViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{

    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var googleMapView: GMSMapView!
    
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
        self.googleMapView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            googleMapView.myLocationEnabled = true
            googleMapView.settings.myLocationButton = true
            
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            
            googleMapView.myLocationEnabled = true
            googleMapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            googleMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            self.fetchPlacesNearCoordinate(location.coordinate)
            
            locationManager.stopUpdatingLocation()
            locationManager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func mapView(mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let placeMarker = marker as! PlaceMarker
        let views = NSBundle.mainBundle().loadNibNamed("MarkerInfoView", owner: nil, options: nil)
        
        print (views)
        
        if let markerView = views.first as? MarkerInfoView {
            markerView.nameLabel.text = placeMarker.nucleo.name
            markerView.placePhoto.image = UIImage(named: "health")
            
            return markerView
        }
        
        return nil
    }
    
    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D){
        self.googleMapView.clear()
        self.nucleos = DiscoveringMock.mockPlaces()
        
        for n:Nucleo in self.nucleos! {
            let marker = PlaceMarker(nucleo: n)
            marker.map = self.googleMapView
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
