//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

class WeatherItem
{
    let kelvin: Double?
    let city: String?
    
    init(kelvinDegrees: Double, cityName: String) {
        kelvin = kelvinDegrees
        city = cityName
    }
    
    
    convenience init(temperatureDictionary: Dictionary<String, AnyObject>) {
        var mainSection: AnyObject = temperatureDictionary["main"]!
        var nameSection: AnyObject = temperatureDictionary["name"]!

        var temperature = mainSection["temp"]
        var cityName = nameSection as String
       
        let kelvinValue = temperature as? Double
        self.init(kelvinDegrees: kelvinValue!, cityName: cityName)
    }
    
    
    func fahrenheit() -> Double {
        var fahrenheit: Double = 0.0
        
        if let kelvinValue = kelvin {
            fahrenheit = 1.8 * (kelvinValue - 273.15) + 32.0
        }
        
        return fahrenheit
    }
    
}
