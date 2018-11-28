//
//  WebService.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/27/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

public typealias JSON = [String: Any]
/*
 
 http://api.openweathermap.org/data/2.5/forecast?lat=0&lon=0&appid=c6e381d8c7ff98f0fee4377
 5817cf6ad&units=metri
 */
class WebService: NSObject {
    
    static let baseUrl = "http://api.openweathermap.org/data/2.5/forecast?"
    static let apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
  
    class func getForcast(lat:Double,long:Double,onComplete:@escaping ([ForecastItem]?)->()){
        let url = WebService.baseUrl + "lat=\(lat)&lon=\(long)&appid=\(WebService.apiKey)&units=metri"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.isSuccess {
                if let result = response.result.value as? JSON {
                    let response = ForecastResponse(JSON: result)
                    onComplete(response?.list)
            }else{
                
            }
        }
    
    }
    
}
}
