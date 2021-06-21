//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation


struct WeatherCondition : Decodable {
    let icon: String

    var iconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
}
