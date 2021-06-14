//
//  Forecast.swift
//  WeatherApp
//
//  Created by Josh Johnson on 3/23/15.
//  Copyright (c) 2015 Two Toasters, LLC. All rights reserved.
//

import Foundation
import Runes
import Argo

struct Forecast: JSONDecodable {
    let weatherItems: [ForecastItem]?
    
    init(items: [ForecastItem]?) {
        self.weatherItems = items
    }
    
    static func create(items: [ForecastItem]?) -> Forecast {
        return Forecast(items: items)
    }
    
    static func decode(json: JSONValue) -> Forecast? {
        return Forecast.create
            <^> json <||? "list"
    }
    
}


struct ForecastItem: JSONDecodable {
    let kelvin: Double?
    
    
    init(kelvin: Double?) {
        self.kelvin = kelvin
    }
    
    static func create(kelvin: Double?) -> ForecastItem {
        return ForecastItem(kelvin: kelvin)
    }
    
    static func decode(json: JSONValue) -> ForecastItem? {
        return ForecastItem.create
            <^> json <|? ["temp", "max"]
    }
    
}