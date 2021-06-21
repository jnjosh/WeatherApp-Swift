//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation


struct WeatherForecast : Decodable {
    let reports: [WeatherReport]


    enum CodingKeys : String, CodingKey {
        case reports = "list"
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reports = try container.decode([WeatherReport].self, forKey: .reports)
    }
}
