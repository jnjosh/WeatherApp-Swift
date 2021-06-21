//
//  WeatherForecastSectionView.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import SwiftUI


struct WeatherForecastSectionView {
    let forecast: WeatherReportSectionModel
    private var isCurrent: Bool
    
    private var sectionHeaderText: String {
        return isCurrent ? "Now" : "Forecast for \(forecast.headerText)"
    }
    
    init(forecast: WeatherReportSectionModel, isCurrent: Bool = false) {
        self.forecast = forecast
        self.isCurrent = isCurrent
    }
}


extension WeatherForecastSectionView : View {
    var body: some View {
        Section(header: Text(sectionHeaderText)) {
            ForEach(forecast.reports) { report in
                WeatherReportView(report: report)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
