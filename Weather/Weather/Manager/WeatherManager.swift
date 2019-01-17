//
//  WeatherManager.swift
//  Weather
//
//  Created by Matheus Cavalcante Teixeira on 17/01/19.
//  Copyright © 2019 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

typealias ManagerCallback = (_ success: Bool, _ cities: ListWeather?) -> Void

class WeatherManager {
    
    let business = WeatherBusiness()
    
    func getWeathersInCircle(latitude: Double, longitude: Double, completionCallback: @escaping ManagerCallback){
        business.getWeathersInCircle(latitude: latitude, longitude: longitude) { (list, error) in
            if error == "" {
                completionCallback(true, list)
            }
        }
        
    }
    
}
