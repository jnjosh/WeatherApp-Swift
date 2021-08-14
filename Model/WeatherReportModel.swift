//
//  WeatherReportingModel.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation
import CoreLocation


@MainActor
class WeatherReportModel : ObservableObject {
    private let client: OpenWeatherMapServiceClient

    @Published var currentWeather: WeatherReportSectionModel?
    @Published var forecasts = [WeatherReportSectionModel]()


    init(client: OpenWeatherMapServiceClient) {
        self.client = client
    }


    func fetchAllReports(location: CLLocationCoordinate2D) {
        Task {
            do {
                forecasts.removeAll()
                
                // now
                let report = try await client.weather(latitude: location.latitude, longitude: location.longitude)
                self.currentWeather = WeatherReportSectionModel(date: report.date, reports: [report.model])
                
                // forecast
                let forecast = try await client.forecast(latitude: location.latitude, longitude: location.longitude)
                
                // group forecasts by date
                let initial: [Date: [WeatherReport]] = [:]
                let groupedByDateComponents = forecast.reduce(into: initial) { accumulated, current in
                    let components = Calendar.current.dateComponents([.month, .day, .year], from: current.date)
                    let date = Calendar.current.date(from: components)!
                    let existing = accumulated[date] ?? []
                    accumulated[date] = existing + [current]
                }

                // break into sections
                var sections = [WeatherReportSectionModel]()
                for (key, value) in groupedByDateComponents {
                    let models = value.map { $0.model }
                    sections.append(WeatherReportSectionModel(date: key, reports: models))
                }
                
                // sort by date
                forecasts = sections.sorted(by: { l, r in
                    l.date < r.date
                })
            }
            catch {
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
}

