//
//  WeatherReportModel.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation


struct WeatherReportViewModel : Identifiable {
    let id = UUID().uuidString
    let temperature: String
    let city: String
    let iconURL: URL?
    let feelsLikeTemperature: String
    let dateTime: String
    let hourOfDay: String
}


extension WeatherReport {
    private var formatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }


    var model: WeatherReportViewModel {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH"
        
        print(Locale.current.description)
        
        return WeatherReportViewModel(
            temperature: weatherDetails.temperature.formatted(),
            city: name ?? "",
            iconURL: conditions.first?.iconURL,
            feelsLikeTemperature: weatherDetails.feelsLike.formatted(),
            dateTime: formatter.localizedString(for: date, relativeTo: Date()),
            hourOfDay: hourFormatter.string(from: date)
        )
    }
}
