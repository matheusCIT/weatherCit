//
//  Weather.swift
//  Weather
//
//  Created by Matheus Cavalcante Teixeira on 17/01/19.
//  Copyright © 2019 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let name: String?
    let main: MainWeather
    let description: [WeatherDescription]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case main
        case description = "weather"
    }
}
