//
//  ViewController.swift
//  Weather
//
//  Created by Matheus Cavalcante Teixeira on 17/01/19.
//  Copyright © 2019 Matheus Cavalcante Teixeira. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var listWeather: ListWeather? { didSet{
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        }}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        determineMyCurrentLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let manager = WeatherManager()
        
        guard let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude else {
            print("error latitude or longitude nil")
            return
        }
        manager.getWeathersInCircle(latitude: latitude, longitude: longitude) { (sucess, list) in
            self.listWeather = list
        }
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard listWeather != nil, listWeather?.weather != nil else {
            return 0
        }
        return listWeather?.weather.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell{
            let kelvin = 273.15

            if let list = listWeather?.weather{
                cell.cityName.text = list[indexPath.row].name
                cell.temperature.text = String(list[indexPath.row].main.temp - kelvin)
                cell.weatherDescription.text = list[indexPath.row].description?[0].description
                return cell
            }
        }
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
