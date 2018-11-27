//
//  LocationHandle.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/27/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class LocationHandle: NSObject {
    
    var locationCoordinate:CLLocationCoordinate2D?
    var address:String?
    
    class func initWith(coordinate:CLLocationCoordinate2D,onComplete:@escaping (LocationHandle)->()){
        let bean = LocationHandle()
        bean.locationCoordinate = coordinate
        Location.getAddressFromCoordinate(coordinate) { (address) in
            bean.address = address
            onComplete(bean)
        }
    }
    
    class func initWith(lat:CLLocationDegrees,long:CLLocationDegrees,address:String)->LocationHandle{
        let bean = LocationHandle()
        let coordinate = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        bean.locationCoordinate = coordinate
        bean.address = address
        return bean
    }
    
}

class Location{
    
    class func getAddressFromCoordinate(_ coordinate: CLLocationCoordinate2D, onComplete completionHandler: @escaping (_ address: String?) -> Void) {
        let coder = GMSGeocoder()
        coder.reverseGeocodeCoordinate(coordinate, completionHandler: { response, err in
            if err == nil {
                let address = response?.firstResult()?.lines?.joined(separator: ",")
                completionHandler(address ?? "")
            } else {
                completionHandler("")
            }
        })
    }
}
