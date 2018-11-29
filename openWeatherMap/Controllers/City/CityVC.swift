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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cityCollection?.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Collection View
extension CityVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as! CityCollectionViewCell
        let oneItem = weatherResponse[indexPath.row].weather
        let oneDate = weatherResponse[indexPath.row].date
        cell.currentTempValue?.text = String(format:"%.f",(oneItem?.currentTemp)!)
        cell.minTempValue?.text = String(format:"%.f",(oneItem?.minTemp)!)
        cell.maxTempValue?.text = String(format:"%.f",(oneItem?.maxTemp)!)
        cell.pressureValue?.text = String(format:"%.f",(oneItem?.pressure)!)
        cell.humidityValue?.text = String(format:"%.f",(oneItem?.humidity)!)
        cell.dateLabel?.text = oneDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }

    // handle collectionView during orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        cityCollection?.layoutSubviews()
        if UIDevice.current.orientation.isLandscape{
            if let layout = cityCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
                
                layout.itemSize = CGSize(width: cityCollection?.frame.width ?? 0.0, height: 200)
                layout.invalidateLayout()
                
            }
            
        }else if UIDevice.current.orientation.isPortrait{
            if let layout = cityCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
                
                layout.itemSize = CGSize(width: cityCollection?.frame.width ?? 0.0, height: 200)
                layout.invalidateLayout()
                
            }
            
        }
    }
    
}
