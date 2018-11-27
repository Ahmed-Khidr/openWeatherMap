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


class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView?
    var newAddress = ""
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
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
            if items.count > 0 {
                cell.textLabel?.text = items[indexPath.row - 1] // (-1) first cell always add from map
            }
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openMapView()
        }else{
            
        }
    }
    
    func openMapView(){
        performSegue(withIdentifier: "toMap", sender: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap" {
            let nav = segue.destination as? UINavigationController
            let mapVC = nav?.viewControllers.first as! MapVC
            mapVC.delegate = self
        }
    }
    

}

extension HomeVC : mapLocationDelegate{
    func didSelectNewCity(addresss: String) {
        newAddress = addresss
        if newAddress != "" {
            items.append(newAddress )
        }
        self.homeTableView?.reloadData()
    }
    
    
}


