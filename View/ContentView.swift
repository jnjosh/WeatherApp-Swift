//
//  ContentView.swift
//  Shared
//
//  Created by Josh Johnson on 6/15/21.
//

import SwiftUI
import CoreLocation

struct ContentView : View {
    @StateObject var model: WeatherReportModel


    private func updateWeatherResults() {
        model.fetchAllReports(location: CLLocationCoordinate2D(
            latitude: 35.9940,
            longitude: -78.8986)
        )
    }

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if let weatherReport = model.currentWeather {
                        WeatherForecastSectionView(
                            forecast: weatherReport,
                            isCurrent: true
                        )
                    }
                    ForEach(model.forecasts) { forecast in
                        WeatherForecastSectionView(
                            forecast: forecast
                        )
                    }
                }
                .navigationTitle("Swift Weather")
                .listStyle(.sidebar)
            }
        }
        .refreshable { updateWeatherResults() }
        .task { updateWeatherResults() }
    }
}
