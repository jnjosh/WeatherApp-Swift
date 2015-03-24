//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit
import Runes
import Argo

struct WeatherItem: JSONDecodable {
    let kelvin: Double?
    let city: String?
    
    init(kelvin: Double?, city: String?) {
        self.kelvin = kelvin;
        self.city = city
    }
    
    func fahrenheit() -> Double {
        var fahrenheit: Double = 0.0
        
        if let kelvinValue = kelvin {
            fahrenheit = 1.8 * (kelvinValue - 273.15) + 32.0
        }
        
        return fahrenheit
    }
    
    static func create(kelvin: Double?)(city: String?) -> WeatherItem {
        return WeatherItem(kelvin: kelvin, city: city)
    }
    
    static func decode(json: JSONValue) -> WeatherItem? {
        return WeatherItem.create
            <^> json <|? ["main", "temp"]
            <*> json <|? "name"
    }
}
