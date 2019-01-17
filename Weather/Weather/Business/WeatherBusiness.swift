//
//  WeatherBusiness.swift
//  Weather
//
//  Created by Matheus Cavalcante Teixeira on 17/01/19.
//  Copyright © 2019 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

typealias BusinessCallback = (ListWeather?, String) -> Void

class WeatherBusiness {
    
    let provider = WeatherProvider()
    
    func getWeathersInCircle(latitude: Double, longitude: Double, completionCallback: @escaping BusinessCallback){
        let numberOfCities = "10"
        
        provider.getWeathersInCircle(latitude: String(latitude), longitude: String(longitude), numberOfCities: numberOfCities) { (data) in
            do {
                let citiesWeather =  try JSONDecoder().decode(ListWeather.self, from: data)
                return completionCallback(citiesWeather, "")
            } catch {
                completionCallback(nil , error.localizedDescription)
            }
        }
    }
}
