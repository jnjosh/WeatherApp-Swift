//
//  WeatherReport.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation

struct WeatherReport : Decodable, Identifiable {
    let weatherDetails: WeatherDetails
    let conditions: [WeatherCondition]
    let name: String?
    let date: Date
    let id: Int


    enum CodingKeys : String, CodingKey {
        case name
        case weatherDetails = "main"
        case condition = "weather"
        case date = "dt"
        case id
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? Int(arc4random())
        weatherDetails = try container.decode(WeatherDetails.self, forKey: .weatherDetails)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        conditions = try container.decode([WeatherCondition].self, forKey: .condition)
        
        let dt = try container.decode(Double.self, forKey: .date)
        date = Date(timeIntervalSince1970: dt)
    }
}

