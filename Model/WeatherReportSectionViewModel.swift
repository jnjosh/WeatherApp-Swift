//
//  WeatherReportSectionViewModel.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation


struct WeatherReportSectionModel : Identifiable {
    let id = UUID().uuidString
    let date: Date
    var headerText: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    let reports: [WeatherReportViewModel]
}
