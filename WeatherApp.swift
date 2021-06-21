//
//  WeatherApp.swift
//  Shared
//
//  Created by Josh Johnson on 6/15/21.
//

import SwiftUI

@main
struct WeatherApp : App {
    var body: some Scene {
        #error("To run this you'll need to acquire an API key from https://openweathermap.org")
        let openWeatherMapAPIKey = "<API KEY>"
        
        WindowGroup {
            ContentView(
                model: WeatherReportModel(
                    client: OpenWeatherMapServiceClient(
                        apiKey: openWeatherMapAPIKey
                    )
                )
            )
        }
    }
}
