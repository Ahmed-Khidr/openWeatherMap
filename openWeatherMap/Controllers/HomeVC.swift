//
//  HomeVC.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/26/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SVProgressHUD

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView?
    @IBOutlet weak var helpButton: UIButton?
    
    var newAddress = ""
    var Addresses = [String]()
    var cityCoordinate = CLLocationCoordinate2D()
    var cityCoordinates = [CLLocationCoordinate2D]()
    var weatherResponse = [ForecastItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpButton?.layer.cornerRadius = 0.5 * ((helpButton?.bounds.size.width)!)
        helpButton?.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeTableView?.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func helpButtonAction(_ sender: Any) {
        
    }
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addresses.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addMapCell", for: indexPath)
            cell.textLabel?.text = "Add City From Map"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = UIColor.blue
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if Addresses.count > 0 {
                cell.textLabel?.text = Addresses[indexPath.row - 1] // (-1) first cell always add from map
            }
            cell.textLabel?.numberOfLines = 2
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openMapView()
        }else{
            let selectedAddress = cityCoordinates[indexPath.row-1]
            SVProgressHUD.show()
            WebService.getForcast(lat: selectedAddress.latitude, long: selectedAddress.longitude) { (response) in
                SVProgressHUD.dismiss()
                if let weatherResult = response{
                    self.weatherResponse = weatherResult
                    self.openCity()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            Addresses.remove(at: (indexPath.row - 1))
            homeTableView?.reloadData()
        }
    }
    
    func openMapView(){
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    func openCity(){
        performSegue(withIdentifier: "toCity", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap" {
            let nav = segue.destination as? UINavigationController
            let mapVC = nav?.viewControllers.first as! MapVC
            mapVC.delegate = self
        }else if segue.identifier == "toCity"{
            let cityVC = segue.destination as? CityVC
            cityVC?.weatherResponse = weatherResponse
        }
    }
    

}


extension HomeVC : mapLocationDelegate{
    func didSelectNewCity(cityAddress: LocationHandle) {
        newAddress = cityAddress.address ?? ""
        cityCoordinate = cityAddress.locationCoordinate ?? CLLocationCoordinate2D()
        if newAddress != "" {
            Addresses.append(newAddress)
            cityCoordinates.append(cityCoordinate)
        }
        self.homeTableView?.reloadData()
    }
    
    
}


