//
//  CityVC.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/26/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit

class CityVC: UIViewController {

    @IBOutlet weak var cityCollection: UICollectionView?
    
    var weatherResponse = [ForecastItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Collection View
extension CityVC: UICollectionViewDataSource,UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as! CityCollectionViewCell
        let oneItem = weatherResponse[indexPath.row].weather
        cell.currentTempValue?.text = String(format:"%.f",(oneItem?.currentTemp)!)
        cell.minTempValue?.text = String(format:"%.f",(oneItem?.minTemp)!)
        cell.maxTempValue?.text = String(format:"%.f",(oneItem?.maxTemp)!)
        cell.pressureValue?.text = String(format:"%.f",(oneItem?.pressure)!)
        cell.humidityValue?.text = String(format:"%.f",(oneItem?.humidity)!)
        return cell
    }
    // handle collectionView during orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = cityCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.height
            layout.itemSize = CGSize(width: width , height: 200)
            layout.invalidateLayout()
            cityCollection?.reloadData()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = cityCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.width
            layout.itemSize = CGSize(width: width , height: 200)
            layout.invalidateLayout()
            cityCollection?.reloadData()
        }
    }
    
}
