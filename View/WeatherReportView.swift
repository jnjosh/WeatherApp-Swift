//
//  WeatherReportView.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import SwiftUI

struct WeatherReportView {
    let report: WeatherReportViewModel
}

extension WeatherReportView : View {
    var body: some View {
        HStack(alignment: .center) {
            Text(report.hourOfDay)
                .frame(width: 50)
                .padding([.leading, .trailing], 12)
                .font(.callout)

            AsyncImage(url: report.iconURL, scale: 2) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40, alignment: .center)
            .clipped()
            
            Text(report.temperature)
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Feels like \(report.feelsLikeTemperature)")
                .font(.callout.italic())

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct WeatherReportView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherReportView(
            report: WeatherReportViewModel(
                temperature: "0º",
                city: "Raleigh",
                iconURL: nil,
                feelsLikeTemperature: "1º",
                dateTime: "Today",
                hourOfDay: "01"
            )
        )
    }
}
