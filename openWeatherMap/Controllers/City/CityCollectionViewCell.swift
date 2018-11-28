//
//  CityCollectionViewCell.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/28/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currentTempValue: UILabel?
    @IBOutlet weak var minTempValue: UILabel?
    @IBOutlet weak var maxTempValue: UILabel?
    @IBOutlet weak var pressureValue: UILabel?
    @IBOutlet weak var humidityValue: UILabel?
    
    @IBOutlet weak var currentTemp: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        currentTemp?.text = "Current Temp"
    }
    
}
