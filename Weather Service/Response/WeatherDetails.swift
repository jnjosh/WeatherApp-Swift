//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation


struct WeatherDetails : Decodable {
    let temperature: Measurement<UnitTemperature>
    let feelsLike: Measurement<UnitTemperature>


    enum CodingKeys : String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let kelvinTemperature = try container.decode(Double.self, forKey: .temperature)
        temperature = Measurement(value: kelvinTemperature, unit: .kelvin)
        
        let kelvinFeelsLike = try container.decode(Double.self, forKey: .feelsLike)
        feelsLike = Measurement(value: kelvinFeelsLike, unit: .kelvin)
    }
}
