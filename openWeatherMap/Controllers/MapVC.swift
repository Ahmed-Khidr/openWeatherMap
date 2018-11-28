//
//  MapVC.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/26/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView?
    var marker = GMSMarker()
    var locationManager = CLLocationManager()
    weak var delegate : mapLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLocaitonManager()
    }
    func configureLocaitonManager(){
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
   
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}

extension MapVC : CLLocationManagerDelegate{
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
       
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        mapView?.camera = camera
        mapView?.settings.compassButton = true
        mapView?.settings.rotateGestures = false
        mapView?.isMyLocationEnabled = true
        
        self.mapView?.animate(to: camera)
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        updateMarker(coordinates: position.target)
    }
    func updateMarker(coordinates:CLLocationCoordinate2D){
        marker.position = coordinates
        marker.map = mapView
    }
    
}

protocol mapLocationDelegate: class {
    func didSelectNewCity(cityAddress: LocationHandle)
}

extension MapVC: GMSMapViewDelegate{
    // tab anywhere on the map
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        LocationHandle.initWith(coordinate: coordinate) { (bean) in
            self.dismiss(animated: true, completion: {
                self.delegate?.didSelectNewCity(cityAddress:bean )
            })
        }
    }
    // tab on marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        LocationHandle.initWith(coordinate: marker.position) { (bean) in
            self.dismiss(animated: true, completion: {
                self.delegate?.didSelectNewCity(cityAddress: bean)
            })
        }
        return true
    }
}
