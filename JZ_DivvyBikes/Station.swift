//
//  Station.swift
//  JZ_DivvyBikes
//
//  Created by Jingzhi Zhang on 11/4/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//

import MapKit
import AddressBook
import SwiftyJSON

class Station: NSObject, MKAnnotation {
    
    let title: String?
    let availableBikes: Int?
    let coordinate: CLLocationCoordinate2D
    let postalCode: String?
    let city:String?
    
    init(title: String, availableBikes: Int?, coordinate: CLLocationCoordinate2D, city: String?, postalCode:String?)
    {
        self.title = title
        self.availableBikes = availableBikes
        self.coordinate = coordinate
        self.city = city
        self.postalCode = postalCode
        
        super.init()
    }
    
    var subtitle: String? {
        return "available bikes: \(availableBikes!) Location: \(city!) \(postalCode!)"
        
    }

    class func from(json: JSON) -> Station?
    {
        
        var title: String
        if let unwrappedTitle = json["stationName"].string {
            title = unwrappedTitle
        } else {
            title = " "
        }
 
        
        let availableBikes = json["availableBikes"].int
        let lat = json["latitude"].doubleValue
        let long = json["longitude"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let postalCode = json["postalCode"].string
        let city = json["city"].string
        
        return Station(title: title, availableBikes: availableBikes, coordinate: coordinate, city: city, postalCode: postalCode)
    }
  
    func mapItem() -> MKMapItem
    {
        
        //let addressDictionary = [String(CNPostalAddressStreetKey): self.subtitle!]
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(subtitle)"
        
        return mapItem
    }
   
    
}
