//
//  ForecastResponse.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/28/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit
import ObjectMapper

class ForecastResponse: Mappable {
    var code : String?
    var list : [ForecastItem]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code <- map["cod"]
        list <- map["list"]
    }
}

class ForecastItem: Mappable{
    var date : String?
    var weather : Weather?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        date <- map["dt_txt"]
        weather <- map["main"]
    }
}

class Weather :Mappable{
    var currentTemp : Double?
    var minTemp : Double?
    var maxTemp : Double?
    var pressure : Double?
    var humidity : Double?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        currentTemp <- map["temp"]
        minTemp <- map["temp_min"]
        maxTemp <- map["temp_max"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
}
