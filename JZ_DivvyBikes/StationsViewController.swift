//
//  StationsViewController.swift
//  JZ_DivvyBikes
//
//  Created by Jingzhi Zhang on 11/4/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import CoreLocation


class StationsViewController: UIViewController {

    var stations = [Station]()
    @IBOutlet weak var zipSearchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self //as MKMapViewDelegate
        //mapView.showsUserLocation = YES
        fetchJsonData()
        //mapView.addAnnotations(stations)
        }
    
    func fetchJsonData() {
        // Fetching client list.
        let api_json_url = URL(string:"https://feeds.divvybikes.com/stations/stations.json")
        // Create a URL request with the API address
        let urlRequest = URLRequest(url: api_json_url!)
        // Submit a request to get the JSON data
        //let session = URLSession.shared
        let task = URLSession.shared.dataTask(with: urlRequest) {data,response,error in
            
            // if there is an error, print the error and do not continue
            if error != nil {
                print("Failed to parse")
                return
            }
            
            // if there is no error, fetch the json formatted content
            else{
                    let json = JSON(data:data!)
                    if let stationJSONs = json["stationBeanList"].array {
                        for stationJSON in stationJSONs {
                            if let station = Station.from(json: stationJSON) {
                                self.stations.append(station)
                                ///*
                                let annotation = MKPointAnnotation()
                                let centerCoordinate = station.coordinate
                                annotation.coordinate = centerCoordinate
                                annotation.title = station.title
                                annotation.subtitle = station.subtitle
                                self.mapView.addAnnotation(annotation)
                                //*/
                    }
                }
            }
        }// end if
    } // end getDataSession
    
    task.resume()
        

    } // end readJsonData function

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServiceAuthenticationStatus()
    }
    
    private let regionRadius: CLLocationDistance = 1000 // 1km ~ 1 mile = 1.6km
    
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - Current Location
    
    var locationManager = CLLocationManager()
    
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}



extension StationsViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
        zoomMapOn(location: location)
    }
}

extension StationsViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Station {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            return view
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! Station
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }


}
