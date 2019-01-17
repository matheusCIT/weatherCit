//
//  WeatherProvider.swift
//  Weather
//
//  Created by Matheus Cavalcante Teixeira on 17/01/19.
//  Copyright © 2019 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

class WeatherProvider {
    
    func getWeathersInCircle(latitude: String, longitude: String, numberOfCities: String, completionCallback: @escaping (Data) -> Void) {
        var url = URLComponents(string: "http://api.openweathermap.org/data/2.5/find")
        
        url?.queryItems = [URLQueryItem(name: "lat", value: latitude),URLQueryItem(name: "lon", value: longitude), URLQueryItem(name: "cnt", value: numberOfCities), URLQueryItem(name: "APPID", value: "a348149e54afd0fcd648a55f6ae39892")]
        
        var urlRequest = URLRequest(url: (url?.url)!)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error \(error)")
                return
            }
            guard let responseData = data else {
                print("data nil")
                return
            }
            completionCallback(responseData)
        }.resume()
    }
}
